#!/bin/bash
echo "#######把cd.yml加入git add .當中#######"
git add .
echo "#######提交commit訊息######"
git commit -m "fix: correct CD workflow syntax"
echo "#######推上去main分支######"
git push origin main