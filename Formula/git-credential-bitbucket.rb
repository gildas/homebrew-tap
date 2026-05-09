class GitCredentialBitbucket < Formula
  desc "Git credential helper for Bitbucket"
  homepage "https://github.com/gildas/git-credential-bitbucket"
  url "https://github.com/gildas/git-credential-bitbucket/archive/refs/tags/v1.1.0.zip"
  version "1.1.0"
  sha256 "b83cce2e7e01b0dc5b9a406335b0838341778fbacf537dbd68ac09a49229c378"
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
