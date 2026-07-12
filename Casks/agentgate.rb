cask "agentgate" do
  arch arm: "aarch64", intel: "x64"

  version "1.4.13"
  sha256 arm:   "acf5febf8c6eaf3854fbed985ecd5f6d3e55f215ee7b32d7c3b4839956d4823a",
         intel: "1fe9d76f505189115e2d599bb405fe1d286a1b92cc25d216b764c242b7c8bc16"

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
