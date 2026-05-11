class GitCredentialBitbucket < Formula
  desc "Git credential helper for Bitbucket"
  homepage "https://github.com/gildas/git-credential-bitbucket"
  url "https://github.com/gildas/git-credential-bitbucket/archive/refs/tags/v1.1.1.zip"
  version "1.1.1"
  sha256 "027faa81e6d4f53203a9c65a3432293db659213f5d65442248a67c1bd021d266"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", *std_go_args(output: bin/"git-credential-bitbucket", ldflags: "-s -w")
  end

  test do
    assert_match "git-credential-bitbucket version #{version}", shell_output("#{bin}/git-credential-bitbucket --version")
  end
end
