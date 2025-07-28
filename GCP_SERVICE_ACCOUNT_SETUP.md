# 🔑 Google Cloud 服務帳戶設定指南

## 📋 必要權限

你的服務帳戶需要以下權限才能成功部署：

### 1. 建立服務帳戶

```bash
# 設定專案 ID
export PROJECT_ID=你的專案ID

# 建立服務帳戶
gcloud iam service-accounts create github-actions \
    --description="Service account for GitHub Actions deployment" \
    --display-name="GitHub Actions Deployment"
```

### 2. 授予必要權限

```bash
# Cloud Run 管理權限
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:github-actions@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/run.admin"

# Container Registry 權限
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:github-actions@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/storage.admin"

# Artifact Registry 權限
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:github-actions@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/artifactregistry.admin"

# Service Account User 權限
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:github-actions@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/iam.serviceAccountUser"

# Cloud Build 權限（如果需要）
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:github-actions@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/cloudbuild.builds.editor"
```

### 3. 建立並下載金鑰

```bash
# 建立金鑰檔案
gcloud iam service-accounts keys create github-actions-key.json \
    --iam-account=github-actions@$PROJECT_ID.iam.gserviceaccount.com

# 顯示金鑰內容（複製到 GitHub Secrets）
cat github-actions-key.json
```

## 🔧 啟用必要的 API

```bash
# 啟用 Cloud Run API
gcloud services enable run.googleapis.com

# 啟用 Container Registry API
gcloud services enable containerregistry.googleapis.com

# 啟用 Artifact Registry API
gcloud services enable artifactregistry.googleapis.com

# 啟用 Cloud Build API
gcloud services enable cloudbuild.googleapis.com

# 啟用 IAM API
gcloud services enable iam.googleapis.com
```

## 📝 設定 GitHub Secrets

將以下內容添加到 GitHub Secrets：

### GCP_PROJECT_ID
```
你的GCP專案ID
```

### GCP_SA_KEY
```json
{
  "type": "service_account",
  "project_id": "你的專案ID",
  "private_key_id": "...",
  "private_key": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n",
  "client_email": "github-actions@你的專案ID.iam.gserviceaccount.com",
  "client_id": "...",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "..."
}
```

## ⚠️ 常見問題解決

### 1. 權限不足錯誤
```
denied: Unauthenticated request
```

**解決方案**：
- 確認服務帳戶有 `roles/storage.admin` 權限
- 確認 Container Registry API 已啟用

### 2. 專案 ID 錯誤
```
project not found
```

**解決方案**：
- 確認 `GCP_PROJECT_ID` 設定正確
- 確認專案存在且可存取

### 3. 金鑰格式錯誤
```
invalid service account key
```

**解決方案**：
- 確認 JSON 格式完整且正確
- 不要有額外的空格或換行

## 🧪 測試服務帳戶

```bash
# 使用服務帳戶認證
gcloud auth activate-service-account --key-file=github-actions-key.json

# 測試權限
gcloud run services list --region=us-central1

# 測試 Container Registry 權限
gcloud auth configure-docker gcr.io
```

## 🔒 安全最佳實踐

1. **最小權限原則** - 只授予必要的權限
2. **定期輪換金鑰** - 建議每 90 天更新一次
3. **監控使用情況** - 在 Cloud Console 中監控服務帳戶活動
4. **限制 IP 範圍** - 如果可能，限制服務帳戶的使用 IP

## 📊 驗證設定

設定完成後，推送程式碼到 GitHub，檢查：

1. GitHub Actions 是否成功認證
2. Docker 映像是否成功推送到 GCR
3. Cloud Run 服務是否成功部署

---

如果仍有問題，請檢查 GitHub Actions 日誌中的詳細錯誤訊息。