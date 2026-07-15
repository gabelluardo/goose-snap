# Goose snap

Snap packaging for [Goose](https://github.com/aaif-goose/goose), bundling both
the Electron desktop app and the CLI from the same upstream release.

## Build

```bash
snapcraft pack
```

## Install Locally

```bash
sudo snap install --classic --dangerous goose_*.snap
```

The desktop app is exposed as `goose`; the CLI is exposed as `goose.cli`.

## Updating the version

The version is determined by selecting the Git tag of opencode.
To update to a new upstream release just change that and commit.

## Testing with spread

Tests in this repository use [spread](https://github.com/snapcore/spread), the
multi-machine test runner from the snap core team. To run the tests locally you
need a spread environment backed by a LXD image.

Install the `image-garden` snap, which provides the image management tooling
spread depends on:

```sh
sudo snap install image-garden
```

The `image-garden` snap ships a `image-garden.spread` binary that acts as a
spread backend. Use it to run the tests:

```sh
image-garden.spread
```

This will pull the necessary virtual machine base images, and execute the test
cases defined under `tests/`.

## Publishing

See `publishing/README.md` for details.