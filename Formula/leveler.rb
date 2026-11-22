class Leveler < Formula
  desc "Local-first coding agent CLI: terminal UI, typed tools, resumable sessions"
  homepage "https://github.com/dengmengmian/CodeLeveler"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/dengmengmian/CodeLeveler/releases/download/v1.0.28/leveler-v1.0.28-aarch64-apple-darwin.tar.gz"
      sha256 "9e9bc616736d7afcdf7352a139fc528118f939277ca2bddaace721e5bdd8c5b5"
    else
      url "https://github.com/dengmengmian/CodeLeveler/releases/download/v1.0.28/leveler-v1.0.28-x86_64-apple-darwin.tar.gz"
      sha256 "3b8bb71267394cb6923a346e860b01b707f0b0ce333092d5b1e2f50b812edc1f"
    end
  end

  on_linux do
    on_arm do
      # No linux-aarch64 artifact is published yet. Homebrew validates every
      # platform branch and rejects the tap when one has no URL, so this branch
      # names the artifact it would use; `fetch` then fails there with a plain
      # 404 instead of taking the whole tap down.
      url "https://github.com/dengmengmian/CodeLeveler/releases/download/v1.0.28/leveler-v1.0.28-aarch64-unknown-linux-gnu.tar.gz"
      sha256 :no_check
    end
    on_intel do
      url "https://github.com/dengmengmian/CodeLeveler/releases/download/v1.0.28/leveler-v1.0.28-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2cd0dbbe4975e7e4afedee011c02b4ceef8273ae11f78719a8679c43bc3210b3"
    end
  end

  def install
    bin.install "leveler"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/leveler --version")
  end
end
