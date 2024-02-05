class BitbucketCli < Formula
  desc "Bitbucket command-line tool"
  homepage "https://bitbucket.org/gildas_cherruel/bb"
  url "https://bitbucket.org/gildas_cherruel/bb/get/834423dee85e7e2783054f9bc8413484c786eeef.tar.gz"
  version "0.9.0"
  sha256 "7a7e67bcfac75fe4c962b54b8a2b6950ba47e07ec1997c1bb8949c9e3ca0dd1b"
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
