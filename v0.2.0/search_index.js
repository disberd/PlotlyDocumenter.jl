var documenterSearchIndex = {"docs":
[{"location":"vitepress/#Usage-with-DocumenterVitepress","page":"DocumenterVitepress","title":"Usage with DocumenterVitepress","text":"","category":"section"},{"location":"vitepress/","page":"DocumenterVitepress","title":"DocumenterVitepress","text":"PlotlyDocumenter provides an extension to work with DocumenterVitepress. As raw javascript code cannot be executed in Vue, an alternate approach is required. For this reason, when using DocumenterVitepress, the custom plot object will be rendered as the <VuePlotly/> component from the vue3-plotly-ts package.","category":"page"},{"location":"vitepress/","page":"DocumenterVitepress","title":"DocumenterVitepress","text":"warning: Warning\nThe keyword arguments for to_documenter are ignored when using DocumenterVitepress.","category":"page"},{"location":"vitepress/","page":"DocumenterVitepress","title":"DocumenterVitepress","text":"To make this work, first install the vue3-plotly-ts package in your project:","category":"page"},{"location":"vitepress/","page":"DocumenterVitepress","title":"DocumenterVitepress","text":"npm install vue3-plotly-ts","category":"page"},{"location":"vitepress/","page":"DocumenterVitepress","title":"DocumenterVitepress","text":"Then, add the VuePlotly component to your .vitepress/theme/index.ts file:","category":"page"},{"location":"vitepress/","page":"DocumenterVitepress","title":"DocumenterVitepress","text":"import VuePlotly from \"vue3-plotly-ts\"\n\nexport default {\n...\nenhanceApp({ app, router, siteData }) {\n    ...\n    app.component('VuePlotly', VuePlotly);\n    ...\n}\n} satisfies Theme","category":"page"},{"location":"vitepress/","page":"DocumenterVitepress","title":"DocumenterVitepress","text":"In your make.jl, make sure you call using PlotlyDocumenter before makedocs.","category":"page"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = PlotlyDocumenter","category":"page"},{"location":"#PlotlyDocumenter","page":"Home","title":"PlotlyDocumenter","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for PlotlyDocumenter.","category":"page"},{"location":"","page":"Home","title":"Home","text":"This package provides a function to_documenter that returns a wrapped plot object. This object will be rendered interactively by Documenter. If you are using DocumenterVitepress, see here for more information.","category":"page"},{"location":"","page":"Home","title":"Home","text":"note: Note\nTo prevent to_documenter from showing up in the documentation, add #hide to the end of the line. See Documenter.jl for more information.","category":"page"},{"location":"#API","page":"Home","title":"API","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Modules = [PlotlyDocumenter]","category":"page"},{"location":"#PlotlyDocumenter.PlotlyDocumenterPlot","page":"Home","title":"PlotlyDocumenter.PlotlyDocumenterPlot","text":"PlotlyDocumenterPlot\n\nA wrapper type for Plotly plot data that enables flexible rendering in different contexts.\n\nThe plot data is stored as strings containing the JSON representation of the plot's data, layout and config.\n\nThe options field contains rendering options that control how the plot is displayed. For the default  text/html MIME output, see to_documenter for more information.\n\n\n\n\n\n","category":"type"},{"location":"#PlotlyDocumenter.change_default_plotly_version-Tuple{Any}","page":"Home","title":"PlotlyDocumenter.change_default_plotly_version","text":"change_default_plotly_version(version::String)\n\nChange the plotly version that is used by default to render Plotly plots using to_documenter\n\n\n\n\n\n","category":"method"},{"location":"#PlotlyDocumenter.to_documenter-Tuple{P} where P","page":"Home","title":"PlotlyDocumenter.to_documenter","text":"to_documenter(p::P; id, version)\n\nTake a plot object p and returns an output that is showable as HTML inside pages generated from Documenter.jl. This function currently works correctly inside @example blocks from Documenter.jl if called as last statement/command. Check the package documentation for seeing it in action.\n\nThe object returned as output, when shown as text/html, will generate a plotly plot can be interacted with directly in the documentation page.\n\nThis package supports the following types as P:\n\nPlot from PlotlyBase\nSyncPlot from PlotlyBase\nPlot from PlotlyLight\n\nKeyword Arguments\n\nid: The id to be given to the div containing the plot. Defaults to a random string of 10 alphanumeric characters\nversion: Version of plotly.js to use. Defaults to version 2.24.2, but can be overridden by providing version as a string. To change the default version, use the unexported change_default_plotly_version function.\nclasses: A Vector of Strings representing classes to assign the div containing the plot. Defaults to an empty vector\nstyle: An object containing a list of styles that are applied inline to the plot object. Defaults to an empty NTuple. Supports the synthax of HypertextLiteral\n\nNotes\n\nThe package does not reexport any plotting packages, so the desired plotting package must be brought in to scope independently.\nThe package currently only supports fetching the plotly library from CDN, so it does not support local version of Plotly (even though they are supported by PlotlyLight for example)\n\n\n\n\n\n","category":"method"},{"location":"#Examples","page":"Home","title":"Examples","text":"","category":"section"},{"location":"#PlotlyBase","page":"Home","title":"PlotlyBase","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"using PlotlyDocumenter\nusing PlotlyBase\n\np = Plot(scatter(;y = rand(5)))\nto_documenter(p)","category":"page"},{"location":"#PlotlyJS","page":"Home","title":"PlotlyJS","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"using PlotlyDocumenter\nusing PlotlyJS\n\np = plot(scatter(;y = rand(5)), Layout(height = 700))\nto_documenter(p)","category":"page"},{"location":"#PlotlyLight","page":"Home","title":"PlotlyLight","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"using PlotlyDocumenter\nusing PlotlyLight\n\np = Plot(;y = rand(5), type = \"scatter\")\nto_documenter(p)","category":"page"}]
}
