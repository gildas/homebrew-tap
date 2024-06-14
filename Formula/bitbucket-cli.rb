class BitbucketCli < Formula
  desc "Bitbucket command-line tool"
  homepage "https://bitbucket.org/gildas_cherruel/bb"
  url "https://bitbucket.org/gildas_cherruel/bb/get/d03b3f22f76487b596e7bf5d075cd0e4226b385f.tar.gz"
  version "0.10.2"
  sha256 "d92e3324596e7d5de225f05fa723e207304f9c7093f9f236c14f8bf716b7f800"
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
