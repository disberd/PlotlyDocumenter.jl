using PlotlyDocumenter
using Documenter
using PlotlyBase
using PlotlyLight

@info methods(to_documenter)


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

# This controls whether or not deployment is attempted. It is based on the value
# of the `SHOULD_DEPLOY` ENV variable, which defaults to the `CI` ENV variables or
# false if not present.
should_deploy = get(ENV,"SHOULD_DEPLOY", get(ENV, "CI", "") === "true")

if should_deploy
    @info "Deploying"

deploydocs(
    repo = "github.com/disberd/PlotlyDocumenter.jl.git",
)

end