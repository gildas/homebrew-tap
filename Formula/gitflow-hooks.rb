class GitflowHooks < Formula
  desc "Git flow hooks for versions, pull requests, formatting and linting"
  homepage "https://github.com/gildas/gitflow-hooks"
  url "https://github.com/gildas/gitflow-hooks/archive/refs/tags/v1.4.0.zip"
  version "1.4.0"
  sha256 "a961969ac937bccc6dbb492e99c60abb64791f0bb9b3500e33e4cf85e55a9826"
  license "MIT"

  depends_on "rust" => :build
  depends_on "git-flow-next"

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      Inject the hooks in a repository with:
        hook-it /path/to/repo
    EOS
  end

  test do
    assert_match "hook-it #{version}", shell_output("#{bin}/hook-it --version")

    # In dry mode, hook-it lists the embedded hooks it would write, without needing git flow
    system "git", "init", "--quiet", testpath/"repo"
    touch testpath/"repo/go.mod"
    output = shell_output("#{bin}/hook-it --noop #{testpath}/repo")
    assert_match "pre-commit", output
    assert_match "functions-lang.sh", output
  end
end
