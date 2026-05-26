#!/bin/bash
#git checkout -b feature/你的功能名稱

echo "============================================"
echo "          CD 快速測試腳本"
echo "============================================"

# 1. 確保在 main 分支
echo "→ 切換到 main 分支..."
git checkout main

# 2. 拉取最新內容
echo "→ 拉取最新內容..."
git pull origin main

# 3. 建立一個小修改來觸發 commit
echo "→ 建立測試修改..."
echo "# Test CD Trigger - $(date)" >> README.md

# 4. 提交並 push
echo "→ 提交並 push 到 main（這會觸發 CD）..."
git add README.md
git commit -m "test: force trigger CD workflow"

if [ $? -eq 0 ]; then
    git push origin main
    echo ""
    echo "✅ Push 完成！"
    echo "請去 GitHub → Actions 頁面查看 CD workflow 是否正在運行"
else
    echo "❌ 沒有需要提交的變更"
fi

echo ""
echo "腳本執行完畢！"