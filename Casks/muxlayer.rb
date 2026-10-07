cask "muxlayer" do
  arch arm: "aarch64", intel: "x64"

  version "2.0.8"
  sha256 arm:   "3e27b9fd703739c98211e1cd2d8304c44cf84bbe65066d9bc46cf0619d0d0e62",
         intel: "8e8cf8de70a6fcca9405ebe1c1f9bbce9fdc9697cfb76ce7f35926d7c1fce351"

  url "https://github.com/dengmengmian/muxlayer/releases/download/v#{version}/MuxLayer_#{version}_#{arch}.dmg",
      verified: "github.com/dengmengmian/muxlayer/"
  name "MuxLayer"
  desc "Local model control layer for coding agents"
  homepage "https://dengmengmian.github.io/muxlayer/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  conflicts_with cask: "agentgate"
  depends_on :macos

  app "MuxLayer.app"

  zap trash: [
    "~/Library/Application Support/com.mengmian.agentgate",
    "~/Library/Caches/com.mengmian.agentgate",
    "~/Library/Preferences/com.mengmian.agentgate.plist",
    "~/Library/Saved Application State/com.mengmian.agentgate.savedState",
    "~/Library/WebKit/com.mengmian.agentgate",
  ]
end
