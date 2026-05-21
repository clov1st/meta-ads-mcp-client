# FAQ — Meta Ads MCP Client (v0.3+)

## Apakah saya masih perlu token Facebook di Cursor?

**Tidak** untuk production Clovy. Token Facebook disimpan di server setelah OAuth di dashboard. Client hanya mengirim **API key** (`clowy-mcp-server-…`) lewat header HTTP.

## Di mana membuat API key?

Dashboard → Login → Integrations (Facebook) → API Keys.

Production: [https://meta-ads.clowy.biz.id/app/](https://meta-ads.clowy.biz.id/app/)

## Kenapa menu API Keys terkunci?

Anda belum menghubungkan akun Facebook. Selesaikan **Integrations → Connect Facebook** dulu.

## Bisa beberapa akun Facebook?

Ya. Setiap koneksi bisa punya **maksimal satu** API key. Buat key terpisah per koneksi jika perlu.

## Format config Cursor yang benar

```json
{
  "mcpServers": {
    "Meta Ads MCP": {
      "url": "https://meta-ads.clowy.biz.id/mcp",
      "headers": {
        "api-key": "clowy-mcp-server-..."
      }
    }
  }
}
```

**Self-hosted:** ganti host, path tetap `/mcp`.

### Format yang sering salah

```json
"api-key": "clowy-mcp-server-..."
```

di **root** (sejajar dengan `url`) — Cursor MCP V2 sering **tidak** meneruskan ini. Gejala: `Using redirect URL`, `Cannot POST /register`, `Not connected`.

## MCP Logs: `Cannot POST /register`

Server Clovy **bukan** server OAuth MCP. Cursor mencoba registrasi OAuth karena header API key tidak terkirim. Perbaiki dengan **`headers.api-key`** dan pastikan key benar dari dashboard.

## 401 Unauthorized padahal config sudah pakai headers

Hampir selalu **API key salah**: typo, key lama, atau belum disalin lengkap dari dashboard. Buat key baru dan tempel ulang.

## Apakah `x-mcp-api-key` atau `x-fb-accestoken` masih dipakai?

Production v0.3+ memakai **`api-key`** (atau `x-api-key`) di header. `x-fb-accestoken` hanya untuk debugging / self-hosted lama.

## Token Facebook kedaluwarsa?

Long-lived token Meta (~60 hari). Jika tools gagal, dashboard → reconnect Facebook → buat key baru jika perlu.

## Health check (host production)

```bash
curl -s https://meta-ads.clowy.biz.id/healthz
curl -s https://meta-ads.clowy.biz.id/readyz
```

`readyz` tidak memvalidasi API key Anda — hanya kesiapan server Meta app.

## Codex: setup yang benar

```powershell
[System.Environment]::SetEnvironmentVariable("META_ADS_MCP_TOKEN", "clowy-mcp-server-...", "User")
codex mcp add meta_ads_mcp --url "https://meta-ads.clowy.biz.id/mcp" --bearer-token-env-var META_ADS_MCP_TOKEN
```

`codex mcp list` harus menampilkan **Bearer Token Env Var** = `META_ADS_MCP_TOKEN` dan **Auth** = `Bearer token`.

## Codex: masih `Unsupported` dan Bearer `-`

Belum ada `bearer_token_env_var` / env kosong. Ulangi setup di [codex.md](codex.md). **Jangan** pakai `$env:clowy-mcp-server-...` di PowerShell — nama env adalah `META_ADS_MCP_TOKEN`.

## Codex: `env_http_headers` vs Bearer

Keduanya valid. **Bearer + `META_ADS_MCP_TOKEN`** disarankan karena terlihat jelas di `codex mcp list`. Server menerima `Authorization: Bearer clowy-mcp-server-…` dan header `api-key`.

## Uji API key dari command line

```bash
curl -s -X POST "https://meta-ads.clowy.biz.id/mcp" \
  -H "Content-Type: application/json" \
  -H "api-key: clowy-mcp-server-YOUR_KEY" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}'
```

HTTP **401** = key invalid. Respons JSON-RPC (bukan HTML error) = key diterima.
