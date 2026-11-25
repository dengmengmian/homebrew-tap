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
      url "https://github.com/dengmengmian/CodeLeveler/releases/download/v1.0.29/leveler-v1.0.29-aarch64-apple-darwin.tar.gz"
      sha256 "0d1d60e60aac55909b58bbdf2906fe98c9e7e9e110b3fc495ad170711da41d7f"
    else
      url "https://github.com/dengmengmian/CodeLeveler/releases/download/v1.0.29/leveler-v1.0.29-x86_64-apple-darwin.tar.gz"
      sha256 "2a8122a42a397728a0ad3e9f24482825f339c1df38e4ff1d84d626cb7b526a57"
    end
  end

  on_linux do
    on_arm do
      # No linux-aarch64 artifact is published yet. Homebrew validates every
      # platform branch and rejects the tap when one has no URL, so this branch
      # names the artifact it would use; `fetch` then fails there with a plain
      # 404 instead of taking the whole tap down.
      url "https://github.com/dengmengmian/CodeLeveler/releases/download/v1.0.29/leveler-v1.0.29-aarch64-unknown-linux-gnu.tar.gz"
      sha256 :no_check
    end
    on_intel do
      url "https://github.com/dengmengmian/CodeLeveler/releases/download/v1.0.29/leveler-v1.0.29-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fd22d3b3f8c8bc96c71b3923296813c4870088282970b5cc95ae57f5adc73386"
    end
  end

  def install
    bin.install "leveler"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/leveler --version")
  end
end
