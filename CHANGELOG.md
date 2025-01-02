# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2025-01-02

### Added

- DocumenterVitepress extension to circumvent the limitation of raw javascript code in Vue.

### Changed

- The `to_documenter` function no longer directly returns HTML, but rather an object for which `Base.show(::MIME"text/html")` is defined.
