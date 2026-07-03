cask "agentgate" do
  arch arm: "aarch64", intel: "x64"

  version "1.4.10"
  sha256 arm:   "4a3fe79c4da67a6e8f40eca42c26afa9bc1bfd849ffe61012f57b63c6d81dacd",
         intel: "81fdbfbcef9120e73f0c9873e4f03067761e1b90829edacc7f3575630e9e6ae1"

  url "https://github.com/dengmengmian/agentgate-ai/releases/download/v#{version}/AgentGate_#{version}_#{arch}.dmg",
      verified: "github.com/dengmengmian/agentgate-ai/"
  name "AgentGate"
  desc "Local AI gateway that routes, converts, fails over, and traces model requests"
  homepage "https://dengmengmian.github.io/agentgate-ai/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # 应用内置 tauri-plugin-updater 自更新
  auto_updates true
  depends_on :macos

  app "AgentGate.app"

  zap trash: [
    "~/Library/Application Support/com.mengmian.agentgate",
    "~/Library/Caches/com.mengmian.agentgate",
    "~/Library/Preferences/com.mengmian.agentgate.plist",
    "~/Library/Saved Application State/com.mengmian.agentgate.savedState",
    "~/Library/WebKit/com.mengmian.agentgate",
  ]
end
