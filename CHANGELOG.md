# Changelog

## [0.1.1] - 2026-03-18

### Fixed
- Validate `surprise_level` against `SURPRISE_LEVELS` in `Observation#initialize` — raises `ArgumentError` for invalid levels

## [0.1.0] - 2026-03-13

### Added
- Initial release: Peirce abductive reasoning engine
- Observation recording, hypothesis generation, evidence evaluation
- Best explanation ranking, competing hypotheses, quality labels
- Standalone Client
