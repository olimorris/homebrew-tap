class Foreman < Formula
  desc "Orchestrator that runs Claude Code workers in parallel git worktrees"
  homepage "https://github.com/olimorris/foreman"
  url "https://github.com/olimorris/foreman/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "805e00e3776c93dfcbd43d68803f762a151fc7edef09ad2673ed4e704e1180e9"
  license "MIT"

  depends_on "fswatch"
  depends_on "gh"
  depends_on "jq"
  depends_on :macos
  depends_on "oven-sh/bun/bun"

  def install
    libexec.install ".claude-plugin", "agents", "bin", "hooks", "prompts", "scripts", "skills", "src"
    bin.install_symlink libexec/"bin/foreman"
  end

  def caveats
    <<~EOS
      Foreman also needs Claude Code, which Homebrew can't install as a dependency:
        brew install --cask claude-code
      Then check your setup with:
        foreman doctor
    EOS
  end

  test do
    assert_match "Usage: foreman", shell_output("#{bin}/foreman help")
  end
end
