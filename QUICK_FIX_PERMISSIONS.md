# 🚀 快速修復 GCP 權限問題

## 🔧 立即執行這些命令

```bash
# 1. 設定你的專案 ID
export PROJECT_ID=你的實際GCP專案ID

# 2. 添加 Cloud Build 權限
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:github-actions@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/cloudbuild.builds.builder"

# 3. 添加 Storage 權限
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:github-actions@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/storage.admin"

# 4. 添加 Cloud Run 權限
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:github-actions@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/run.admin"

# 5. 添加 Service Account User 權限
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:github-actions@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/iam.serviceAccountUser"

# 6. 啟用必要的 API
gcloud services enable cloudbuild.googleapis.com
gcloud services enable containerregistry.googleapis.com
gcloud services enable run.googleapis.com
```

## ✅ 驗證權限

```bash
# 檢查服務帳戶權限
gcloud projects get-iam-policy $PROJECT_ID \
    --flatten="bindings[].members" \
    --format="table(bindings.role)" \
    --filter="bindings.members:github-actions@$PROJECT_ID.iam.gserviceaccount.com"
```

## 🎯 現在的部署流程

使用 Cloud Build 的優勢：
- ✅ 不需要本地 Docker 建置
- ✅ 自動處理認證
- ✅ 更快的建置速度
- ✅ 更好的安全性

執行完上面的命令後，推送程式碼就可以成功部署了！