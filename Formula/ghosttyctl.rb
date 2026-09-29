class Ghosttyctl < Formula
  desc "Control Ghostty through its AppleScript API"
  homepage "https://github.com/Hiro5409/ghosttyctl"
  url "https://github.com/Hiro5409/ghosttyctl.git",
      tag:      "v0.1.0",
      revision: "16e1145de73754f1c5fbfff8265401bbb1667f83"
  license "MIT"

  bottle do
    root_url "https://github.com/Hiro5409/homebrew-tap/releases/download/ghosttyctl-0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "4b0d65110c8a6d89f23bc160be59667fbe9c6d061b3cc6c3cb08cdfc447518c8"
  end

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
