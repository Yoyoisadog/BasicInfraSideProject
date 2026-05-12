#!/bin/bash

DOMAIN="infra-love-milk123456.duckdns.org"
VOTE_COUNT=${1:-10}   # 預設灌 10 票，可自行指定數字

echo "開始對 Cat 灌票 $VOTE_COUNT 次..."

for i in $(seq 1 $VOTE_COUNT); do
    curl -s -X POST http://$DOMAIN/ \
         -d "vote=a" \
         -H "Content-Type: application/x-www-form-urlencoded" \
         -o /dev/null && \
    echo "第 $i 票 (Cat) 已送出" || \
    echo "第 $i 票 失敗"
    
    sleep 0.3   # 避免太快被擋
done

echo "=== 灌票完成！ ==="
echo "請去 /result/ 頁面強制刷新 (Ctrl + Shift + R) 查看結果"
