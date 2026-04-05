class BitbucketCli < Formula
  desc "Bitbucket command-line tool"
  homepage "https://github.com/gildas/bitbucket-cli"
  url "https://github.com/gildas/bitbucket-cli/archive/refs/tags/v0.17.7.zip"
  version "0.17.7"
  sha256 "7870d205909a7801385092edd83127d418a4d0b1c032df2ce01c7aa6d4aa081e"
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
