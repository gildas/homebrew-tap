class BitbucketCli < Formula
  desc "Bitbucket command-line tool"
  homepage "https://bitbucket.org/gildas_cherruel/bb"
  url "https://bitbucket.org/gildas_cherruel/bb/get/f198c4527765d9ad1155d7eb53de0a169ab12115.tar.gz"
  version "0.10.1"
  sha256 "0bca725e32f6d8085a92c78c65469804a62f01d7f9c6343bd12b0d236d3bbe6b"
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
