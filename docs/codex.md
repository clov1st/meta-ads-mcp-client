# Codex — Meta Ads MCP (Clovy)

## 1. API key dari dashboard

[https://meta-ads.clowy.biz.id/app/](https://meta-ads.clowy.biz.id/app/) → API Keys → salin `clowy-mcp-server-…`

Self-hosted: ganti host, path tetap `/mcp`.

## 2. Setup (Windows — disarankan)

### Langkah A — variabel lingkungan User

Simpan key di **`META_ADS_MCP_TOKEN`** (satu baris, tanpa enter di tengah string):

```powershell
[System.Environment]::SetEnvironmentVariable("META_ADS_MCP_TOKEN", "clowy-mcp-server-PASTE_FROM_DASHBOARD", "User")
```

Tutup semua terminal / Codex, buka **PowerShell baru**, lalu cek:

```powershell
$env:META_ADS_MCP_TOKEN
```

Harus diawali `clowy-mcp-server-` tanpa spasi/newline di akhir.

### Langkah B — daftarkan MCP di Codex CLI

Jika server sudah ada, hapus dulu:

```powershell
codex mcp remove meta_ads_mcp
```

Tambahkan dengan Bearer (Codex mengirim `Authorization: Bearer …` — server Clovy menerima ini):

```powershell
codex mcp add meta_ads_mcp `
  --url "https://meta-ads.clowy.biz.id/mcp" `
  --bearer-token-env-var META_ADS_MCP_TOKEN
```

**Host sendiri:** ganti URL menjadi `https://YOUR-HOST/mcp`.

### Langkah C — verifikasi `codex mcp list`

Contoh output yang benar:

```text
Name          Url                                 Bearer Token Env Var  Status   Auth
meta_ads_mcp  https://meta-ads.clowy.biz.id/mcp   META_ADS_MCP_TOKEN    enabled  Bearer token
```

| Kolom | Arti |
|--------|------|
| **Bearer Token Env Var** = `META_ADS_MCP_TOKEN` | Codex membaca key dari env |
| **Auth** = `Bearer token` | Autentikasi terkonfigurasi (bukan OAuth Meta) |

Jika **Bearer Token Env Var** masih `-` dan **Auth** = `Unsupported`, ulangi langkah B atau edit `~/.codex/config.toml` manual (lihat bawah).

## 3. Isi `~/.codex/config.toml` (setara CLI di atas)

Setelah `codex mcp add`, bagian ini harus ada:

```toml
[mcp_servers.meta_ads_mcp]
url = "https://meta-ads.clowy.biz.id/mcp"
bearer_token_env_var = "META_ADS_MCP_TOKEN"
```

Contoh: [`examples/codex.config.toml`](../examples/codex.config.toml).

Nilai env harus **seluruh** API key Clovy (`clowy-mcp-server-…`), bukan PAT GitHub.

## 4. Uji koneksi (PowerShell)

```powershell
$key = $env:META_ADS_MCP_TOKEN.Trim()
$body = '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}'

$r = Invoke-WebRequest -Uri "https://meta-ads.clowy.biz.id/mcp" -Method POST `
  -Headers @{
    "Content-Type"  = "application/json"
    "Accept"        = "application/json, text/event-stream"
    "Authorization" = "Bearer $key"
  } `
  -Body $body -UseBasicParsing

$r.StatusCode
$r.Content.Substring(0, [Math]::Min(300, $r.Content.Length))
```

| StatusCode | Arti |
|------------|------|
| **200** + JSON `tools` | Server + key OK |
| **401** | Key salah / env kosong / newline di env |
| Error `Not Acceptable` | Tambahkan header `Accept` seperti di atas |

## 5. Pakai di sesi Codex

1. Buka sesi Codex **setelah** env terisi.
2. TUI: `/mcp` — pastikan `meta_ads_mcp` enabled.
3. Minta eksplisit: *“Pakai MCP meta_ads_mcp, panggil `meta_ads_get_account_info`.”*

## Alternatif: header `api-key` (tanpa Bearer di `mcp list`)

Jika Anda lebih suka header custom:

```toml
[mcp_servers.meta_ads_mcp]
url = "https://meta-ads.clowy.biz.id/mcp"
env_http_headers = { "api-key" = "META_ADS_MCP_TOKEN" }
```

`codex mcp list` bisa tetap menampilkan **Unsupported** — itu normal untuk mode ini. Uji dengan header `api-key` + `Accept` jika perlu.

## Keamanan

- Jangan commit key ke git atau paste di chat.
- Jangan simpan key di `http_headers` statis di `config.toml` — pakai env + `bearer_token_env_var`.
- Revoke key di dashboard jika bocor, buat key baru, update `META_ADS_MCP_TOKEN`.

[faq.md](faq.md)
