# Goose snap architecture

This repository packages the Goose CLI and Electron desktop application from
the same upstream release as one classic, amd64 snap based on core24.

## CI and release flow

`build.yml` is the entrypoint. It routes branch builds to `latest/edge` and
tag builds to `latest/candidate`, then delegates to `tasteful-crafts.yml`.

| Workflow                | Purpose                                            |
| ----------------------- | -------------------------------------------------- |
| `snapcraft-pack.yml`    | Build the amd64 snap and upload the artifact       |
| `spread.yml`            | Run smoke tests through image-garden               |
| `snapcraft-upload.yml`  | Publish an artifact to the resolved latest channel |
| `snapcraft-promote.yml` | Promote candidate revisions to beta or stable      |
| `release.yml`           | Validate tags and create GitHub release notes      |

Build, test, and promotion jobs use `zyga/setup-pkgproxy@v1` to cache package
and snap downloads. Publishing jobs read `SNAPCRAFT_STORE_CREDENTIALS` from a
GitHub environment named after their destination channel.

Only the `latest` Snap Store track is supported. Pull requests build and test
but never publish. Skipping Spread tests is available only through manual
dispatch; the publishing environment remains the approval boundary.

## Packaging

The important parts in `snap/snapcraft.yaml` are:

| Part                  | Purpose                                               |
| --------------------- | ----------------------------------------------------- |
| `launcher`            | Install the Electron launcher                         |
| `goose-cli`           | Build the Rust CLI with the upstream Hermit toolchain |
| `goose-desktop`       | Build and package the Electron desktop application    |
| `goose-configuration` | Generate shell completions                            |

The `goose` app launches the desktop application through
`snap/local/desktop-launch`; `goose.cli` exposes the CLI. The desktop app is
part of the snap, not a snap component.

## Testing

Spread discovers the systems from `spread.yaml` and runs the tasks under
`tests/smoke/` on Ubuntu 24.04, Ubuntu 26.04, Debian 13, and Fedora 43.

- `goose-cli` verifies installation, help output, and the packaged version.
- `desktop-launcher` verifies the launcher and Electron binary paths.

Keep the expected CLI version synchronized with the upstream `source-tag`.
Renovate manages both values through `renovate.json`.

## Scope

- Architecture: amd64 only
- Base: core24
- Confinement: classic
- Store track: latest
- Desktop delivery: included in the main snap

Do not add arm64, snap components, or additional tracks without validating the
upstream Rust and Electron builds and extending the Spread matrix accordingly.
