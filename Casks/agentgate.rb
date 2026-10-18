# Legacy compatibility only. New users should install the muxlayer cask.
cask "agentgate" do
  arch arm: "aarch64", intel: "x64"

  version "2.0.9"
  sha256 arm:   "c2aa8321cd992d13f1af7ac82e5ea6fff9b02fd29fd1787e308d2e3625abd71c",
         intel: "ac266125abedce3bc14f280c6413b4a6d37f7c0f681a3c65977a03140020cbb2"

  url "https://github.com/dengmengmian/muxlayer/releases/download/v#{version}/MuxLayer_#{version}_#{arch}.dmg",
      verified: "github.com/dengmengmian/muxlayer/"
  name "MuxLayer (formerly AgentGate)"
  desc "Legacy cask for the MuxLayer local model control layer"
  homepage "https://dengmengmian.github.io/muxlayer/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  conflicts_with cask: "muxlayer"
  depends_on :macos

  app "MuxLayer.app"

  zap trash: [
    "~/Library/Application Support/com.mengmian.agentgate",
    "~/Library/Caches/com.mengmian.agentgate",
    "~/Library/Preferences/com.mengmian.agentgate.plist",
    "~/Library/Saved Application State/com.mengmian.agentgate.savedState",
    "~/Library/WebKit/com.mengmian.agentgate",
  ]

  caveats <<~EOS
    This cask remains available so existing AgentGate installations keep upgrading.
    New installations should use:
      brew install --cask dengmengmian/tap/muxlayer

    To adopt the new cask name without deleting settings:
      brew uninstall --cask agentgate
      brew install --cask dengmengmian/tap/muxlayer
  EOS
end
