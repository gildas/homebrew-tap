class Lv < Formula
  desc "Log viewer"
  homepage "https://github.com/gildas/lv"
  url "https://github.com/gildas/lv/archive/refs/tags/v0.3.4.zip"
  version "0.3.4"
  sha256 "f03709b8f23f44b2abf0718e7b6214e70083ed58ab283cf7e9869be1f5a22095"
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
