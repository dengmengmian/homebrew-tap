class Reviewgate < Formula
  desc "Pre-merge quality gate for AI-generated code"
  homepage "https://dengmengmian.github.io/ReviewGate/"
  version "0.12.0"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/dengmengmian/ReviewGate/releases/download/v#{version}/reviewgate-darwin-arm64"
      sha256 "9773acfe437df3dab6d7c36c48f0bb2d764138627243c6ce5b3dd7055e0ec2e4"
    else
      url "https://github.com/dengmengmian/ReviewGate/releases/download/v#{version}/reviewgate-darwin-x64"
      sha256 "c47d45b94a40cbfc3a2e1994b694624abed31b3f659fb33dc0bab96e5ff70d94"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/dengmengmian/ReviewGate/releases/download/v#{version}/reviewgate-linux-arm64"
      sha256 "f8b1f299a0bd458ca74d0f8ab5512baee423a172367774274b3480336bd56963"
    else
      url "https://github.com/dengmengmian/ReviewGate/releases/download/v#{version}/reviewgate-linux-x64"
      sha256 "64a1ed39993e07a01b7848a002d07fb974242529e0b5ac77f51cff1fad814e94"
    end
  end

  def install
    bin.install Dir["reviewgate-*"].first => "reviewgate"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/reviewgate --version")
  end
end
