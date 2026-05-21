# Cursor — Meta Ads MCP (Clovy)

## Prasyarat

API key dari [dashboard Clovy](https://meta-ads.clowy.biz.id/app/) setelah Facebook terhubung.

## Config utama

File: `%USERPROFILE%\.cursor\mcp.json` (Windows) atau `~/.cursor/mcp.json`

```json
{
  "mcpServers": {
    "Meta Ads MCP": {
      "url": "https://meta-ads.clowy.biz.id/mcp",
      "api-key": "clowy-mcp-server-YOUR_KEY"
    }
  }
}
```

Restart Cursor sepenuhnya.

## Fallback header

Jika MCP Logs menunjukkan error API key / unauthorized, Cursor mungkin tidak meneruskan field root `api-key`. Gunakan:

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

## Variabel lingkungan

```json
"headers": {
  "api-key": "${env:CLOVY_MCP_API_KEY}"
}
```

PowerShell (sekali):

```powershell
[System.Environment]::SetEnvironmentVariable("CLOVY_MCP_API_KEY", "clowy-mcp-server-...", "User")
```

## Verifikasi

1. Settings → MCP → **Meta Ads MCP** enabled
2. Tool `meta_ads_get_account_info` di Agent chat
3. Output → MCP Logs jika gagal

## Troubleshooting

| Gejala | Solusi |
|--------|--------|
| 401 Unauthorized | Key salah / dicabut — buat key baru di dashboard |
| Facebook permission error | Reconnect Facebook di Integrations |
| Field ignored | Pakai `headers.api-key` fallback |

[faq.md](faq.md)
