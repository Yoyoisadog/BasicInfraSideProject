#!/bin/bash
# =============================================
# 實務 CI/CD 測試腳本 - 簡易版（不依賴 gh）
# =============================================

set -e

echo "🚀 開始執行 CI/CD 測試流程..."

cd "$(dirname "$0")" || exit 1

BRANCH_NAME="test/ci-cd-$(date '+%Y%m%d-%H%M%S')"

# 1. 更新 main
git checkout main
git pull origin main

# 2. 切新分支
git checkout -b "$BRANCH_NAME"

# 3. Stage & Commit
git add .
if git diff --cached --quiet; then
    echo "ℹ️  沒有變更，使用 --allow-empty"
    git commit --allow-empty -m "test: trigger CI/CD pipeline - $(date '+%Y-%m-%d %H:%M:%S')"
else
    git commit -m "test: trigger CI/CD pipeline - $(date '+%Y-%m-%d %H:%M:%S')"
fi

# 4. Push
git push origin "$BRANCH_NAME"

echo "🎉 Push 完成！"
echo "👉 請前往以下網址手動建立 PR："
echo "   https://github.com/Yoyoisadog/BasicInfraSideProject/compare/main...$BRANCH_NAME"
echo ""
echo "👉 或直接前往 Actions 查看："
echo "   https://github.com/Yoyoisadog/BasicInfraSideProject/actions"

chmod +x ./ci.sh
echo "✅ ci.sh 已更新為簡易版！"