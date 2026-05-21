# Codex — Meta Ads MCP (Clovy)

## 1. API key dari dashboard

[https://meta-ads.clowy.biz.id/app/](https://meta-ads.clowy.biz.id/app/) → API Keys → salin `clowy-mcp-server-…`

## 2. Environment

```powershell
[System.Environment]::SetEnvironmentVariable("CLOVY_MCP_API_KEY", "clowy-mcp-server-...", "User")
```

## 3. Config

Codex biasanya membutuhkan header eksplisit (lihat dokumentasi versi Anda). Contoh konsep:

```toml
[mcp_servers.meta-ads-clowy]
url = "https://meta-ads.clowy.biz.id/mcp"
# Tambahkan header api-key sesuai dukungan Codex di versi Anda
```

Jika CLI mendukung `--header`:

```bash
codex mcp add meta-ads-clowy \
  --url "https://meta-ads.clowy.biz.id/mcp" \
  --header "api-key: clowy-mcp-server-..."
```

Lihat [`examples/codex.config.toml`](../examples/codex.config.toml).

## Catatan

Jangan pakai `bearer_token_env_var` untuk API key Clovy kecuali dokumentasi Codex memetakan Bearer ke custom header — gunakan header `api-key` langsung.

[faq.md](faq.md)
