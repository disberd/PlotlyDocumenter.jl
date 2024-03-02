using PlotlyDocumenter
using PlotlyDocumenter: change_default_plotly_version, DEFAULT_VERSION
using Test
import PlotlyBase
import PlotlyLight
import PlotlyJS

@testset "PlotlyDocumenter.jl" begin
    function to_str(o) 
        io = IOBuffer()
        show(io, o)
        String(take!(io))
    end


    y = rand(4)
    p_base = PlotlyBase.Plot(PlotlyBase.scatter(;y))
    p_js = PlotlyJS.plot(y);
    p_light = PlotlyLight.Plot(;y, type="scatter")

    for p in (p_base,p_light, p_js)
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
