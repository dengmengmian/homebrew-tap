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
      url "https://github.com/dengmengmian/CodeLeveler/releases/download/v1.0.26/leveler-v1.0.26-aarch64-apple-darwin.tar.gz"
      sha256 "b74cd1ebf8e61d997a147f73de257736f2005ed713c95cdac7ce2f06648717c6"
    else
      url "https://github.com/dengmengmian/CodeLeveler/releases/download/v1.0.26/leveler-v1.0.26-x86_64-apple-darwin.tar.gz"
      sha256 "5ed16d5cdcebab7f7253d28e8f1ca1f9fc1f35b2ebdd880618cedba3b3e196dd"
    end
  end

  on_linux do
    on_arm do
      # No linux-aarch64 artifact is published yet. Homebrew validates every
      # platform branch and rejects the tap when one has no URL, so this branch
      # names the artifact it would use; `fetch` then fails there with a plain
      # 404 instead of taking the whole tap down.
      url "https://github.com/dengmengmian/CodeLeveler/releases/download/v1.0.26/leveler-v1.0.26-aarch64-unknown-linux-gnu.tar.gz"
      sha256 :no_check
    end
    on_intel do
      url "https://github.com/dengmengmian/CodeLeveler/releases/download/v1.0.26/leveler-v1.0.26-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ea697ef14d63416628d0d21b24b3bf12a917722364cab25c2c435bf15e938d80"
    end
  end

  def install
    bin.install "leveler"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/leveler --version")
  end
end
