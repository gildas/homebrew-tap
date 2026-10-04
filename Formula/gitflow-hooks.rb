class GitflowHooks < Formula
  desc "Git flow hooks for versions, pull requests, formatting and linting"
  homepage "https://github.com/gildas/gitflow-hooks"
  url "https://github.com/gildas/gitflow-hooks/archive/refs/tags/v1.4.1.zip"
  version "1.4.1"
  sha256 "ef237080c6fe82e27cec980600cc6ed87025e5c1a098fa7ff614a8d3e2f3c090"
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
