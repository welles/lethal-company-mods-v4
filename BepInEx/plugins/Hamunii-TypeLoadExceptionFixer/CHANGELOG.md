# Changelog

## [1.0.4] - 2025-10-10

### Changed

- Removed redundant code

## [1.0.3] - 2025-10-09

### Changed

- Updated readme

## [1.0.2] - 2025-10-9

### Added

- `Assembly.GetTypes` hook was added back because it probably fixes more issues than it creates

## [1.0.1] - 2025-10-9

### Fixed

- ILHook moved into a preloader patcher so it's always early enough because mods can cause InputManager to initalize early

### Changed

- Removed hook which makes `Assembly.GetTypes` never throw as it can cause unintended consequences maybe?
  - A local version of this hook was implemented for `InputManager.RegisterCustomTypes`

## [1.0.0] - 2025-10-08

### Added

- Everything
