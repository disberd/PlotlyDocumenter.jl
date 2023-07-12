using PlotlyDocumenter
using Documenter

DocMeta.setdocmeta!(PlotlyDocumenter, :DocTestSetup, :(using PlotlyDocumenter); recursive=true)

makedocs(;
    modules=[PlotlyDocumenter],
    authors="Alberto Mengali <disberd@gmail.com>",
    repo="https://github.com/disberd/PlotlyDocumenter.jl/blob/{commit}{path}#{line}",
    sitename="PlotlyDocumenter.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)
