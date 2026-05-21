# Meta Ads MCP — Panduan Client (Clovy)

Dokumentasi untuk menghubungkan **Cursor**, **Claude**, **Codex**, dan client MCP lain ke server Meta Ads MCP Clovy.

> Repo ini hanya berisi **panduan client**. Kode server bersifat privat.

## Mulai di dashboard

1. Buka **[https://meta-ads.clowy.biz.id/app/](https://meta-ads.clowy.biz.id/app/)**
2. **Register** → **Login**
3. Menu **Integrations** → **Connect Facebook**
4. Menu **API Keys** (terbuka setelah Facebook terhubung) → **Create** → pilih koneksi Facebook → salin API key

## Endpoint

| Item | Nilai |
|------|--------|
| **MCP URL** | `https://meta-ads.clowy.biz.id/mcp` |
| **Dashboard** | `https://meta-ads.clowy.biz.id/app/` |
| **Versi server** | `0.3.0` |

## Config Cursor (utama)

```json
{
  "mcpServers": {
    "Meta Ads MCP": {
      "url": "https://meta-ads.clowy.biz.id/mcp",
      "api-key": "clowy-mcp-server-PASTE_FROM_DASHBOARD"
    }
  }
}
```

Salin dari [`examples/cursor.mcp.json`](examples/cursor.mcp.json).

### Jika Cursor tidak mengenali `api-key` di root

Gunakan header (perilaku server sama):

```json
{
  "mcpServers": {
    "Meta Ads MCP": {
      "url": "https://meta-ads.clowy.biz.id/mcp",
      "headers": {
        "api-key": "clowy-mcp-server-PASTE_FROM_DASHBOARD"
      }
    }
  }
}
```

Atau env: [`examples/cursor.mcp.json.env`](examples/cursor.mcp.json.env).

## Panduan lengkap

| Topik | Dokumen |
|-------|---------|
| Memulai | [docs/getting-started.md](docs/getting-started.md) |
| Cursor | [docs/cursor.md](docs/cursor.md) |
| Claude | [docs/claude.md](docs/claude.md) |
| Codex | [docs/codex.md](docs/codex.md) |
| Tools MCP | [docs/tools.md](docs/tools.md) |
| FAQ | [docs/faq.md](docs/faq.md) |

## Keamanan

- Jangan commit `mcp.json` dengan API key nyata
- Revoke key di dashboard jika bocor
- Satu API key = satu koneksi Facebook

## Lisensi

[MIT](LICENSE)
