class Lv < Formula
  desc "Log viewer"
  homepage "https://github.com/gildas/lv"
  url "https://github.com/gildas/lv/archive/refs/tags/v0.1.3.zip"
  version "0.1.3"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
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
