module PlotlyLightExt
    using HypertextLiteral
    using PlotlyDocumenter
    using PlotlyLight
    using JSON3

    # JSON3 rejects non-finite numbers unless `allow_inf` is set. It writes them
    # as the JavaScript literals `NaN`/`Infinity`, which Plotly reads as a break
    # in a line -- the same meaning `null` carries on the PlotlyBase side.
    write_json(x) = JSON3.write(x; allow_inf = true)

    function PlotlyDocumenter.to_documenter(p::PlotlyLight.Plot; kwargs...)
        data = write_json(p.data)
        layout = write_json(merge(PlotlyLight.settings.layout, p.layout))
        config = write_json(merge(PlotlyLight.settings.config, p.config))
        return PlotlyDocumenterPlot(data, layout, config, kwargs...)
    end
end
