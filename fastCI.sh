#!/bin/bash

echo "============================================"
echo "          Git 提交與 Push 工具"
echo "============================================"

# 檢查目前所在分支
current_branch=$(git branch --show-current)
echo "目前所在分支：$current_branch"

echo ""
read -p "請輸入 commit 訊息 (例如: feat: 新增登入功能) : " commit_msg

if [ -z "$commit_msg" ]; then
    echo "❌ commit 訊息不能為空！"
    exit 1
fi

echo ""
echo "正在執行提交流程..."

# 執行提交與 push
git add .
git commit -m "$commit_msg"

if [ $? -eq 0 ]; then
    echo "✅ Commit 成功，正在 push 到 GitHub..."
    git push origin "$current_branch"
    
    if [ $? -eq 0 ]; then
        echo "🎉 Push 完成！"
        echo "如果這是 feature 分支，請記得去 GitHub 開 Pull Request 來觸發 CI"
    else
        echo "❌ Push 失敗，請檢查網路或權限"
    fi
else
    echo "❌ 沒有需要提交的變更，或 commit 失敗"
fi

echo ""
echo "流程結束！"