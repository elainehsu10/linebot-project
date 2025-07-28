# 🚀 GitHub Actions 自動部署到 Cloud Run 指南

## 📋 部署架構

你的專案已經配置了完整的 CI/CD 流程：

```
GitHub Push → GitHub Actions → 測試 → 安全掃描 → Docker 建置 → Cloud Run 部署
```

### 部署分支策略
- **main 分支** → 自動部署到 **Production** 環境
- **develop 分支** → 自動部署到 **Staging** 環境

## ⚙️ 必要的 GitHub Secrets 設定

前往 GitHub 倉庫設定：https://github.com/elainehsu10/linebot-project/settings/secrets/actions

### 1. Google Cloud 設定
```
GCP_PROJECT_ID=你的GCP專案ID
GCP_SA_KEY=你的服務帳戶JSON金鑰內容
```

### 2. LINE Bot 設定
```
LINE_CHANNEL_ACCESS_TOKEN=你的LINE頻道存取權杖
LINE_CHANNEL_SECRET=你的LINE頻道密鑰
YOUR_BOT_ID=@你的BOT_ID
```

### 3. LIFF 設定
```
LIFF_CHANNEL_ID=你的LIFF頻道ID
LIFF_ID_CAMERA=相機LIFF_ID
LIFF_ID_EDIT=編輯LIFF_ID
LIFF_ID_PRESCRIPTION_REMINDER=處方提醒LIFF_ID
LIFF_ID_MANUAL_REMINDER=手動提醒LIFF_ID
LIFF_ID_HEALTH_FORM=健康表單LIFF_ID
```

### 4. LINE Login 設定
```
LINE_LOGIN_CHANNEL_ID=你的LINE_Login頻道ID
LINE_LOGIN_CHANNEL_SECRET=你的LINE_Login頻道密鑰
```

### 5. AI 服務設定
```
GEMINI_API_KEY=你的Gemini_API金鑰
```

### 6. 資料庫設定
```
DB_HOST=你的資料庫主機
DB_USER=你的資料庫使用者
DB_PASS=你的資料庫密碼
DB_NAME=你的資料庫名稱
DB_PORT=3306
```

### 7. 其他設定
```
SECRET_KEY=你的Flask密鑰
REMINDER_SECRET_TOKEN=提醒服務密鑰
```

## 🔧 Google Cloud 準備工作

### 1. 創建服務帳戶
```bash
# 設定專案 ID
export PROJECT_ID=你的專案ID

# 創建服務帳戶
gcloud iam service-accounts create github-actions \
    --description="Service account for GitHub Actions" \
    --display-name="GitHub Actions"

# 授予必要權限
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:github-actions@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/run.admin"

gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:github-actions@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/storage.admin"

gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:github-actions@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/iam.serviceAccountUser"

# 創建並下載金鑰
gcloud iam service-accounts keys create github-actions-key.json \
    --iam-account=github-actions@$PROJECT_ID.iam.gserviceaccount.com
```

### 2. 啟用必要的 API
```bash
# 啟用 Cloud Run API
gcloud services enable run.googleapis.com

# 啟用 Container Registry API
gcloud services enable containerregistry.googleapis.com

# 啟用 Cloud Build API
gcloud services enable cloudbuild.googleapis.com
```

## 🚀 部署流程

### 自動部署觸發條件

#### Production 部署 (main 分支)
```bash
# 推送到 main 分支會觸發 production 部署
git checkout main
git add .
git commit -m "feat: 新功能上線"
git push origin main
```

#### Staging 部署 (develop 分支)
```bash
# 推送到 develop 分支會觸發 staging 部署
git checkout -b develop
git add .
git commit -m "feat: 測試新功能"
git push origin develop
```

### 部署流程步驟
1. **代碼檢查** - 程式碼格式和語法檢查
2. **自動測試** - 運行所有測試案例
3. **安全掃描** - 檢查安全漏洞
4. **Docker 建置** - 建置容器映像
5. **推送映像** - 推送到 Google Container Registry
6. **部署服務** - 部署到 Cloud Run
7. **健康檢查** - 驗證部署成功

## 📊 監控部署狀態

### 1. GitHub Actions 監控
- 前往：https://github.com/elainehsu10/linebot-project/actions
- 查看部署進度和日誌

### 2. Cloud Run 監控
```bash
# 查看服務狀態
gcloud run services list --region=us-central1

# 查看服務詳情
gcloud run services describe linebot-app --region=us-central1

# 查看日誌
gcloud logs read "resource.type=cloud_run_revision" --limit=50
```

### 3. 服務 URL
- **Production**: https://linebot-app-[hash]-uc.a.run.app
- **Staging**: https://linebot-app-staging-[hash]-uc.a.run.app

## 🔄 手動部署 (緊急情況)

如果需要手動部署：

```bash
# 1. 建置映像
docker build -t gcr.io/$PROJECT_ID/linebot-app:manual .

# 2. 推送映像
docker push gcr.io/$PROJECT_ID/linebot-app:manual

# 3. 部署到 Cloud Run
gcloud run deploy linebot-app \
  --image gcr.io/$PROJECT_ID/linebot-app:manual \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated
```

## 🛠️ 故障排除

### 常見問題

#### 1. 權限錯誤
```
Error: The caller does not have permission
```
**解決方案**: 檢查服務帳戶權限設定

#### 2. 映像推送失敗
```
Error: denied: Permission denied
```
**解決方案**: 確認 Docker 認證設定

#### 3. 環境變數錯誤
```
Error: Missing required environment variable
```
**解決方案**: 檢查 GitHub Secrets 設定

### 除錯命令
```bash
# 查看 Cloud Run 服務日誌
gcloud logs read "resource.type=cloud_run_revision AND resource.labels.service_name=linebot-app" --limit=100

# 查看建置日誌
gcloud builds list --limit=10

# 測試服務健康狀態
curl -f https://your-service-url/health
```

## 📈 效能優化

### 1. 冷啟動優化
- 使用最小化的 Docker 映像
- 預熱重要的依賴

### 2. 自動擴展設定
```bash
gcloud run services update linebot-app \
  --min-instances=1 \
  --max-instances=10 \
  --concurrency=80 \
  --cpu=1 \
  --memory=512Mi \
  --region=us-central1
```

### 3. 監控設定
- 設定 Cloud Monitoring 警報
- 配置日誌分析

## 🔐 安全最佳實踐

1. **最小權限原則** - 服務帳戶只授予必要權限
2. **密鑰輪換** - 定期更新 API 金鑰
3. **網路安全** - 使用 VPC 和防火牆規則
4. **監控異常** - 設定安全監控警報

---

🎉 **恭喜！** 你的 LINE Bot 現在已經配置了完整的 CI/CD 自動部署流程！