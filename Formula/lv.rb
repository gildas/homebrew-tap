class Lv < Formula
  desc "Log viewer"
  homepage "https://github.com/gildas/lv"
  url "https://github.com/gildas/lv/archive/refs/tags/v0.3.0.zip"
  version "0.3.0"
  sha256 "05a6fe2a92a8ec5537b08832536821fec2fe0fc2ec4ae7efce9b35652faf5592"
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
