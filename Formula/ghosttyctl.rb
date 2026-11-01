class Ghosttyctl < Formula
  desc "Control Ghostty through its AppleScript API"
  homepage "https://github.com/Hiro5409/ghosttyctl"
  url "https://github.com/Hiro5409/ghosttyctl.git",
      tag:      "v0.3.2",
      revision: "7eb74365117412be5142dcd006766bf73d0440aa"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/Hiro5409/homebrew-tap/releases/download/ghosttyctl-0.3.2_1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "fac87fc237f0c71047bc3dce43758367bb0b579a12e840cae50b1342d3b36af5"
  end

  depends_on macos: :sonoma
  uses_from_macos "swift" => :build, since: :sequoia

  on_sequoia :or_newer do
    depends_on xcode: ["26.0", :build]
  end

  deny_network_access!

  def fetch
    system "swift", "package", "resolve", "--disable-sandbox", "--force-resolved-versions"
  end

  def install
    system "swift", "build", "--product", "ghosttyctl", "--disable-sandbox",
           "--force-resolved-versions", *std_swift_args
    bin.install ".build/release/ghosttyctl"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ghosttyctl --version")
  end
end
