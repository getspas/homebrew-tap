# SPAS Homebrew tap

This tap holds the Homebrew cask for [SPAS](https://github.com/getspas/spas).
The repository is set up, but the first cask is waiting for a signed and notarized
macOS release. The existing v0.1.2 macOS archives are unsigned; use the source
installation instructions in the SPAS README until the cask is published.

After the first cask is published:

```sh
brew install --cask getspas/tap/spas
brew upgrade --cask spas
brew uninstall --cask spas
```

The cask covers macOS and Linux on Intel/AMD64 and ARM64. It requires Git 2.43.1
or newer. Package removal preserves SPAS configuration and private assets.

SPAS's distribution workflow verifies release hashes and attestations, tests the
cask, then updates this tap. It rejects changed content at the same version and
prevents an older release from replacing a newer one.
