class Ghosttyctl < Formula
  desc "Control Ghostty through its AppleScript API"
  homepage "https://github.com/Hiro5409/ghosttyctl"
  url "https://github.com/Hiro5409/ghosttyctl.git",
      tag:      "v0.3.0",
      revision: "19bb8cfd3c3b15169af330c9001ea8a6def20026"
  license "MIT"

  bottle do
    root_url "https://github.com/Hiro5409/homebrew-tap/releases/download/ghosttyctl-0.3.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "02ed141222760d705b2f81800a71027c12d29064219c04642bd149cbf0bdf9e6"
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
