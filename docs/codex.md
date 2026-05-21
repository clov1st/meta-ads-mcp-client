# OpenAI Codex — Meta Ads MCP

Endpoint: `https://meta-ads.clowy.biz.id/mcp`

Codex **tidak** mengizinkan token literal di file config. Gunakan **variabel lingkungan OS**.

## 1. Set environment

**Windows (PowerShell):**

```powershell
[System.Environment]::SetEnvironmentVariable("FB_ACCESSTOKEN", "EAAB...", "User")
[System.Environment]::SetEnvironmentVariable("MCP_API_KEY", "your-mcp-api-key", "User")
```

**macOS / Linux:**

```bash
export FB_ACCESSTOKEN="EAAB..."
export MCP_API_KEY="your-mcp-api-key"
# atau tambahkan ke ~/.bashrc / ~/.zshrc
```

Restart terminal / aplikasi Codex setelah set.

## 2. Config TOML

Tambahkan ke `~/.codex/config.toml` (lihat juga [`examples/codex.config.toml`](../examples/codex.config.toml)):

```toml
[mcp_servers.meta-ads-clowy]
url = "https://meta-ads.clowy.biz.id/mcp"
bearer_token_env_var = "FB_ACCESSTOKEN"
```

`bearer_token_env_var` mengirim token Facebook sebagai `Authorization: Bearer`.

## 3. MCP API key (`x-mcp-api-key`)

Server production Clovy memerlukan header `x-mcp-api-key`. Dukungan header tambahan di Codex bergantung versi:

- Jika versi Anda mendukung beberapa header di TOML, tambahkan sesuai dokumentasi Codex terbaru.
- Jika tidak: gunakan **Cursor** atau **Claude Code** yang mendukung dua header secara eksplisit, atau minta pola auth alternatif ke administrator.

## 4. CLI (opsional)

```bash
codex mcp add meta-ads-clowy \
  --url "https://meta-ads.clowy.biz.id/mcp" \
  --bearer-token-env-var FB_ACCESSTOKEN
```

Pastikan `MCP_API_KEY` ikut terkirim jika CLI mendukung `--header`.

## Verifikasi

```bash
curl -s https://meta-ads.clowy.biz.id/healthz
```

Di sesi Codex, panggil tool `meta_ads_get_account_info`.

## Troubleshooting

| Masalah | Catatan |
|---------|---------|
| 401 Unauthorized | `MCP_API_KEY` belum terkirim — cek dukungan header Codex |
| Missing token | `FB_ACCESSTOKEN` tidak ter-set di environment |
| Bearer vs `x-fb-accestoken` | Keduanya diterima server untuk token Facebook |

Lihat [faq.md](faq.md).
