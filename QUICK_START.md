# 🚀 快速推送到 GitHub 指南

## 一鍵推送腳本

```bash
# 給腳本執行權限 (Linux/Mac)
chmod +x push_to_github.sh

# 執行推送腳本
./push_to_github.sh [repository-name] [github-username]

# 範例
./push_to_github.sh linebot-medication-reminder your-github-username
```

## 手動推送步驟

### 1. 初始化並推送
```bash
# 初始化 Git
git init

# 添加所有檔案
git add .

# 首次提交
git commit -m "Initial commit: 用藥提醒 LINE Bot 專案"

# 添加遠端倉庫 (替換為你的 GitHub 用戶名)
git remote add origin https://github.com/elainehsu10/linebot-project.git

# 推送到 GitHub
git branch -M main
git push -u origin main
```

### 2. 設定 GitHub Secrets
前往 GitHub 倉庫 → Settings → Secrets and variables → Actions，添加：

```
LINE_CHANNEL_ACCESS_TOKEN=你的LINE頻道存取權杖
LINE_CHANNEL_SECRET=你的LINE頻道密鑰
GEMINI_API_KEY=你的Gemini API金鑰
GCP_PROJECT_ID=你的GCP專案ID
GCP_SA_KEY=你的服務帳戶JSON金鑰內容
DB_HOST=你的資料庫主機
DB_USER=你的資料庫使用者
DB_PASS=你的資料庫密碼
DB_NAME=你的資料庫名稱
SECRET_KEY=你的Flask密鑰
```

### 3. 啟用功能
- ✅ GitHub Actions (自動啟用)
- ✅ Dependabot (自動更新依賴)
- ✅ 分支保護規則
- ✅ Issue 和 PR 模板

## 📁 已準備的檔案

### 核心檔案
- ✅ `.gitignore` - 排除敏感檔案
- ✅ `README.md` - GitHub 版本說明文件
- ✅ `LICENSE` - MIT 授權條款
- ✅ `CONTRIBUTING.md` - 貢獻指南

### CI/CD 配置
- ✅ `.github/workflows/ci-cd.yml` - 完整的 CI/CD 流程
- ✅ `.github/dependabot.yml` - 自動依賴更新

### 文檔
- ✅ `GITHUB_PUSH_GUIDE.md` - 詳細推送指南
- ✅ `QUICK_START.md` - 快速開始指南

## 🔒 安全檢查

確保以下檔案不會被推送：
- ❌ `.env` (實際環境變數)
- ❌ `*.json` (服務帳戶金鑰)
- ❌ `*.key`, `*.pem` (私鑰檔案)
- ❌ `cji25.json` (你的服務帳戶檔案)

## 🎯 下一步

1. 推送專案到 GitHub
2. 設定 GitHub Secrets
3. 測試 CI/CD 流程
4. 邀請協作者
5. 開始開發新功能！

---

需要幫助？查看 `GITHUB_PUSH_GUIDE.md` 獲取詳細說明。