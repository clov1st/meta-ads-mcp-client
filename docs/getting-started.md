# Memulai — Meta Ads MCP (Clovy v0.3)

## 1. Akun Clovy

1. Buka [https://meta-ads.clowy.biz.id/app/](https://meta-ads.clowy.biz.id/app/)
2. **Register** dengan email dan password
3. **Login**

## 2. Hubungkan Facebook

1. Buka menu **Integrations**
2. Klik **Connect Facebook**
3. Selesaikan login Meta — token long-lived disimpan di server (terenkripsi)
4. Anda bisa menambah **beberapa** koneksi Facebook

## 3. Buat API key

1. Buka menu **API Keys** (aktif setelah langkah 2)
2. **Create API key** — pilih **satu** koneksi Facebook untuk key ini
3. Salin `clowy-mcp-server-…` — hanya ditampilkan sekali

Aturan: **1 API key ↔ 1 koneksi Facebook**.

## 4. Config MCP client

**Cursor** — `%USERPROFILE%\.cursor\mcp.json`:

```json
{
  "mcpServers": {
    "Meta Ads MCP": {
      "url": "https://meta-ads.clowy.biz.id/mcp",
      "api-key": "clowy-mcp-server-..."
    }
  }
}
```

Restart Cursor → Settings → MCP → enabled.

## 5. Uji

Di chat Agent, jalankan `meta_ads_get_account_info` tanpa argumen token.

## Client lain

- [cursor.md](cursor.md)
- [claude.md](claude.md)
- [codex.md](codex.md)
