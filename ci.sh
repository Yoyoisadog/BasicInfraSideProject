#!/bin/bash
# =============================================
# 實務 CI/CD 測試觸發腳本（專為你的 Voting App 設計）
# 每次執行都會強制產生一個 commit 來觸發 workflow
# =============================================

set -e  # 任何錯誤立即停止

echo "🚀 開始執行 CI/CD 測試流程..."

# 1. 進入專案目錄
cd "$(dirname "$0")" || exit 1

# 2. Stage 所有變更
git add .

# 3. 檢查是否有變更
if git diff --cached --quiet; then
    echo "ℹ️  沒有新變更，使用 --allow-empty 強制觸發 commit（測試用）"
    COMMIT_FLAG="--allow-empty"
else
    echo "✅ 有新變更，正常 commit"
    COMMIT_FLAG=""
fi

# 4. Commit（永遠能成功）
git commit $COMMIT_FLAG -m "test: trigger full CI/CD pipeline - $(date '+%Y-%m-%d %H:%M:%S')"

# 5. Push 到 main（觸發 CI + CD）
git push origin main

echo "🎉 Push 完成！"
echo "👉 請立即前往 GitHub Actions 查看："
echo "   https://github.com/Yoyoisadog/BasicInfraSideProject/actions"
echo ""
echo "✅ 等待 CI/CD 執行完畢後，可直接執行退版測試。"

# 給執行權限
chmod +x ./ci.sh
echo "✅ ci.sh 已更新為穩健版本！"