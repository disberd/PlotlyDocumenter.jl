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

const PLOTLY_VERSION = Ref(try
    latest_plotlyjs_version()
catch
    v"2.24.2"
end)

change_default_plotly_version!(v) = PLOTLY_VERSION[]  = VersionNumber(v)

function _to_documenter(;data, layout, config, version = PLOTLY_VERSION[], id = randstring(10), classes = [], style = (;))
    js = HypertextLiteral.JavaScript
    v = js(string(version))
    data = js(data)
    layout = js(layout)
    config = js(config)
    return @htl("""
    <div id=$id class=$classes style=$style></div>
    <script>
    (async function() {
        const {default: Plotly} = await import("https://esm.sh/plotly.js-dist-min@$v")
        Plotly.newPlot($(js(id)), $data, $layout, $config)
    })()
    </script>
    <style>
        div #$id {
            min-height: 500px;
        }
    </style>
    """)
end

# Define the function name. Methods are added in the extension packages
"""
    to_documenter(p::P; id, version)
Take a plot object `p` and returns an output that is showable as HTML inside pages generated from Documenter.jl

This package supports the following types as `P`:
- `Plot` from PlotlyBase
- `Plot` from PlotlyLight

# Keyword Arguments
- `id`: The id to be given to the div containing the plot. Defaults to a random string of 10 alphanumeric characters
- `version`: Version of plotly.js to use. Defaults to the latest plotly version
- `classes`: A Vector of Strings representing classes to assign the div containing the plot. Defaults to an empty vector
- `style`: An object containing a list of styles that are applied inline to the plot object. Supports the synthax of [HypertextLiteral](https://juliapluto.github.io/HypertextLiteral.jl/stable/attribute/#Pairs-and-Dictionaries)

The package does not reexport any plotting packages, so the desired plotting
package must be brought in to scope independently.
"""
function to_documenter(x::P) where P
    error("The provided plot type $P does not have an associated method.
    Remember to also import the plotly plotting package of your choice.")
end

function __init__()
    @require_extensions
end

end
