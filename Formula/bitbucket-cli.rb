class BitbucketCli < Formula
  desc "Bitbucket command-line tool"
  homepage "https://bitbucket.org/gildas_cherruel/bb"
  url "https://bitbucket.org/gildas_cherruel/bb/get/885755f0bdba066b8744202d9477b63502680ea7.tar.gz"
  version "0.12.1"
  sha256 "8727ec0eb3b4d7cecd833adebbb147caf673c4b31073f7a53669681a9b0f47ed"
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
