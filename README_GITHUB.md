# 用藥提醒 LINE Bot 🏥💊

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.11](https://img.shields.io/badge/python-3.11-blue.svg)](https://www.python.org/downloads/release/python-3110/)
[![Flask](https://img.shields.io/badge/Flask-3.1.1-green.svg)](https://flask.palletsprojects.com/)
[![LINE Bot SDK](https://img.shields.io/badge/LINE%20Bot%20SDK-3.17.1-brightgreen.svg)](https://github.com/line/line-bot-sdk-python)

一個智能的 LINE Bot 應用程式，幫助用戶管理藥物提醒、辨識藥品、記錄健康狀況，並支援家人綁定功能。

## ✨ 主要功能

- 📋 **藥單辨識**: 使用 AI 技術自動辨識藥單照片，提取藥品資訊
- ⏰ **用藥提醒**: 智能提醒系統，支援多種提醒模式和時間設定
- 👨‍👩‍👧‍👦 **家人綁定**: 家庭成員互相關心，共同管理健康狀況
- 🗂️ **藥歷管理**: 完整的用藥記錄管理系統，可查看、編輯、刪除記錄
- 📊 **健康記錄**: 記錄和追蹤健康狀況，支援多種健康指標
- 🤖 **AI 助手**: 基於 Google Gemini 的智能對話功能

## 🏗️ 技術架構

### 核心技術棧
- **後端框架**: Flask 3.1.1
- **LINE Bot SDK**: line-bot-sdk 3.17.1
- **AI 服務**: Google Gemini API
- **資料庫**: MySQL 8.0
- **容器化**: Docker & Docker Compose
- **部署平台**: Google Cloud Run
- **前端**: LINE LIFF (LINE Front-end Framework)

### 系統架構圖
```
📱 LINE 用戶端
    ↕️ (Webhook/LIFF)
🌐 Flask 應用伺服器
    ↕️ (SQL)
🗄️ MySQL 資料庫
    ↕️ (API)
🤖 Google Gemini AI
```

## 🚀 快速開始

### 前置需求
- Python 3.11+
- Docker & Docker Compose
- MySQL 8.0
- LINE Developer Account
- Google Cloud Account (for Gemini API)

### 1. 克隆專案
```bash
git clone https://github.com/your-username/linebot-medication-reminder.git
cd linebot-medication-reminder
```

### 2. 環境設定
```bash
# 複製環境變數範本
cp .env.example .env

# 編輯 .env 檔案，填入你的 API 金鑰和設定
nano .env
```

### 3. 使用 Docker 啟動
```bash
# 啟動所有服務
docker-compose up -d

# 查看服務狀態
docker-compose ps

# 查看日誌
docker-compose logs -f app
```

### 4. 本地開發
```bash
# 安裝依賴
pip install -r requirements.txt

# 啟動開發伺服器
python run.py
```

## 📋 環境變數設定

在 `.env` 檔案中設定以下變數：

### LINE Bot 設定
```env
LINE_CHANNEL_ACCESS_TOKEN=your_line_channel_access_token
LINE_CHANNEL_SECRET=your_line_channel_secret
YOUR_BOT_ID=@your_bot_id
```

### LIFF 應用程式設定
```env
LIFF_CHANNEL_ID=your_liff_channel_id
LIFF_ID_CAMERA=your_camera_liff_id
LIFF_ID_EDIT=your_edit_liff_id
LIFF_ID_PRESCRIPTION_REMINDER=your_prescription_reminder_liff_id
LIFF_ID_MANUAL_REMINDER=your_manual_reminder_liff_id
LIFF_ID_HEALTH_FORM=your_health_form_liff_id
```

### 資料庫設定
```env
DB_HOST=localhost
DB_USER=root
DB_PASS=your_db_password
DB_NAME=pill_test
DB_PORT=3306
```

### AI 服務設定
```env
GEMINI_API_KEY=your_gemini_api_key
```

## 🏗️ 專案結構

```
linebot/
├── app/                          # 主要應用程式
│   ├── routes/                   # 路由處理
│   │   ├── handlers/            # 訊息處理器
│   │   ├── auth.py              # 認證相關
│   │   ├── line_webhook.py      # LINE Webhook
│   │   └── liff_views.py        # LIFF 視圖
│   ├── services/                # 業務邏輯服務
│   │   ├── ai_processor.py      # AI 處理服務
│   │   ├── family_service.py    # 家人管理服務
│   │   ├── prescription_service.py # 藥歷服務
│   │   └── reminder_service.py  # 提醒服務
│   ├── templates/               # HTML 模板
│   ├── utils/                   # 工具函數
│   │   ├── flex/               # Flex Message 模板
│   │   ├── db.py               # 資料庫工具
│   │   └── helpers.py          # 輔助函數
│   └── __init__.py             # Flask 應用初始化
├── md/                          # 文檔
├── config.py                    # 配置管理
├── run.py                       # 應用啟動入口
├── requirements.txt             # Python 依賴
├── Dockerfile                   # Docker 配置
├── docker-compose.yml           # Docker Compose 配置
└── .env.example                 # 環境變數範本
```

## 🔧 部署指南

### Google Cloud Run 部署

1. **準備 Google Cloud 專案**
```bash
# 設定專案 ID
gcloud config set project YOUR_PROJECT_ID

# 啟用必要的 API
gcloud services enable run.googleapis.com
gcloud services enable cloudbuild.googleapis.com
```

2. **建置並部署**
```bash
# 建置 Docker 映像
gcloud builds submit --tag gcr.io/YOUR_PROJECT_ID/linebot-app

# 部署到 Cloud Run
gcloud run deploy linebot-app \
  --image gcr.io/YOUR_PROJECT_ID/linebot-app \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated
```

3. **設定環境變數**
```bash
# 在 Cloud Run 控制台中設定環境變數
# 或使用 gcloud 命令設定
gcloud run services update linebot-app \
  --set-env-vars="LINE_CHANNEL_ACCESS_TOKEN=your_token"
```

### 本地 Docker 部署
```bash
# 建置映像
docker build -t linebot-app .

# 執行容器
docker run -p 8080:8080 --env-file .env linebot-app
```

## 📚 功能說明

### 藥單辨識流程
1. 用戶透過 LIFF 拍攝或上傳藥單照片
2. AI 自動辨識藥品名稱、用法用量
3. 用戶確認並編輯辨識結果
4. 系統保存到藥歷記錄

### 家人綁定系統
1. 用戶生成邀請碼
2. 分享給家人
3. 家人輸入邀請碼完成綁定
4. 支援雙向健康狀況通知

### 用藥提醒功能
1. 從藥歷記錄設定提醒
2. 或手動新增提醒
3. 支援多種提醒頻率
4. 家人也會收到提醒通知

## 🧪 測試

```bash
# 執行單元測試
python -m pytest tests/

# 執行特定測試
python -m pytest tests/test_ai_processor.py

# 查看測試覆蓋率
python -m pytest --cov=app tests/
```

## 📝 API 文檔

### Webhook 端點
- `POST /webhook` - LINE Bot Webhook
- `GET /health` - 健康檢查

### LIFF 端點
- `GET /camera` - 藥單拍攝頁面
- `GET /edit` - 編輯藥品資訊頁面
- `GET /reminder` - 提醒設定頁面
- `GET /health-form` - 健康記錄表單

## 🤝 貢獻指南

1. Fork 這個專案
2. 創建你的功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交你的變更 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 開啟一個 Pull Request

## 📄 授權條款

本專案採用 MIT 授權條款 - 詳見 [LICENSE](LICENSE) 檔案

## 🆘 支援與聯絡

- 📧 Email: your-email@example.com
- 🐛 Issue Tracker: [GitHub Issues](https://github.com/your-username/linebot-medication-reminder/issues)
- 📖 文檔: [專案文檔](./md/)

## 🙏 致謝

- [LINE Developers](https://developers.line.biz/) - LINE Bot 平台
- [Google Gemini](https://ai.google.dev/) - AI 服務
- [Flask](https://flask.palletsprojects.com/) - Web 框架
- 所有貢獻者和使用者

---

**注意**: 請確保在生產環境中妥善保護您的 API 金鑰和敏感資訊。