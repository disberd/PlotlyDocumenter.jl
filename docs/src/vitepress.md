# Usage with DocumenterVitepress

PlotlyDocumenter provides an extension to work with DocumenterVitepress. As raw javascript code cannot be executed in Vue, an alternate approach is required.
For this reason, when using DocumenterVitepress, the custom plot object will be rendered as the `<VuePlotly/>` component from the [vue3-plotly-ts](https://github.com/boscoh/vue3-plotly-ts) package.

!!! warning
    The keyword arguments for `to_documenter` are ignored when using DocumenterVitepress.

To make this work, first install the `vue3-plotly-ts` package in your project:

```bash
npm install vue3-plotly-ts
```

Then, add the `VuePlotly` component to your `.vitepress/theme/index.ts` file:

```typescript
import VuePlotly from "vue3-plotly-ts"

export default {
...
enhanceApp({ app, router, siteData }) {
    ...
    app.component('VuePlotly', VuePlotly);
    ...
}
} satisfies Theme
```
In your `make.jl`, make sure you call `using PlotlyDocumenter` before `makedocs`.
	