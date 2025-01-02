module PlotlyBaseExt
    using PlotlyDocumenter
    using PlotlyBase

    function PlotlyDocumenter.to_documenter(p::PlotlyBase.Plot; kwargs...)
        data = json(p.data)
        layout = json(p.layout)
        config = json(p.config)
        return PlotlyDocumenterPlot(data, layout, config, kwargs...)
    end
end