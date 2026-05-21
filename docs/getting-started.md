# Memulai — Meta Ads MCP (Clovy v0.3+)

## 1. Akun Clovy

1. Buka dashboard (production: [https://meta-ads.clowy.biz.id/app/](https://meta-ads.clowy.biz.id/app/))
2. **Register** dengan email dan password
3. **Login**

Host lain: `https://YOUR-HOST/app/`

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

### Cursor (disarankan)

`%USERPROFILE%\.cursor\mcp.json` (Windows) atau `~/.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "Meta Ads MCP": {
      "url": "https://meta-ads.clowy.biz.id/mcp",
      "headers": {
        "api-key": "clowy-mcp-server-PASTE_KEY_DARI_DASHBOARD"
      }
    }
  }
}
```

Ganti host jika self-hosted: `https://YOUR-HOST/mcp`.

**Penting:** letakkan key di dalam **`headers`**, bukan field `"api-key"` di root objek server.

Restart Cursor → Settings → MCP → **Enabled**.

### Claude / Codex

Selalu kirim header `api-key` (lihat [claude.md](claude.md), [codex.md](codex.md)).

## 5. Uji

Di chat Agent (Cursor), jalankan `meta_ads_get_account_info` tanpa argumen token Facebook.

## Client lain

- [cursor.md](cursor.md)
- [claude.md](claude.md)
- [codex.md](codex.md)
