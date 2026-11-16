class Decision < Formula
  desc "Typed judgments over text and images via CLI and MCP"
  homepage "https://github.com/rolandkakonyi/decision"
  if OS.mac?
    url "https://github.com/rolandkakonyi/decision/releases/download/v0.10.0/decision-0.10.0-aarch64-apple-darwin.tar.gz"
    sha256 "71bbe42ffbe68cbfabc4ec99e3257f918dea226fcfb32cbc5538a1dadfab6f08"
  elsif OS.linux?
    url "https://github.com/rolandkakonyi/decision/releases/download/v0.10.0/decision-0.10.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "619ecc2813a6b72fb530e06eac8dc1b3fdc6a94a1151367ca9d631de95e24315"
  end
  license "MIT"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    depends_on arch: :x86_64
  end

  def install
    bin.install "decision"
    pkgshare.install "LICENSE", "THIRD_PARTY_NOTICES.txt", "build-manifest.json", "SHA256SUMS"
  end

  def caveats
    <<~EOS
      Provider plugins run trusted commands in any language.
      Install any runtime required by a plugin before installing it.
    EOS
  end

  test do
    assert_match "decision #{version}", shell_output("#{bin}/decision --version")
    output = shell_output("#{bin}/decision noul 'Is this text?' --state Hello --provider typesafe --dry-run --json")
    assert_equal "Hello", JSON.parse(output).fetch("state")
    assert_equal [], JSON.parse(shell_output("#{bin}/decision providers list --plugin-home #{testpath}/providers"))
    system bin/"decision", "skill", "--output", testpath/"skill"
    assert_predicate testpath/"skill/SKILL.md", :file?
    system bin/"decision", "skill", "--output", testpath/"skill", "--check"
  end
end
