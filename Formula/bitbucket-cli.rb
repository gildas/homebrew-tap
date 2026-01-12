class BitbucketCli < Formula
  desc "Bitbucket command-line tool"
  homepage "https://github.com/gildas/bitbucket-cli"
  url "https://github.com/gildas/bitbucket-cli/archive/refs/tags/v0.17.0.zip"
  version "0.17.0"
  sha256 "6831bb7bdbac4774ddae600ad985245bb609cc0fb8abfd7eeba3aaa664f08c9f"
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
