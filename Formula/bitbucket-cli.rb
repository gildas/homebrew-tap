class BitbucketCli < Formula
  desc "Bitbucket command-line tool"
  homepage "https://github.com/gildas/bitbucket-cli"
  url "https://github.com/gildas/bitbucket-cli/archive/refs/tags/v0.15.0.zip"
  version "0.15.0"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", *std_go_args(output: bin/"bb", ldflags: "-s -w")
    generate_completions_from_executable(bin/"bb", "completion", base_name: "bb")
  end

  test do
    assert_match "bb version #{version}", shell_output("#{bin}/bb --version")
  end
end
