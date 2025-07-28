# 貢獻指南 🤝

感謝您對用藥提醒 LINE Bot 專案的興趣！我們歡迎所有形式的貢獻。

## 🚀 如何開始貢獻

### 1. Fork 專案
點擊 GitHub 頁面右上角的 "Fork" 按鈕

### 2. 克隆您的 Fork
```bash
git clone https://github.com/YOUR_USERNAME/linebot-medication-reminder.git
cd linebot-medication-reminder
```

### 3. 設定開發環境
```bash
# 安裝依賴
pip install -r requirements.txt

# 複製環境變數範本
cp .env.example .env

# 編輯 .env 檔案，填入您的設定
```

### 4. 創建功能分支
```bash
git checkout -b feature/your-feature-name
```

## 📝 開發指南

### 程式碼風格
- 遵循 PEP 8 Python 程式碼風格
- 使用 Black 進行程式碼格式化：`black app/`
- 使用 flake8 進行程式碼檢查：`flake8 app/`
- 添加適當的註解和文檔字串

### 提交訊息規範
使用 [Conventional Commits](https://www.conventionalcommits.org/) 格式：

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

類型包括：
- `feat`: 新功能
- `fix`: 修復錯誤
- `docs`: 文檔更新
- `style`: 程式碼格式調整（不影響功能）
- `refactor`: 重構程式碼
- `test`: 添加或修改測試
- `chore`: 維護任務

範例：
```
feat(reminder): 添加自定義提醒間隔功能

允許用戶設定自定義的提醒間隔時間，支援分鐘、小時、天為單位。

Closes #123
```

### 測試
- 為新功能添加測試
- 確保所有測試通過：`pytest tests/`
- 檢查測試覆蓋率：`pytest --cov=app tests/`

## 🐛 報告問題

使用 [GitHub Issues](https://github.com/your-username/linebot-medication-reminder/issues) 報告問題時，請提供：

- **問題描述**：清楚描述遇到的問題
- **重現步驟**：詳細的重現步驟
- **預期行為**：您期望發生什麼
- **實際行為**：實際發生了什麼
- **環境資訊**：
  - 作業系統
  - Python 版本
  - 相關套件版本
- **截圖**：如果適用的話

## 💡 功能請求

提出新功能建議時，請說明：
- **功能描述**：詳細描述建議的功能
- **使用場景**：說明這個功能的使用場景
- **預期效益**：這個功能能帶來什麼好處
- **實作建議**：如果有的話，提供實作想法

## 🔄 Pull Request 流程

### 1. 確保您的分支是最新的
```bash
git checkout main
git pull upstream main
git checkout your-feature-branch
git rebase main
```

### 2. 運行測試和檢查
```bash
# 程式碼格式化
black app/

# 程式碼檢查
flake8 app/

# 運行測試
pytest tests/

# 安全性檢查
bandit -r app/
```

### 3. 提交並推送
```bash
git add .
git commit -m "feat: your feature description"
git push origin your-feature-branch
```

### 4. 創建 Pull Request
- 前往 GitHub 並創建 Pull Request
- 填寫 PR 模板
- 確保 CI 檢查通過
- 等待程式碼審查

## 📋 Pull Request 檢查清單

- [ ] 程式碼遵循專案風格指南
- [ ] 添加了適當的測試
- [ ] 所有測試通過
- [ ] 更新了相關文檔
- [ ] 提交訊息遵循規範
- [ ] 沒有合併衝突
- [ ] CI 檢查通過

## 🏷️ 標籤說明

- `bug` - 錯誤報告
- `enhancement` - 功能增強
- `documentation` - 文檔相關
- `good first issue` - 適合新手的問題
- `help wanted` - 需要協助
- `question` - 問題討論
- `wontfix` - 不會修復
- `duplicate` - 重複問題

## 🎯 開發優先級

### 高優先級
- 安全性問題修復
- 重要錯誤修復
- 效能優化

### 中優先級
- 新功能開發
- 使用者體驗改善
- 程式碼重構

### 低優先級
- 文檔改善
- 程式碼風格調整
- 非關鍵功能

## 🤔 需要幫助？

如果您有任何問題或需要協助：

1. 查看 [README.md](README.md) 和現有文檔
2. 搜尋現有的 [Issues](https://github.com/your-username/linebot-medication-reminder/issues)
3. 在 [Discussions](https://github.com/your-username/linebot-medication-reminder/discussions) 中提問
4. 聯絡專案維護者

## 📜 行為準則

請遵循我們的行為準則：

- 尊重所有參與者
- 建設性的討論和回饋
- 專注於對專案最有利的事情
- 展現同理心

## 🙏 致謝

感謝所有貢獻者的努力！您的貢獻讓這個專案變得更好。

---

再次感謝您的貢獻！🎉