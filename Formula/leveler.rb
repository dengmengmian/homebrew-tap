class Leveler < Formula
  desc "Local-first coding agent CLI: terminal UI, typed tools, resumable sessions"
  homepage "https://github.com/dengmengmian/CodeLeveler"
  version "1.0.14"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/dengmengmian/CodeLeveler/releases/download/v#{version}/leveler-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "54884ab95ec459c659f173903778549a31702e2f348d3444f4e37743bb16dbc4"
    else
      url "https://github.com/dengmengmian/CodeLeveler/releases/download/v#{version}/leveler-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "108f182af1d83fd953f0adf7ee2142020255dc630a8620cbdfe193dd3dfb5bf0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/dengmengmian/CodeLeveler/releases/download/v#{version}/leveler-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "906b181944db76822280ae6ed5daa5ee5c92b571dceee629d0dde2907d75695a"
    end
  end

  def install
    bin.install "leveler"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/leveler --version")
  end
end
