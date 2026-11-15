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
      url "https://github.com/dengmengmian/CodeLeveler/releases/download/v1.0.27/leveler-v1.0.27-aarch64-apple-darwin.tar.gz"
      sha256 "2a681b9fc41fda3839e06da0dd737536a61fd08d281e190c2a820532a5492c8b"
    else
      url "https://github.com/dengmengmian/CodeLeveler/releases/download/v1.0.27/leveler-v1.0.27-x86_64-apple-darwin.tar.gz"
      sha256 "eb60361b29d03f0947e191e6a1d363666d77e2584a6695a253da5ff1833d1eaa"
    end
  end

  on_linux do
    on_arm do
      # No linux-aarch64 artifact is published yet. Homebrew validates every
      # platform branch and rejects the tap when one has no URL, so this branch
      # names the artifact it would use; `fetch` then fails there with a plain
      # 404 instead of taking the whole tap down.
      url "https://github.com/dengmengmian/CodeLeveler/releases/download/v1.0.27/leveler-v1.0.27-aarch64-unknown-linux-gnu.tar.gz"
      sha256 :no_check
    end
    on_intel do
      url "https://github.com/dengmengmian/CodeLeveler/releases/download/v1.0.27/leveler-v1.0.27-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4cb85437742d1cea477d9205b402816728abfe8764985b83e1ee9944836d0d19"
    end
  end

  def install
    bin.install "leveler"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/leveler --version")
  end
end
