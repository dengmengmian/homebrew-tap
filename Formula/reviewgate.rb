class Reviewgate < Formula
  desc "Pre-merge quality gate for AI-generated code"
  homepage "https://dengmengmian.github.io/ReviewGate/"
  version "0.12.1"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/dengmengmian/ReviewGate/releases/download/v#{version}/reviewgate-darwin-arm64"
      sha256 "1610553bbf3eb1996da08c4905b893668281795b73ef4b7d579ba8edaa1b1264"
    else
      url "https://github.com/dengmengmian/ReviewGate/releases/download/v#{version}/reviewgate-darwin-x64"
      sha256 "918d96f492d20f2672d2164a650ffe5589325159571c6b77e46cffd34011a73f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/dengmengmian/ReviewGate/releases/download/v#{version}/reviewgate-linux-arm64"
      sha256 "b7fc510e7b3956ab63bc069b925f6eb96599c584a8feadabe24be627164c54e3"
    else
      url "https://github.com/dengmengmian/ReviewGate/releases/download/v#{version}/reviewgate-linux-x64"
      sha256 "199a00947de42c2d2c58cd2a50c3de48afba65241f8ecdeb92d20334f18b9882"
    end
  end

  def install
    bin.install Dir["reviewgate-*"].first => "reviewgate"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/reviewgate --version")
  end
end
