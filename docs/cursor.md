# Cursor — Meta Ads MCP (Clovy)

## Prasyarat

API key dari dashboard Clovy setelah Facebook terhubung (production: [meta-ads.clowy.biz.id/app](https://meta-ads.clowy.biz.id/app/)).

Key harus persis seperti di dashboard, termasuk awalan `clowy-mcp-server-`.

## Config yang disarankan (semua host)

File: `%USERPROFILE%\.cursor\mcp.json` (Windows) atau `~/.cursor/mcp.json`

```json
{
  "mcpServers": {
    "Meta Ads MCP": {
      "url": "https://meta-ads.clowy.biz.id/mcp",
      "headers": {
        "api-key": "clowy-mcp-server-YOUR_KEY"
      }
    }
  }
}
```

**Self-hosted:** ganti URL menjadi `https://YOUR-HOST/mcp` (path `/mcp` wajib sama).

**Jangan** mengandalkan field ini saja di root config (sering tidak dikirim ke server):

```json
"api-key": "clowy-mcp-server-..."
```

## Variabel lingkungan (disarankan untuk commit aman)

```json
{
  "mcpServers": {
    "Meta Ads MCP": {
      "url": "https://meta-ads.clowy.biz.id/mcp",
      "headers": {
        "api-key": "${env:CLOVY_MCP_API_KEY}"
      }
    }
  }
}
```

PowerShell (sekali):

```powershell
[System.Environment]::SetEnvironmentVariable("CLOVY_MCP_API_KEY", "clowy-mcp-server-...", "User")
```

Contoh lengkap: [`examples/cursor.mcp.json.env`](../examples/cursor.mcp.json.env).

Restart Cursor sepenuhnya setelah mengubah `mcp.json`.

## Verifikasi

1. Settings → MCP → **Meta Ads MCP** = **Enabled**
2. Di Agent chat, panggil tool `meta_ads_get_account_info`
3. Jika gagal: **Output → MCP Logs**

Uji key dari terminal (ganti host dan key):

```powershell
$key = "clowy-mcp-server-..."
$body = '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}'
Invoke-WebRequest -Uri "https://meta-ads.clowy.biz.id/mcp" -Method POST `
  -Headers @{ "Content-Type"="application/json"; "api-key"=$key } `
  -Body $body -UseBasicParsing | Select-Object StatusCode
```

Status **200** = key dan server OK (masalah hanya di Cursor config). Status **401** = key salah, dicabut, atau belum dibuat di dashboard.

## Troubleshooting

| Gejala di MCP Logs | Penyebab | Solusi |
|--------------------|----------|--------|
| `Cannot POST /register`, OAuth, `Using redirect URL` | Cursor mengira server pakai OAuth MCP; header `api-key` tidak terkirim | Pakai **`headers.api-key`**, bukan root `api-key` |
| `Not connected`, `auth=unknown` | Sama seperti di atas, atau server disabled | Perbaiki config; enable server di Settings → MCP |
| `401 Unauthorized` | API key salah / typo / key lama dicabut | Buat key baru di dashboard; tempel ulang di `headers` |
| Facebook permission error | Token Meta kedaluwarsa | Dashboard → Integrations → reconnect Facebook |
| `403 Origin is not allowed` | `STRICT_ORIGIN_GUARD` di server | Minta admin menambah origin atau nonaktifkan sementara |

Server Clovy **tidak** mendukung OAuth MCP (`/register`). OAuth di dashboard hanya untuk menghubungkan akun Facebook ke server, bukan untuk koneksi Cursor.

## Header alternatif (server menerima)

| Header | Nilai |
|--------|--------|
| `api-key` | `clowy-mcp-server-…` (disarankan) |
| `x-api-key` | sama |
| `x-mcp-api-key` | sama |
| `Authorization` | `Bearer clowy-mcp-server-…` |

[faq.md](faq.md)
