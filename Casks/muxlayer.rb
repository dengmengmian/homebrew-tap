cask "muxlayer" do
  arch arm: "aarch64", intel: "x64"

  version "2.0.2"
  sha256 arm:   "a6672b42cd659866d77f6f5f9b2cd5e8d1e8b210cbc93ba3df4bff72b633a52a",
         intel: "26ec323155739f9b540fdff045fcfd097dcc4796bee842d5da32089cba16a0f3"

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
