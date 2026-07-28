using PlotlyDocumenter
using PlotlyDocumenter: change_default_plotly_version, DEFAULT_VERSION
using Test
import PlotlyBase
import PlotlyLight

# PlotlyJS pins JSON to 0.21 through WebIO, so it is kept out of the default
# test environment to leave the JSON v1 path reachable. CI installs it into a
# second environment, where these same tests then cover the 0.21 path.
const HAS_PLOTLYJS = Base.identify_package("PlotlyJS") !== nothing
HAS_PLOTLYJS && @eval import PlotlyJS

to_str(o) = repr(MIME"text/html"(), o)

@testset "PlotlyDocumenter.jl" begin
    y = rand(4)
    plots = Any[
        PlotlyBase.Plot(PlotlyBase.scatter(; y)),
        PlotlyLight.Plot(PlotlyLight.Config(; y, type = "scatter")),
    ]
    HAS_PLOTLYJS && push!(plots, PlotlyJS.plot(y))

    for p in plots
        change_default_plotly_version(DEFAULT_VERSION)
        o = to_documenter(p) |> to_str
        @test contains(o, "Plotly.newPlot")
        @test contains(o, "@$DEFAULT_VERSION")
        id = "abcdefghil"
        o = to_documenter(p; id) |> to_str
        @test contains(o, "id='$id'")
        version = "1.6.0"
        o = to_documenter(p; version) |> to_str
        @test contains(o, "@$version")
        o = to_documenter(p; classes = ["asd", "lol"]) |> to_str
        @test contains(o, "class='asd lol'")
        o = to_documenter(p; style = (;min_height = "500px", color = "red")) |> to_str
        @test contains(o, "style='min-height: 500px; color: red;'")

        change_default_plotly_version(version)
        o = to_documenter(p) |> to_str
        @test contains(o, "@$version")
    end
end

@testset "non-finite values" begin
    y = [1.0, 2.0, NaN, 4.0]

    # Plotly breaks the line on `null`, which is what JSON writes here.
    o = to_documenter(PlotlyBase.Plot(PlotlyBase.scatter(; y))) |> to_str
    @test contains(o, "null")
    @test !contains(o, "NaN")

    # JSON3 has no equivalent option, so the PlotlyLight side emits the
    # JavaScript `NaN` literal, which breaks the line just the same.
    o = to_documenter(PlotlyLight.Plot(PlotlyLight.Config(; y, type = "scatter"))) |> to_str
    @test contains(o, "NaN")
end

@testset "script-terminating labels" begin
    for title in ("</script>", "<!--")
        p = PlotlyBase.Plot(PlotlyBase.scatter(y = [1.0, 2.0]), PlotlyBase.Layout(; title))
        o = to_documenter(p) |> to_str
        @test contains(o, "\\u003c")
        # The only unescaped `</script>` left is the one closing the element.
        @test count("</script>", o) == 1
    end
end
