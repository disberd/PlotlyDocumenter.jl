module DocumenterVitepressPlotsExt

using Documenter
using DocumenterVitepress
using HypertextLiteral
using PlotlyDocumenter

DocumenterVitepress.mime_priority(::MIME"text/vnd.plotlydocumenter.plot") = 2.5;
DocumenterVitepress.render_mime(io::IO, mime::MIME"text/vnd.plotlydocumenter.plot", node, element, page, doc; kwargs...) = println(io, element)

function Documenter.display_dict(x::PlotlyDocumenterPlot; context = nothing)
    base_dict = invoke(Documenter.display_dict, Tuple{Any}, x; context)
    rendered = @htl("""
    <VuePlotly
    :data="$(x.data)"
    :layout="$(x.layout)"
    :config="$(x.config)"	
    />
    """)
    base_dict[MIME"text/vnd.plotlydocumenter.plot"()] = repr(MIME"text/html"(), rendered, context = context)
    return base_dict
end

end
