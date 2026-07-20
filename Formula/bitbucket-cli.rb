class BitbucketCli < Formula
  desc "Bitbucket command-line tool"
  homepage "https://github.com/gildas/bitbucket-cli"
  url "https://github.com/gildas/bitbucket-cli/archive/refs/tags/v0.18.4.zip"
  version "0.18.4"
  sha256 "467dcbe6753d08f564298abcddfb9ffbab437e62f9b2c71a5405883d10e38cbb"
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
