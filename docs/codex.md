# Codex — Meta Ads MCP (Clovy)

## 1. API key dari dashboard

[https://meta-ads.clowy.biz.id/app/](https://meta-ads.clowy.biz.id/app/) → API Keys → salin `clowy-mcp-server-…`

Self-hosted: ganti host, path tetap `/mcp`.

## 2. Variabel lingkungan (Windows)

```powershell
[System.Environment]::SetEnvironmentVariable("CLOVY_MCP_API_KEY", "clowy-mcp-server-...", "User")
```

Buka terminal Codex **baru** setelah ini.

## 3. Config `~/.codex/config.toml`

`codex mcp list` dengan **Auth: Unsupported** dan **Bearer Token Env Var: -** artinya Codex **belum mengirim** `api-key` — server menolak request dan agent tidak melihat tool.

Tambahkan header HTTP (disarankan):

```toml
[mcp_servers.meta_ads_mcp]
url = "https://meta-ads.clowy.biz.id/mcp"
env_http_headers = { "api-key" = "CLOVY_MCP_API_KEY" }
```

Contoh lengkap: [`examples/codex.config.toml`](../examples/codex.config.toml).

**Alternatif** — server menerima `Authorization: Bearer clowy-mcp-server-…`:

```toml
[mcp_servers.meta_ads_mcp]
url = "https://meta-ads.clowy.biz.id/mcp"
bearer_token_env_var = "CLOVY_MCP_API_KEY"
```

Nilai env harus **full key** (`clowy-mcp-server-…`), bukan token GitHub.

## 4. Hapus entri lama tanpa header (jika perlu)

```powershell
codex mcp remove meta_ads_mcp
```

Lalu edit `config.toml` seperti di atas, atau:

```powershell
codex mcp add meta_ads_mcp --url "https://meta-ads.clowy.biz.id/mcp"
# Setelah add, pastikan config.toml memuat env_http_headers (CLI bisa tidak menulis header — edit manual lebih aman)
```

## 5. Verifikasi

```powershell
codex mcp list
```

Setelah `env_http_headers` benar, kolom auth bisa tetap **Unsupported** (itu normal untuk API key custom, bukan OAuth).

Uji server:

```powershell
$key = $env:CLOVY_MCP_API_KEY
$body = '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}'
Invoke-WebRequest -Uri "https://meta-ads.clowy.biz.id/mcp" -Method POST `
  -Headers @{ "Content-Type"="application/json"; "api-key"=$key } `
  -Body $body -UseBasicParsing | Select-Object StatusCode
```

Status **200** = siap dipakai Codex.

## Catatan

- Jangan commit `config.toml` dengan key di `http_headers` statis — pakai `env_http_headers`.
- `bearer_token_env_var` hanya cocok jika nilai env adalah key Clovy penuh (`clowy-mcp-server-…`).

[faq.md](faq.md)
