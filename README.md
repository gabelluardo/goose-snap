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
