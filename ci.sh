#!/bin/bash
# =============================================
# 實務 CI/CD 測試腳本 - 分支 + 自動開 PR 版本
# =============================================

set -e

echo "🚀 開始執行 CI/CD 測試流程（分支 + PR 模式）..."
cd "$(dirname "$0")" || exit 1

BRANCH_NAME="test/ci-cd-$(date '+%Y%m%d-%H%M%S')"

# 1. 確保在 main 並更新
git checkout main
git pull origin main

# 2. 切新分支
git checkout -b "$BRANCH_NAME"

# 3. Stage 所有變更
git add .

# 4. Commit
if git diff --cached --quiet; then
    echo "ℹ️  沒有變更，使用 --allow-empty"
    git commit --allow-empty -m "test: trigger CI/CD pipeline - $(date '+%Y-%m-%d %H:%M:%S')"
else
    git commit -m "test: trigger CI/CD pipeline - $(date '+%Y-%m-%d %H:%M:%S')"
fi

# 5. Push 到新分支
git push origin "$BRANCH_NAME"

# 6. 自動建立 Pull Request
echo "🔗 正在建立 Pull Request..."
gh pr create --title "test: trigger CI/CD pipeline - $(date '+%Y-%m-%d %H:%M:%S')" \
             --body "Automated test PR for CI/CD validation." \
             --base main \
             --head "$BRANCH_NAME"

echo "🎉 Push 完成並已建立 PR！"
echo "👉 請前往以下網址查看："
echo "https://github.com/Yoyoisadog/BasicInfraSideProject/pulls"
echo "https://github.com/Yoyoisadog/BasicInfraSideProject/actions"
