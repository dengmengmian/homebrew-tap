cask "muxlayer" do
  arch arm: "aarch64", intel: "x64"

  version "2.0.0"
  sha256 arm:   "7ca2645e12174f06ecfa94e6645750214b06d474f5e99245bf94c1eff8196045",
         intel: "bc2ef65e04f7a29c01cf41a69f7ce8e9380e3a8984e253522296235b9fc8a830"

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
