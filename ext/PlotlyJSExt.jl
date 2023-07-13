module PlotlyJSExt
    using PlotlyDocumenter
    using PlotlyJS

    function PlotlyDocumenter.to_documenter(sp::PlotlyJS.SyncPlot; kwargs...)
        p = sp.plot
        return PlotlyDocumenter.to_documenter(p; kwargs...) # Reuse the PlotlyBase method
    end
end