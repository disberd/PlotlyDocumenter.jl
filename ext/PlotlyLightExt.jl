module PlotlyLightExt
    using HypertextLiteral
    using PlotlyDocumenter
    using PlotlyLight
    import PlotlyLight.JSON3
    
    const settings = PlotlyLight.DEFAULT_SETTINGS

    function PlotlyDocumenter.to_documenter(p::PlotlyLight.Plot; kwargs...)
        data = JSON3.write(p.data)
        layout = JSON3.write(merge(settings.layout, p.layout))
        config = JSON3.write(merge(settings.config, p.config))
        return PlotlyDocumenter._to_documenter(;kwargs..., data, layout, config)
    end
end