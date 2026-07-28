module PlotlyBaseExt
    using PlotlyDocumenter
    using PlotlyBase
    using JSON

    # JSON v1 refuses non-finite numbers unless `allownan` is set, and spells them
    # `NaN`/`Infinity`; JSON 0.21 takes no such options and writes `null` already.
    # Both branches must yield `null`: Plotly reads it as a break in a line, which
    # is what a non-finite separator inside a trace means.
    const JSON_V1 = pkgversion(JSON) >= v"1"

    write_json(x) = JSON_V1 ?
        JSON.json(x; allownan = true, nan = "null", inf = "null", ninf = "null") :
        JSON.json(x)

    function PlotlyDocumenter.to_documenter(p::PlotlyBase.Plot; kwargs...)
        data = write_json(p.data)
        layout = write_json(p.layout)
        config = write_json(p.config)
        return PlotlyDocumenterPlot(data, layout, config, kwargs...)
    end
end
