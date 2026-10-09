# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.3.1] - 2026-10-09

### Changed

- PlotlyBase 0.9 and 0.10 are now supported.

## [0.3.0] - 2026-07-28

### Fixed

- `to_documenter` works again for PlotlyBase plots under JSON v1, which no longer exports the `json` function PlotlyBase re-exported.
- Non-finite values in plot data no longer abort serialization. They are written as `null` for PlotlyBase and as the `NaN` literal for PlotlyLight; Plotly reads either as a break in a line.
- Labels containing `</script>` or `<!--` no longer raise an error when the plot is shown.

### Changed

- Julia 1.10 or newer is now required.
- All weak dependencies carry compat bounds.

### Removed

- The `PackageExtensionCompat` dependency, made redundant by native package extensions.

## [0.2.0] - 2025-01-02

### Added

- DocumenterVitepress extension to circumvent the limitation of raw javascript code in Vue.

### Changed

- The `to_documenter` function no longer directly returns HTML, but rather an object for which `Base.show(::MIME"text/html")` is defined.
