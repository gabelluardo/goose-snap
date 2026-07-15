# Publishing

The build workflow can upload Goose snap builds to the Snap Store when a GitHub
environment provides `SNAPCRAFT_STORE_CREDENTIALS`.

Create credentials locally from a machine where you are logged in with
`snapcraft login`.

```bash
cd publishing

# latest/edge -> edge-credentials
./export-credentials.sh

# latest/candidate -> candidate-credentials
./export-credentials.sh --channel latest/candidate

# latest/stable -> stable-credentials
./export-credentials.sh \
  --channel latest/stable \
  --acls package_access,package_release
```

You can override all values:

```bash
./export-credentials.sh \
  --snap-name goose \
  --channel latest/edge \
  --acls package_upload,package_release \
  --output edge-credentials
```

Generated files are ignored by Git.

| File | GitHub environment | Purpose |
| --- | --- | --- |
| `edge-credentials` | `latest/edge` | publish branch builds |
| `candidate-credentials` | `latest/candidate` | publish tagged builds |
| `stable-credentials` | `latest/stable` | promote tested revisions |

For each environment, create a secret named `SNAPCRAFT_STORE_CREDENTIALS` and
paste the matching file content into it.

The stable environment should normally require manual approval before jobs can
use its secret.
