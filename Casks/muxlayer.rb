cask "muxlayer" do
  arch arm: "aarch64", intel: "x64"

  version "2.0.3"
  sha256 arm:   "96664b45e5d6c86322494c6d81f491652816100375b28bc58c7d735f52a48e16",
         intel: "7ff9b8e8afc99413708d9365cf7acfbc552fd223d0ce2dac78e41ef738952014"

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
