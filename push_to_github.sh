#!/bin/bash

# 用藥提醒 LINE Bot - GitHub 推送腳本
# 使用方法: ./push_to_github.sh [repository-name] [github-username]

set -e  # 遇到錯誤時停止執行

# 顏色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 函數：印出彩色訊息
print_message() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_step() {
    echo -e "${BLUE}[STEP]${NC} $1"
}

# 預設值
REPO_NAME=${1:-"linebot-medication-reminder"}
GITHUB_USERNAME=${2:-"your-username"}

print_message "開始準備推送用藥提醒 LINE Bot 到 GitHub..."
echo "Repository: $REPO_NAME"
echo "GitHub Username: $GITHUB_USERNAME"
echo ""

# 步驟 1: 檢查必要工具
print_step "1. 檢查必要工具..."

if ! command -v git &> /dev/null; then
    print_error "Git 未安裝，請先安裝 Git"
    exit 1
fi

if ! command -v gh &> /dev/null; then
    print_warning "GitHub CLI 未安裝，將使用手動方式創建倉庫"
    USE_GH_CLI=false
else
    USE_GH_CLI=true
fi

print_message "工具檢查完成"

# 步驟 2: 檢查敏感檔案
print_step "2. 檢查敏感檔案..."

SENSITIVE_FILES=(".env" "*.json" "*.key" "*.pem" "cji25.json")
FOUND_SENSITIVE=false

for pattern in "${SENSITIVE_FILES[@]}"; do
    if ls $pattern 1> /dev/null 2>&1; then
        print_warning "發現敏感檔案: $pattern"
        FOUND_SENSITIVE=true
    fi
done

if [ "$FOUND_SENSITIVE" = true ]; then
    print_warning "發現敏感檔案，請確認這些檔案已加入 .gitignore"
    read -p "是否繼續？(y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_error "已取消推送"
        exit 1
    fi
fi

print_message "敏感檔案檢查完成"

# 步驟 3: 更新 README.md
print_step "3. 更新 README.md..."

if [ -f "README_GITHUB.md" ]; then
    # 備份原始 README
    if [ -f "README.md" ]; then
        cp README.md README_original.md
        print_message "已備份原始 README.md 為 README_original.md"
    fi
    
    # 使用 GitHub 版本的 README
    cp README_GITHUB.md README.md
    print_message "已更新 README.md 為 GitHub 版本"
else
    print_warning "未找到 README_GITHUB.md，使用現有的 README.md"
fi

# 步驟 4: 初始化 Git 倉庫
print_step "4. 初始化 Git 倉庫..."

if [ ! -d ".git" ]; then
    git init
    print_message "已初始化 Git 倉庫"
else
    print_message "Git 倉庫已存在"
fi

# 步驟 5: 添加檔案並提交
print_step "5. 添加檔案並提交..."

git add .

# 檢查是否有檔案被添加
if git diff --cached --quiet; then
    print_warning "沒有檔案需要提交"
else
    git commit -m "Initial commit: 用藥提醒 LINE Bot 專案

✨ 主要功能:
- 📋 藥單辨識 (AI 技術)
- ⏰ 用藥提醒系統
- 👨‍👩‍👧‍👦 家人綁定功能
- 🗂️ 藥歷管理
- 📊 健康記錄
- 🤖 AI 助手 (Google Gemini)

🏗️ 技術架構:
- Flask 3.1.1
- LINE Bot SDK 3.17.1
- MySQL 8.0
- Docker & Docker Compose
- Google Cloud Run"

    print_message "已完成初始提交"
fi

# 步驟 6: 創建 GitHub 倉庫
print_step "6. 創建 GitHub 倉庫..."

if [ "$USE_GH_CLI" = true ]; then
    # 使用 GitHub CLI
    print_message "使用 GitHub CLI 創建倉庫..."
    
    # 檢查是否已登入
    if ! gh auth status &> /dev/null; then
        print_message "請先登入 GitHub CLI..."
        gh auth login
    fi
    
    # 創建倉庫並推送
    gh repo create "$REPO_NAME" --public --source=. --remote=origin --push --description "智能用藥提醒 LINE Bot - 支援藥單辨識、家人綁定、健康記錄管理"
    
    print_message "已使用 GitHub CLI 創建倉庫並推送"
else
    # 手動方式
    print_message "請手動創建 GitHub 倉庫："
    echo "1. 前往 https://github.com/new"
    echo "2. Repository name: $REPO_NAME"
    echo "3. Description: 智能用藥提醒 LINE Bot - 支援藥單辨識、家人綁定、健康記錄管理"
    echo "4. 選擇 Public"
    echo "5. 不要勾選 'Initialize this repository with a README'"
    echo "6. 點擊 'Create repository'"
    echo ""
    
    read -p "已創建 GitHub 倉庫？(y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_error "請先創建 GitHub 倉庫"
        exit 1
    fi
    
    # 添加遠端倉庫並推送
    git remote add origin "https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"
    git branch -M main
    git push -u origin main
    
    print_message "已推送到 GitHub"
fi

# 步驟 7: 設定提醒
print_step "7. 後續設定提醒..."

echo ""
print_message "🎉 專案已成功推送到 GitHub！"
echo ""
print_warning "請記得完成以下設定："
echo "1. 前往 GitHub 倉庫 Settings → Secrets and variables → Actions"
echo "2. 添加必要的 Secrets (參考 GITHUB_PUSH_GUIDE.md)"
echo "3. 設定分支保護規則"
echo "4. 啟用 GitHub Actions"
echo "5. 更新 README.md 中的 GitHub 連結"
echo ""
print_message "倉庫連結: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
print_message "詳細設定指南請參考: GITHUB_PUSH_GUIDE.md"
echo ""
print_message "推送完成！🚀"