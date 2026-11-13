class Decision < Formula
  desc "Typed judgments over text and images via CLI and MCP"
  homepage "https://github.com/rolandkakonyi/decision"
  url "https://github.com/rolandkakonyi/decision/releases/download/v0.9.0/decision_harness-0.9.0.tar.gz"
  sha256 "d4e1cbd3147eec7228268647e1b3cf413fe924d1bfb70f5a67226b140c655dd3"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    depends_on arch: :x86_64
  end

  resource "binary" do
    on_macos do
      url "https://github.com/rolandkakonyi/decision/releases/download/v0.9.0/decision-0.9.0-macos-arm64.tar.gz"
      sha256 "162d24e2c106f2ccb95892200a76a48ebdc6c06815c91b4467d8dc9ecb8ce644"
    end

    on_linux do
      url "https://github.com/rolandkakonyi/decision/releases/download/v0.9.0/decision-0.9.0-linux-x86_64.tar.gz"
      sha256 "adadc40b8e2d190cce0988141182207c7b3ed0801264a7aae93b76b242d15eba"
    end
  end

  def install
    resource("binary").stage do
      bin.install "decision"
      pkgshare.install "THIRD_PARTY_NOTICES.txt"
    end
  end

  def caveats
    <<~EOS
      This standalone package includes the four built-in providers.
      Third-party provider plugins require Decision's Python installation.
    EOS
  end

  test do
    assert_match "decision #{version}", shell_output("#{bin}/decision --version")
    output = shell_output("#{bin}/decision noul 'Is this text?' --state Hello --provider typesafe --dry-run --json")
    assert_equal "Hello", JSON.parse(output).fetch("state")
    system bin/"decision", "skill", "--output", testpath/"skill"
    assert_predicate testpath/"skill/SKILL.md", :file?
    system bin/"decision", "skill", "--output", testpath/"skill", "--check"
  end
end
