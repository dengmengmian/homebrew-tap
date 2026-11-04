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
      url "https://github.com/dengmengmian/CodeLeveler/releases/download/v1.0.22/leveler-v1.0.22-aarch64-apple-darwin.tar.gz"
      sha256 "22d539c562922a2305d4ebd260d82df0f25f6a7b7ed7d69726537fbb87554efa"
    else
      url "https://github.com/dengmengmian/CodeLeveler/releases/download/v1.0.22/leveler-v1.0.22-x86_64-apple-darwin.tar.gz"
      sha256 "f24a4ea5eb8a2238f5aaa90794dfc1ea563f71470f8514754e7b0e64ca88e00d"
    end
  end

  on_linux do
    on_arm do
      # No linux-aarch64 artifact is published yet. Homebrew validates every
      # platform branch and rejects the tap when one has no URL, so this branch
      # names the artifact it would use; `fetch` then fails there with a plain
      # 404 instead of taking the whole tap down.
      url "https://github.com/dengmengmian/CodeLeveler/releases/download/v1.0.22/leveler-v1.0.22-aarch64-unknown-linux-gnu.tar.gz"
      sha256 :no_check
    end
    on_intel do
      url "https://github.com/dengmengmian/CodeLeveler/releases/download/v1.0.22/leveler-v1.0.22-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c5337d21f3975e52d5d44bc6f02e2296fd81d4525a30e474d73d0bd003655f5b"
    end
  end

  def install
    bin.install "leveler"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/leveler --version")
  end
end
