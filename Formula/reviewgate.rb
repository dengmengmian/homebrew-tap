class Reviewgate < Formula
  desc "Pre-merge quality gate for AI-generated code"
  homepage "https://dengmengmian.github.io/ReviewGate/"
  version "0.7.0"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/dengmengmian/ReviewGate/releases/download/v#{version}/reviewgate-darwin-arm64"
      sha256 "84369a53c4c9035bd20dd061bdad7d60dd9367810b0c7443bece921260d868c4"
    else
      url "https://github.com/dengmengmian/ReviewGate/releases/download/v#{version}/reviewgate-darwin-x64"
      sha256 "dbc8c152693ddfabf32522342fcc327f1170f0e92b552a4db0a9be15d708d64f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/dengmengmian/ReviewGate/releases/download/v#{version}/reviewgate-linux-arm64"
      sha256 "45ec384754a93e407c377b852eef4b587286de9175faab849930b7f66d8730aa"
    else
      url "https://github.com/dengmengmian/ReviewGate/releases/download/v#{version}/reviewgate-linux-x64"
      sha256 "12c4cc8e02cd7e231675f058dc4afb5aca0160f7c8edae6828f88d854d55e342"
    end
  end

  def install
    bin.install Dir["reviewgate-*"].first => "reviewgate"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/reviewgate --version")
  end
end
