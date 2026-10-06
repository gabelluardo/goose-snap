# Publishing

The build workflow publishes branch builds to `latest/edge` and tagged builds
to `latest/candidate`. Promotion from candidate to beta or stable is manual.

Create the credentials on a machine where `snapcraft` is installed and you are
logged in with `snapcraft login`:

```bash
cd publishing

./export-edge-credentials.sh
./export-candidate-credentials.sh
./export-beta-credentials.sh
./export-stable-credentials.sh
```

Generated files are ignored by Git.

| File                    | GitHub environment | Purpose                     |
| ----------------------- | ------------------ | --------------------------- |
| `edge-credentials`      | `latest/edge`      | publish branch builds       |
| `candidate-credentials` | `latest/candidate` | publish tagged builds       |
| `beta-credentials`      | `latest/beta`      | promote candidate revisions |
| `stable-credentials`    | `latest/stable`    | promote candidate revisions |

For each environment, create a secret named `SNAPCRAFT_STORE_CREDENTIALS` and
paste the matching file content into it.

Promotion environments should require manual approval.
