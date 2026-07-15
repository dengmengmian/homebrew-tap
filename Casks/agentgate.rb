cask "agentgate" do
  arch arm: "aarch64", intel: "x64"

  version "1.5.0"
  sha256 arm:   "f7f7b2727d48005ff8adc0e5ce12eb9404dfa24e8c3f79fe5c87b7cc44c8cdf1",
         intel: "3092bf5c97b29e5ab0a65e2def40b3a61fef25ac8fc70e2389a66c62ef270262"

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
