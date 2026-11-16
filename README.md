# Homebrew tap

Install [Decision](https://github.com/rolandkakonyi/decision), a CLI and STDIO MCP
server for typed judgments over text and images:

```bash
brew install rolandkakonyi/tap/decision
brew upgrade rolandkakonyi/tap/decision
```

The native executable supports macOS ARM64 and Linux x86_64. TypeSafe, OpenAI,
Cloudflare, and Gemini providers are built in; no Python or Rust installation
is required. Third-party providers run executable commands in any language.
Users supply any runtime declared by a plugin. License notices and build
metadata are installed under `brew --prefix decision` in `share/decision`.

Validate without inference:

```bash
decision --version
decision noul 'Is this text?' --state 'Hello' --dry-run
brew test rolandkakonyi/tap/decision
```

Install a trusted runtime provider and select it by name:

```bash
decision providers install /path/to/provider-package
decision providers list
decision noul 'Is this text?' --state 'Hello' --provider acme
```

Packages contain `decision-provider.json` and own their setup commands and
dependencies. Setup runs only during explicit installation or update.
`decision mcp` runs inference; `decision mcp --management` exposes provider
installation, listing, and removal instead. Provider queries require your own
credentials and are billed by the provider. See the
[Decision documentation](https://github.com/rolandkakonyi/decision#readme).

## Maintaining the formula

Decision's upstream CI publishes native release archives and `SHA256SUMS`.
Update `Formula/decision.rb` with the version, platform URLs, and matching
checksums from that published release. Never replace an archive or move a tag.
The tap consumes those artifacts without rebuilding them.

Formula CI audits, installs, and tests on macOS and Linux. Each platform runs a
fresh installation and an upgrade from v0.9.0, then exercises the installed
CLI, MCP server, and runtime-provider lifecycle against the matching upstream
release's local fixtures. Tests require no provider credentials or paid inference.

This tap is licensed under [MIT](LICENSE). Decision and its bundled dependencies
retain their own licenses.
