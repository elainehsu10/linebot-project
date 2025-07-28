# GitHub 推送完整指南 🚀

本指南將協助你將用藥提醒 LINE Bot 專案推送到 GitHub，並設定完整的 CI/CD 流程。

## 📋 推送前檢查清單

### ✅ 必要檔案準備
- [x] `.gitignore` - 已創建，排除敏感檔案
- [x] `README.md` - 已更新為 GitHub 版本
- [x] `LICENSE` - 需要創建
- [x] `.github/workflows/` - CI/CD 配置
- [x] 環境變數範本 `.env.example` - 已存在

### ✅ 敏感資訊檢查
確保以下檔案不會被推送：
- ❌ `.env` (實際環境變數)
- ❌ `*.json` (服務帳戶金鑰)
- ❌ `*.key`, `*.pem` (私鑰檔案)
- ❌ 任何包含 API 金鑰的檔案

## 🚀 步驟一：初始化 Git 倉庫

```bash
# 1. 進入專案目錄
cd linebot

# 2. 初始化 Git 倉庫
git init

# 3. 添加所有檔案
git add .

# 4. 檢查狀態，確認沒有敏感檔案
git status

# 5. 首次提交
git commit -m "Initial commit: 用藥提醒 LINE Bot 專案"
```

## 🌐 步驟二：創建 GitHub 倉庫

### 方法一：使用 GitHub CLI (推薦)
```bash
# 1. 安裝 GitHub CLI (如果尚未安裝)
# Windows: winget install GitHub.cli
# macOS: brew install gh
# Linux: 參考 https://cli.github.com/

# 2. 登入 GitHub
gh auth login

# 3. 創建倉庫並推送
gh repo create linebot-medication-reminder --public --source=. --remote=origin --push
```

### 方法二：手動創建
1. 前往 [GitHub](https://github.com) 並登入
2. 點擊右上角的 "+" → "New repository"
3. 填寫倉庫資訊：
   - Repository name: `linebot-medication-reminder`
   - Description: `智能用藥提醒 LINE Bot - 支援藥單辨識、家人綁定、健康記錄管理`
   - 選擇 Public 或 Private
   - **不要**勾選 "Initialize this repository with a README"
4. 點擊 "Create repository"

```bash
# 添加遠端倉庫
git remote add origin https://github.com/YOUR_USERNAME/linebot-medication-reminder.git

# 推送到 GitHub
git branch -M main
git push -u origin main
```

## ⚙️ 步驟三：設定 GitHub Actions

### 1. 創建 CI/CD 工作流程
```bash
# 創建 GitHub Actions 目錄
mkdir -p .github/workflows
```

### 2. 設定 Repository Secrets
前往 GitHub 倉庫 → Settings → Secrets and variables → Actions，添加以下 secrets：

#### 必要的 Secrets
```
# LINE Bot API 設定
LINE_CHANNEL_ACCESS_TOKEN=your_access_token
LINE_CHANNEL_SECRET=your_channel_secret
YOUR_BOT_ID=@your_bot_id

# LIFF 應用程式設定
LIFF_CHANNEL_ID=your_liff_channel_id
LIFF_ID_CAMERA=your_camera_liff_id
LIFF_ID_EDIT=your_edit_liff_id
LIFF_ID_PRESCRIPTION_REMINDER=your_prescription_reminder_liff_id
LIFF_ID_MANUAL_REMINDER=your_manual_reminder_liff_id
LIFF_ID_HEALTH_FORM=your_health_form_liff_id

# LINE Login 設定
LINE_LOGIN_CHANNEL_ID=your_login_channel_id
LINE_LOGIN_CHANNEL_SECRET=your_login_channel_secret

# Google Gemini API 設定
GEMINI_API_KEY=your_gemini_api_key

# MySQL 資料庫設定
DB_HOST=your_db_host
DB_USER=your_db_user
DB_PASS=your_db_password
DB_NAME=your_db_name
DB_PORT=3306

# Flask 設定
SECRET_KEY=your_secret_key
```

## 📁 步驟四：整理專案結構

### 1. 創建 LICENSE 檔案
```bash
# 創建 MIT License
cat > LICENSE << 'EOF'
MIT License

Copyright (c) 2024 Your Name

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF
```

### 2. 更新 README.md
```bash
# 替換現有的 README.md
mv README_GITHUB.md README.md
```

### 3. 創建貢獻指南
```bash
cat > CONTRIBUTING.md << 'EOF'
# 貢獻指南

感謝您對本專案的興趣！以下是貢獻指南：

## 如何貢獻

1. Fork 這個專案
2. 創建您的功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交您的變更 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 開啟一個 Pull Request

## 開發環境設定

請參考 README.md 中的快速開始章節。

## 程式碼風格

- 使用 Python PEP 8 風格
- 添加適當的註解和文檔字串
- 確保所有測試通過

## 報告問題

請使用 GitHub Issues 報告問題，並提供：
- 問題描述
- 重現步驟
- 預期行為
- 實際行為
- 環境資訊
EOF
```

## 🔄 步驟五：持續推送更新

### 日常開發流程
```bash
# 1. 拉取最新變更
git pull origin main

# 2. 創建功能分支
git checkout -b feature/new-feature

# 3. 進行開發...

# 4. 添加變更
git add .

# 5. 提交變更
git commit -m "feat: 添加新功能描述"

# 6. 推送分支
git push origin feature/new-feature

# 7. 在 GitHub 上創建 Pull Request
```

### 提交訊息規範
使用 [Conventional Commits](https://www.conventionalcommits.org/) 格式：

```
feat: 新功能
fix: 修復錯誤
docs: 文檔更新
style: 程式碼格式調整
refactor: 重構
test: 測試相關
chore: 維護任務
```

## 🛡️ 步驟六：安全性設定

### 1. 啟用 Dependabot
在 `.github/dependabot.yml` 中設定：
```yaml
version: 2
updates:
  - package-ecosystem: "pip"
    directory: "/"
    schedule:
      interval: "weekly"
```

### 2. 設定分支保護規則
前往 GitHub 倉庫 → Settings → Branches：
- 啟用 "Require pull request reviews before merging"
- 啟用 "Require status checks to pass before merging"
- 啟用 "Require branches to be up to date before merging"

## 📊 步驟七：監控和維護

### 1. 設定 Issue 和 PR 模板
```bash
mkdir -p .github/ISSUE_TEMPLATE
mkdir -p .github/PULL_REQUEST_TEMPLATE
```

### 2. 添加專案標籤
在 GitHub 倉庫中添加標籤：
- `bug` - 錯誤報告
- `enhancement` - 功能增強
- `documentation` - 文檔相關
- `good first issue` - 適合新手
- `help wanted` - 需要協助

## 🎉 完成！

恭喜！您的 LINE Bot 專案現在已經成功推送到 GitHub，並設定了完整的 CI/CD 流程。

### 下一步建議：
1. 📝 完善文檔和 API 說明
2. 🧪 增加更多測試覆蓋率
3. 🔧 設定自動部署到生產環境
4. 📊 添加監控和日誌分析
5. 🌟 邀請其他開發者貢獻

### 有用的連結：
- [GitHub Actions 文檔](https://docs.github.com/en/actions)
- [Docker 最佳實踐](https://docs.docker.com/develop/dev-best-practices/)
- [LINE Bot SDK 文檔](https://developers.line.biz/en/docs/messaging-api/)

---

如果遇到任何問題，請查看 GitHub Issues 或聯絡專案維護者。