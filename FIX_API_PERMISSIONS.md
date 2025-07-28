# 🔧 修復 API 權限問題

## ⚠️ 問題說明

你的服務帳戶缺少啟用 API 的權限。需要手動啟用 API 或添加權限。

## 🚀 解決方案一：手動啟用 API（推薦）

在 Google Cloud Console 中手動啟用：

1. 前往：https://console.cloud.google.com/apis/library
2. 搜尋並啟用以下 API：
   - **Cloud Build API**
   - **Container Registry API** 
   - **Cloud Run API**
   - **IAM Service Account Credentials API**

## 🔧 解決方案二：添加 Service Usage Admin 權限

```bash
# 設定專案 ID
export PROJECT_ID=你的GCP專案ID

# 添加 Service Usage Admin 權限（允許啟用 API）
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:github-actions@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/serviceusage.serviceUsageAdmin"

# 或者使用更廣泛的 Editor 權限
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:github-actions@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/editor"
```

## 🎯 最小權限設定（推薦）

如果你想保持最小權限原則，手動啟用 API 後，只需要這些權限：

```bash
export PROJECT_ID=你的GCP專案ID

# Cloud Build 權限
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:github-actions@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/cloudbuild.builds.builder"

# Storage 權限（Container Registry 需要）
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:github-actions@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/storage.admin"

# Cloud Run 權限
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:github-actions@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/run.admin"

# Service Account User 權限
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:github-actions@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/iam.serviceAccountUser"
```

## ✅ 驗證設定

```bash
# 檢查 API 是否已啟用
gcloud services list --enabled --filter="name:cloudbuild.googleapis.com OR name:containerregistry.googleapis.com OR name:run.googleapis.com"

# 檢查服務帳戶權限
gcloud projects get-iam-policy $PROJECT_ID \
    --flatten="bindings[].members" \
    --format="table(bindings.role)" \
    --filter="bindings.members:github-actions@$PROJECT_ID.iam.gserviceaccount.com"
```

## 🚀 完成後

1. 手動啟用必要的 API
2. 設定服務帳戶權限
3. 推送程式碼測試部署

現在 GitHub Actions 不會因為 API 權限問題而失敗！