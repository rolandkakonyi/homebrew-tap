# Homebrew tap

Install [Decision](https://github.com/rolandkakonyi/decision), a CLI and STDIO MCP
server for typed judgments over text and images:

```bash
brew install rolandkakonyi/tap/decision
```

The standalone package supports macOS ARM64 and Linux x86_64 and includes its
Python runtime and third-party license notices. TypeSafe, OpenAI, Cloudflare,
and Gemini providers are built in. Third-party provider extensions require
Decision's Python installation instead.

Validate without inference:

```bash
decision --version
decision noul 'Is this text?' --state 'Hello' --dry-run
brew test rolandkakonyi/tap/decision
```

Provider queries require your own credentials and are billed by the provider.
For usage, images, MCP setup, and Python extensions, see the
[Decision documentation](https://github.com/rolandkakonyi/decision#readme).

## Maintaining the formula

Binaries are built from an existing upstream release tag and tested natively
before packaging. Run the build workflow for a release:

```bash
gh workflow run publish.yml --repo rolandkakonyi/homebrew-tap -f tag=v0.9.0
```

Download both workflow artifacts, publish the archives and their SHA-256 sums
on the matching upstream Decision release, then update `Formula/decision.rb`
with the release version, URLs, and checksums. Never replace a released archive
or move a release tag. Formula CI audits, installs, and tests on both platforms.

This tap is licensed under [MIT](LICENSE). Decision and its bundled dependencies
retain their own licenses.
