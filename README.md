# Meta Ads MCP — Panduan Client (Clovy)

Dokumentasi untuk menghubungkan **Cursor**, **Claude**, **Codex**, dan client MCP lain ke server Meta Ads MCP Clovy.

> Repo ini hanya berisi **panduan client**. Kode server bersifat privat.

## Mulai di dashboard

1. Buka dashboard Clovy (production: **[https://meta-ads.clowy.biz.id/app/](https://meta-ads.clowy.biz.id/app/)**)
2. **Register** → **Login**
3. Menu **Integrations** → **Connect Facebook**
4. Menu **API Keys** (terbuka setelah Facebook terhubung) → **Create** → pilih koneksi Facebook → salin API key **sekali** (format `clowy-mcp-server-…`)

## Endpoint (production Clovy)

| Item | Nilai |
|------|--------|
| **MCP URL** | `https://meta-ads.clowy.biz.id/mcp` |
| **Dashboard** | `https://meta-ads.clowy.biz.id/app/` |

Self-hosted / host lain: ganti host, tetap path **`/mcp`** dan **`/app/`**.

## Config Cursor (disarankan)

Gunakan **`headers.api-key`** — ini format yang benar untuk Cursor saat ini (termasuk MCP V2). Field root `"api-key"` di luar `headers` sering **diabaikan**; Cursor lalu mencoba OAuth (`POST /register`) dan gagal.

File: `%USERPROFILE%\.cursor\mcp.json` (Windows) atau `~/.cursor/mcp.json`

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

Salin dari [`examples/cursor.mcp.json`](examples/cursor.mcp.json). Tanpa API key di commit — gunakan [`examples/cursor.mcp.json.env`](examples/cursor.mcp.json.env) + variabel `CLOVY_MCP_API_KEY`.

**Host sendiri:**

```json
{
  "mcpServers": {
    "Meta Ads MCP": {
      "url": "https://YOUR-HOST.example.com/mcp",
      "headers": {
        "api-key": "clowy-mcp-server-..."
      }
    }
  }
}
```

Restart Cursor sepenuhnya setelah menyimpan `mcp.json`.

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
