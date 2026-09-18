class BitbucketCli < Formula
  desc "Bitbucket command-line tool"
  homepage "https://github.com/gildas/bitbucket-cli"
  url "https://github.com/gildas/bitbucket-cli/archive/refs/tags/v0.18.6.zip"
  version "0.18.6"
  sha256 "0452471b20a299a4e20e138901071fe9255b7c3595d79d474ec6c92a51ada7e5"
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
