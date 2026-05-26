#!/bin/bash
# =============================================
# 實務 CI/CD 測試腳本 - 純 git 版本（不使用 gh）
# =============================================

set -e

echo "🚀 開始執行 CI/CD 測試流程（分支 + PR 模式）..."

cd "$(dirname "$0")" || exit 1

BRANCH_NAME="test/ci-cd-$(date '+%Y%m%d-%H%M%S')"

# 1. 暫存本地未 commit 的修改
if ! git diff --quiet; then
    echo "⚠️  偵測到未 commit 的修改，正在暫存..."
    git stash
    STASHED=true
else
    STASHED=false
fi

# 2. 更新 main 分支
git checkout main
git pull origin main

# 3. 切出新分支
git checkout -b "$BRANCH_NAME"

# 4. 還原暫存的修改（如果有）
if [ "$STASHED" = true ]; then
    echo "✅ 還原之前暫存的修改"
    git stash pop
fi

# 5. Stage & Commit
git add .
if git diff --cached --quiet; then
    echo "ℹ️  沒有變更，使用 --allow-empty commit"
    git commit --allow-empty -m "test: trigger CI/CD pipeline - $(date '+%Y-%m-%d %H:%M:%S')"
else
    git commit -m "test: trigger CI/CD pipeline - $(date '+%Y-%m-%d %H:%M:%S')"
fi

# 6. Push 到新分支
git push origin "$BRANCH_NAME"

echo "🎉 Push 完成！"
echo ""
echo "👉 請前往以下網址手動建立 Pull Request："
echo "   https://github.com/Yoyoisadog/BasicInfraSideProject/compare/main...$BRANCH_NAME"
echo ""
echo "👉 或直接前往 Actions 查看執行結果："
echo "   https://github.com/Yoyoisadog/BasicInfraSideProject/actions"