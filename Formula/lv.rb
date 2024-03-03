class LV < Formula
  desc "Log viewer"
  homepage "https://github.com/gildas/lv"
  url "https://github.com/gildas/lv/archive/refs/tags/v0.1.0.zip"
  version "0.1.0"
  sha256 "1d9020d0205090ddadb5fe75b25bb835a53ebb8e0d92337fe5cc2deb4011b06f"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", *std_go_args(output: bin/"lv", ldflags: "-s -w")
    generate_completions_from_executable(bin/"lv", "completion", base_name: "lv")
  end

  test do
    assert_match "lv version #{version}", shell_output("#{bin}/lv --version")
  end
end
