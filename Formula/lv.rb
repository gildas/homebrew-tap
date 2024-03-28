class Lv < Formula
  desc "Log viewer"
  homepage "https://github.com/gildas/lv"
  url "https://github.com/gildas/lv/archive/refs/tags/v0.2.0.zip"
  version "0.2.0"
  sha256 "447121112e9b1620e69f1b570f506c93744f113e532653300b5c2a228481dbf6"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", *std_go_args(output: bin/"lv", ldflags: "-s -w")
    generate_completions_from_executable(bin/"lv", "--completion", base_name: "lv")
  end

  test do
    assert_match "lv version #{version}", shell_output("#{bin}/lv --version")
  end
end
