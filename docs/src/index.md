```@meta
CurrentModule = PlotlyDocumenter
```

# PlotlyDocumenter

Documentation for [PlotlyDocumenter](https://github.com/disberd/PlotlyDocumenter.jl).

This package provides a function `to_documenter` that returns a wrapped plot object. This object will be rendered interactively by Documenter.
If you are using DocumenterVitepress, see [here](vitepress.md) for more information.

!!! note
    To prevent `to_documenter` from showing up in the documentation, add `#hide` to the end of the line.
    See [Documenter.jl](https://documenter.juliadocs.org/stable/man/syntax/#reference-at-example) for more information.

## API
```@autodocs
Modules = [PlotlyDocumenter]
```

## Examples
### PlotlyBase
```@example
using PlotlyDocumenter
using PlotlyBase

p = Plot(scatter(;y = rand(5)))
to_documenter(p)
```

### PlotlyJS
```@example
using PlotlyDocumenter
using PlotlyJS

p = plot(scatter(;y = rand(5)), Layout(height = 700))
to_documenter(p)
```

### PlotlyLight
```@example
using PlotlyDocumenter
using PlotlyLight

p = Plot(;y = rand(5), type = "scatter")
to_documenter(p)
```