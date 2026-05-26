#!/bin/bash
git add README.md
git commit -m "test: trigger full CI/CD pipeline - $(date '+%Y-%m-%d %H:%M:%S')"
git push origin main
echo "✅ 已 push！現在請去 GitHub Actions 頁面觀看 workflow 執行中..."