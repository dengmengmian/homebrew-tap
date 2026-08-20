cask "agentgate" do
  arch arm: "aarch64", intel: "x64"

  version "2.0.0"
  sha256 arm:   "5b34b12f20f7cdb4d7ddff0b36a6ab1d47ea4bfd50ff27c557f277464855fb24",
         intel: "b6afc08bd4f29119e0a65755c87dde6713f4fe88c3dbe3fa9590d610c8bac7bf"

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
