```@meta
CurrentModule = PlotlyDocumenter
```

# PlotlyDocumenter

Documentation for [PlotlyDocumenter](https://github.com/disberd/PlotlyDocumenter.jl).

```@index
```

```@autodocs
Modules = [PlotlyDocumenter]
```

## PlotlyBase
```@example
using PlotlyDocumenter
using PlotlyBase

p = Plot(scatter(;y = rand(5)))
to_documenter(p)
```

## PlotlyLight
```@example
using PlotlyDocumenter
using PlotlyLight

p = Plot(;y = rand(5), type = "scatter")
to_documenter(p)
```