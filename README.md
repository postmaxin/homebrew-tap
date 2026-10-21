# postmaxin/homebrew-tap

Homebrew formulae for [postmaxin](https://github.com/postmaxin)'s tools.

```sh
brew install postmaxin/tap/mediagrep
```

Or `brew tap postmaxin/tap` once, then `brew install mediagrep`.

| Formula | Description |
|---|---|
| [`mediagrep`](https://github.com/postmaxin/mediagrep) | `grep` for media metadata, using MediaInfoLib |

Formulae build from the release source tarball and use Homebrew's
`libmediainfo`. There are no bottles yet, so the first install compiles
(about a minute).

## Development

CI (`.github/workflows/ci.yml`) links the checkout in as the tap on macOS
arm64 and Intel runners, then runs `brew audit --strict --online`,
`brew install --build-from-source` and `brew test`.

To bump `mediagrep` to a new release, change `url` and `sha256` in
`Formula/mediagrep.rb`:

```sh
curl -sL https://github.com/postmaxin/mediagrep/archive/refs/tags/vX.Y.Z.tar.gz | shasum -a 256
```

or run `brew bump-formula-pr --version=X.Y.Z postmaxin/tap/mediagrep`.
