using PlotlyDocumenter
using Test
using PlotlyBase
using PlotlyLight

@testset "PlotlyDocumenter.jl" begin
    function to_str(o) 
        io = IOBuffer()
        show(io, o)
        String(take!(io))
    end


    y = rand(4)
    p_base = PlotlyBase.Plot(scatter(;y))
    p_light = PlotlyLight.Plot(;y, type="scatter")

    for p in (p_base,p_light)
        o = to_documenter(p) |> to_str
        @test contains(o, "Plotly.newPlot")
        id = "abcdefghil"
        o = to_documenter(p; id) |> to_str
        @test contains(o, "id='$id'")
        version = "1.6.0"
        o = to_documenter(p; version) |> to_str
        @test contains(o, "@$version")
    end
end
