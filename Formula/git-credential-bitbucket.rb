class GitCredentialBitbucket < Formula
  desc "Git credential helper for Bitbucket"
  homepage "https://github.com/gildas/git-credential-bitbucket"
  url "https://github.com/gildas/git-credential-bitbucket/archive/refs/tags/v1.1.0.zip"
  version "1.1.0"
  sha256 "4f21f6239b44841abe830ec1c9b4db2d2a2b9ab4af02d6b9a233bdb0fb2bda88"
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
