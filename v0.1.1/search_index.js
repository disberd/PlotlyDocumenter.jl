var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = PlotlyDocumenter","category":"page"},{"location":"#PlotlyDocumenter","page":"Home","title":"PlotlyDocumenter","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for PlotlyDocumenter.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [PlotlyDocumenter]","category":"page"},{"location":"#PlotlyDocumenter.to_documenter-Tuple{P} where P","page":"Home","title":"PlotlyDocumenter.to_documenter","text":"to_documenter(p::P; id, version)\n\nTake a plot object p and returns an output that is showable as HTML inside pages generated from Documenter.jl. This function currently works correctly inside @example blocks from Documenter.jl if called as last statement/command. Check the package documentation for seeing it in action.\n\nThe object returned as ouptut will generate an plotly plot directly in HTML that is interactable from the documentation page.\n\nThis package supports the following types as P:\n\nPlot from PlotlyBase\nSyncPlot from PlotlyBase\nPlot from PlotlyLight\n\nKeyword Arguments\n\nid: The id to be given to the div containing the plot. Defaults to a random string of 10 alphanumeric characters\nversion: Version of plotly.js to use. Defaults to the latest plotly version\nclasses: A Vector of Strings representing classes to assign the div containing the plot. Defaults to an empty vector\nstyle: An object containing a list of styles that are applied inline to the plot object. Defaults to an empty NTuple. Supports the synthax of HypertextLiteral\n\nNotes\n\nThe package does not reexport any plotting packages, so the desired plotting package must be brought in to scope independently.\nThe package currently only supports fetching the plotly library from CDN, so it does not support local version of Plotly (even though they are supported by PlotlyLight for example)\n\n\n\n\n\n","category":"method"},{"location":"#PlotlyBase","page":"Home","title":"PlotlyBase","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"using PlotlyDocumenter\nusing PlotlyBase\n\np = Plot(scatter(;y = rand(5)))\nto_documenter(p)","category":"page"},{"location":"#PlotlyJS","page":"Home","title":"PlotlyJS","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"using PlotlyDocumenter\nusing PlotlyJS\n\np = plot(scatter(;y = rand(5)), Layout(height = 700))\nto_documenter(p)","category":"page"},{"location":"#PlotlyLight","page":"Home","title":"PlotlyLight","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"using PlotlyDocumenter\nusing PlotlyLight\n\np = Plot(;y = rand(5), type = \"scatter\")\nto_documenter(p)","category":"page"}]
}