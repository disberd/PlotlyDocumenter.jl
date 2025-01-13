# Usage with DocumenterVitepress

PlotlyDocumenter provides an extension to work with DocumenterVitepress. As raw javascript code cannot be executed in Vue, an alternate approach is required.
For this reason, when using DocumenterVitepress, the custom plot object will be rendered as the `<VuePlotly/>` component.

!!! warning
    The keyword arguments for `to_documenter` are ignored when using DocumenterVitepress.

To make this work, first install the `plotly.js-dist-min` package and associated types `@types/plotly.js-dist-min` in your project:

```bash
npm install plotly.js-dist-min
npm install --save-dev @types/plotly.js-dist-min
```

Then, in your `docs/src/components` directory create a file called `PlotlyWrapper.vue` with the following content:

```typescript
<template>
    <div ref="divRef" :id="plotlyId"></div>
</template>

<script setup lang="ts">
import { onBeforeUnmount, ref, watchEffect } from 'vue'
import type { Data, Layout, Config } from 'plotly.js-dist-min'

const props = defineProps<{
    data?: Plotly.Data[]
    layout?: Partial<Plotly.Layout>
    config?: Partial<Plotly.Config>
}>();

const randomString = Math.random().toString(36).slice(2, 7);
const plotlyId = ref<string>(`plotly-${randomString}`);
const divRef = ref<Plotly.PlotlyHTMLElement>();

defineExpose({ plotlyId });

function debounce<Params extends any[]>(
    func: (...args: Params) => any,
    timeout: number
): (...args: Params) => void {
    let timer: NodeJS.Timeout
    return (...args: Params) => {
        clearTimeout(timer)
        timer = setTimeout(() => {
            func(...args)
        }, timeout)
    }
}

// SSR check - everything after this will only run on the client
if (typeof window == 'undefined') return;

const Plotly = await import('plotly.js-dist-min');

let isCreated = false

function resize() {
    Plotly.Plots.resize(divRef.value as Plotly.Root)
}

const resizeObserver = new ResizeObserver(debounce(resize, 50))

watchEffect(async () => {
    const data = props.data ? props.data : []
    const div = divRef.value as Plotly.Root
    if (isCreated) {
        Plotly.react(div, data, props.layout, props.config)
    } else if (div) {
        await Plotly.newPlot(div, data, props.layout, props.config)
        resizeObserver.observe(div as Plotly.PlotlyHTMLElement)
        isCreated = true
    }
})

onBeforeUnmount(() => {
    resizeObserver.disconnect()
    Plotly.purge(divRef.value as Plotly.Root)
})
</script>
```

and a component called `VuePlotly.vue` with the following content:

```typescript
<template>
    <Suspense>
        <VuePlotly
            :data="props.data"
            :layout="props.layout"
            :config="props.config"
        />
        <template #fallback>
            <div>Loading plot...</div>
        </template>
    </Suspense>
</template>

<script setup lang="ts">
import VuePlotly from './PlotlyWrapper.vue'
import type { Data, Layout, Config } from 'plotly.js-dist-min'

const props = defineProps<{
    data?: Data[]
    layout?: Partial<Layout>
    config?: Partial<Config>
}>()
</script> 
```

Finally, in your `docs/src/.vitepress/theme/index.ts` file, add the following code:
```typescript
import VuePlotly from "../../components/VuePlotly.vue"

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

## Explanation

Due to SSR requirements of vitepress, we have to import plotly.js dynamically. This is done in the `PlotlyWrapper.vue` component.
Since this dynamic import requires a suspense boundary, this boundary is provided by the `VuePlotly.vue` component, which simply wraps the `PlotlyWrapper.vue` component.
