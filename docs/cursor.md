# Cursor — Meta Ads MCP

## Endpoint

```text
https://meta-ads.clowy.biz.id/mcp
```

## Instalasi config

### Opsi A — File global (disarankan)

1. Salin [`examples/cursor.mcp.json`](../examples/cursor.mcp.json) atau [`examples/cursor.mcp.json.env`](../examples/cursor.mcp.json.env).
2. Simpan sebagai:
   - **Windows:** `%USERPROFILE%\.cursor\mcp.json`
   - **macOS / Linux:** `~/.cursor/mcp.json`
3. Isi token dan API key (lihat bawah).
4. **Restart Cursor** sepenuhnya.

### Opsi B — Per project

Salin ke `.cursor/mcp.json` di root workspace. Pastikan file ini **tidak** di-commit jika berisi token nyata.

## Config lengkap

```json
{
  "mcpServers": {
    "Meta Ads MCP": {
      "url": "https://meta-ads.clowy.biz.id/mcp",
      "headers": {
        "x-fb-accestoken": "EAAB...",
        "x-mcp-api-key": "your-mcp-api-key"
      }
    }
  }
}
```

### Pakai variabel lingkungan (lebih aman)

```json
{
  "mcpServers": {
    "Meta Ads MCP": {
      "url": "https://meta-ads.clowy.biz.id/mcp",
      "headers": {
        "x-fb-accestoken": "${env:FB_ACCESSTOKEN}",
        "x-mcp-api-key": "${env:MCP_API_KEY}"
      }
    }
  }
}
```

**Windows (PowerShell, sekali):**

```powershell
[System.Environment]::SetEnvironmentVariable("FB_ACCESSTOKEN", "EAAB...", "User")
[System.Environment]::SetEnvironmentVariable("MCP_API_KEY", "your-key", "User")
```

Tutup dan buka ulang Cursor setelah set env.

## Penting: jangan pakai field `fb_accestoken` di samping `url`

Cursor **tidak** meneruskan field custom di level atas ke server HTTP. Token harus di **`headers`**:

```json
"headers": { "x-fb-accestoken": "..." }
```

Bukan:

```json
"fb_accestoken": "..."
```

## Verifikasi

1. **Settings → MCP** — server **Meta Ads MCP** enabled (hijau).
2. **Output → MCP Logs** — tidak ada error 401/403.
3. Di chat Agent, jalankan tool `meta_ads_get_account_info` tanpa argumen `fb_accestoken`.
4. Harapan: JSON akun atau error permission Meta — **bukan** `Missing fb_accestoken`.

## Troubleshooting

| Gejala | Penyebab | Solusi |
|--------|----------|--------|
| `Missing fb_accestoken` | Header tidak terkirim | Pakai `headers.x-fb-accestoken`, restart Cursor |
| HTTP 401 | API key salah/kosong | Isi `x-mcp-api-key` dari administrator |
| HTTP 403 Origin | Jarang di Cursor desktop | Hubungi admin jika pakai client web |
| Timeout | Jaringan / firewall | Cek `curl https://meta-ads.clowy.biz.id/healthz` |
| Meta permission error | Scope token kurang | Perbarui token di Meta Developer / Business Manager |

Lihat juga [faq.md](faq.md).
