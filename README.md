# SPAS Homebrew tap

This tap distributes [SPAS](https://github.com/getspas/spas) as a source-built
Homebrew formula. Install it with:

```sh
brew install getspas/tap/spas
brew upgrade spas
brew uninstall spas
```

Homebrew installs Go to build the executable and Git for runtime use. SPAS
requires Git 2.43.1 or newer. Go is not needed to run the installed binary.

The formula builds on macOS and Linux for the host architecture and installs
shell completions.
Removing the package preserves SPAS configuration and private assets.

SPAS's release publisher updates the formula after a stable release is published.
The tap's CI builds and tests it on macOS and Linux, on Intel/AMD64 and ARM64.
