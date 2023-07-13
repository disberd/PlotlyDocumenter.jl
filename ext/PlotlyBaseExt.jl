module PlotlyBaseExt
    using PlotlyDocumenter
    using PlotlyBase

    function PlotlyDocumenter.to_documenter(p::Plot; kwargs...)
        data = json(p.data)
        layout = json(p.layout)
        config = json(p.config)
        return PlotlyDocumenter._to_documenter(;kwargs..., data, layout, config)
    end
end