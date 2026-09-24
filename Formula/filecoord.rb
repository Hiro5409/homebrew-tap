class Filecoord < Formula
  desc "Read and replace iCloud Drive files from scripts and AI agents"
  homepage "https://github.com/Hiro5409/filecoord"
  url "https://github.com/Hiro5409/filecoord/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "121349138a18817a8c4fcc50c1ca63028e40ea1508379a11bc59e60b3920e70b"
  license "MIT"

  depends_on macos: :sonoma

  def install
    system "swift", "package", "--disable-sandbox", "--force-resolved-versions", "resolve"
    system "swift", "build", "--disable-sandbox", "--force-resolved-versions", "-c", "release"
    bin.install ".build/release/filecoord"
  end

  test do
    assert_match "0.1.0", shell_output("#{bin}/filecoord --version")
  end
end
