using PlotlyDocumenter
using Test
using PlotlyBase
using PlotlyLight
using PlotlyJS

@testset "PlotlyDocumenter.jl" begin
    function to_str(o) 
        io = IOBuffer()
        show(io, o)
        String(take!(io))
    end


    y = rand(4)
    p_base = PlotlyBase.Plot(scatter(;y))
    p_js = plot(y);
    p_light = PlotlyLight.Plot(;y, type="scatter")

    for p in (p_base,p_light, p_js)
        o = to_documenter(p) |> to_str
        @test contains(o, "Plotly.newPlot")
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
    end
end
