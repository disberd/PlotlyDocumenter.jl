module PlotlyDocumenter

using PackageExtensionCompat
using HypertextLiteral
using Random
using Downloads: download

export to_documenter

# Taken from PlotlyLight
get_semver(x) = VersionNumber(match(r"v(\d+)\.(\d+)\.(\d+)", x).match[2:end])

# Taken from PlotlyLight
function latest_plotlyjs_version()
    file = download("https://github.com/plotly/plotly.js/releases/latest")
    get_semver(read(file, String))
end

const DEFAULT_VERSION = v"2.24.2"
const PLOTLY_VERSION = Ref(DEFAULT_VERSION)

"""
    change_default_plotly_version(version::String)
Change the plotly version that is used by default to render Plotly plots using [`to_documenter`](@ref)
"""
change_default_plotly_version(v) = PLOTLY_VERSION[]  = VersionNumber(string(v))

function _to_documenter(;data, layout, config, version = PLOTLY_VERSION[], id = randstring(10), classes = [], style = (;))
    js = HypertextLiteral.JavaScript
    v = js(string(version))
    plot_obj = (;
        data = js(data),
        layout = js(layout),
        config = js(config),
    )
    return @htl("""
    <div id=$id class=$classes style=$style></div>
    <script type="module">
        import Plotly from "https://esm.sh/plotly.js-dist-min@$v"
        const PLOT = document.getElementById($(id))
        const plot_obj = $plot_obj
        Plotly.newPlot(PLOT, plot_obj)

        // If width is not specified, set it to 100%
        PLOT.style.width = plot_obj.layout.width ? "" : "100%"
        
        // For the height we have to also put a fixed value in case the plot is put on a non-fixed-size container (like the default wrapper)
        PLOT.style.height = plot_obj.layout.height ? "" : "100%"
    </script>
    """)
end

# Define the function name. Methods are added in the extension packages
"""
    to_documenter(p::P; id, version)
Take a plot object `p` and returns an output that is showable as HTML inside pages generated from Documenter.jl.
This function currently works correctly inside `@example` blocks from Documenter.jl if called as last statement/command.
Check the package [documentation](https://disberd.github.io/PlotlyDocumenter.jl) for seeing it in action.

The object returned as output, when shown as `text/html`, will generate a plotly plot can be interacted with directly in the documentation page.

This package supports the following types as `P`:
- `Plot` from PlotlyBase
- `SyncPlot` from PlotlyBase
- `Plot` from PlotlyLight

# Keyword Arguments
- `id`: The id to be given to the div containing the plot. Defaults to a random string of 10 alphanumeric characters
- `version`: Version of plotly.js to use. Defaults to version \
$(DEFAULT_VERSION), but can be overridden by providing `version` as a string. To \
change the default version, use the unexported `change_default_plotly_version` \
function.
- `classes`: A Vector of Strings representing classes to assign the div containing the plot. Defaults to an empty vector
- `style`: An object containing a list of styles that are applied inline to the \
plot object. Defaults to an empty NTuple. Supports the synthax of \
[HypertextLiteral](https://juliapluto.github.io/HypertextLiteral.jl/stable/attribute/#Pairs-and-Dictionaries)

# Notes
- The package does not reexport any plotting packages, so the desired plotting package must be brought in to scope independently.
- The package currently only supports fetching the plotly library from CDN, so \
it does not support local version of Plotly (even though they are supported by \
PlotlyLight for example)
"""
function to_documenter(x::P) where P
    error("The provided plot type $P does not have an associated method.
    Remember to also import the plotly plotting package of your choice.")
end

function __init__()
    @require_extensions
end

end
