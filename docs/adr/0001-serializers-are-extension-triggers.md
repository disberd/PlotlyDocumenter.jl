# 1. Serializers are extension triggers

Date: 2026-07-28

## Status

Accepted

## Context

Each plotting backend is serialized to JSON before being embedded in a page.
The extensions used to reach that serializer through the plotting package —
`json` re-exported by PlotlyBase, and `PlotlyLight.JSON3`. Neither is part of
those packages' public interface, and the PlotlyBase route broke outright when
JSON v1 removed `json` from its export list, leaving PlotlyBase re-exporting a
name that no longer exists.

Naming a serializer directly requires deciding where the dependency sits, and
which serializer each extension uses:

- PlotlyBase lowers its own types onto `JSON.lower`, so its plots must be
  written with JSON. PlotlyLight's structures are `AbstractDict`s that either
  serializer handles.
- PlotlyJS depends on WebIO, whose compat is `JSON = "0.18-0.21"`. An
  environment cannot hold both PlotlyJS and JSON v1; the resolver rejects it.
  Requiring JSON v1 would therefore drop PlotlyJS support entirely.
- A hard dependency on both serializers would install them for every user,
  including those who only ever load one backend.

## Decision

JSON and JSON3 are weak dependencies that also act as extension triggers:
`PlotlyBaseExt = ["PlotlyBase", "JSON"]` and
`PlotlyLightExt = ["PlotlyLight", "JSON3"]`.

Each plotting package already loads the serializer its extension names, so the
trigger is satisfied without the user ever installing or naming a serializer,
and neither appears in their environment.

JSON is bounded at `"0.21, 1"` so PlotlyJS stays installable. The two majors
differ in how they treat non-finite numbers, so `ext/PlotlyBaseExt.jl` selects
the call at load time; both produce `null`.

## Consequences

Extension loading now depends on the plotting package continuing to depend on
its serializer. If PlotlyBase stopped depending on JSON, `PlotlyBaseExt` would
silently not load and `to_documenter` would report that the plot type has no
associated method. This is accepted because PlotlyBase registers its lowering
methods on JSON, so such a move would break the extension under any of the
alternatives too.

The two backends encode non-finite values differently — `null` for PlotlyBase,
the `NaN` literal for PlotlyLight, because JSON3 has no option to write `null`
instead. Plotly reads both as a break in a line, so the rendered result matches.

The default test environment excludes PlotlyJS in order to resolve JSON v1;
covering the 0.21 branch takes a second environment in CI.
