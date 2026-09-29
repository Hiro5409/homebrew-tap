class Ghosttyctl < Formula
  desc "Control Ghostty through its AppleScript API"
  homepage "https://github.com/Hiro5409/ghosttyctl"
  url "https://github.com/Hiro5409/ghosttyctl.git",
      tag:      "v0.2.0",
      revision: "4efd17f968adaf8e01f6af402296cedb99809d12"
  license "MIT"

  depends_on macos: :sonoma
  uses_from_macos "swift" => :build, since: :sequoia

  on_sequoia :or_newer do
    depends_on xcode: ["26.0", :build]
  end

  def fetch
    system "swift", "package", "resolve", "--disable-sandbox", "--force-resolved-versions"
  end

  def install
    system "swift", "build", "--disable-sandbox", "--force-resolved-versions", "--configuration", "release"
    bin.install ".build/release/ghosttyctl"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ghosttyctl --version")
  end
end
