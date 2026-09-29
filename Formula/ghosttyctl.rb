class Ghosttyctl < Formula
  desc "Control Ghostty through its AppleScript API"
  homepage "https://github.com/Hiro5409/ghosttyctl"
  url "https://github.com/Hiro5409/ghosttyctl.git",
      tag:      "v0.1.1",
      revision: "925212ff180ea08ce3d5772590b584e1a73ba662"
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
