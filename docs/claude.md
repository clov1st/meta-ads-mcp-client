# Claude — Meta Ads MCP (Clovy)

Dapatkan API key dari [dashboard](https://meta-ads.clowy.biz.id/app/) terlebih dahulu.

## Claude Code CLI

```bash
export CLOVY_MCP_API_KEY="clowy-mcp-server-..."

claude mcp add meta-ads-clowy \
  --transport http \
  --url "https://meta-ads.clowy.biz.id/mcp" \
  --header "api-key: ${CLOVY_MCP_API_KEY}"
```

Atau [`examples/claude-code.sh`](../examples/claude-code.sh).

## Claude Desktop

Gunakan `mcp-remote` atau config setara dengan header `api-key`:

```bash
npx -y mcp-remote@latest \
  https://meta-ads.clowy.biz.id/mcp \
  --header "api-key: clowy-mcp-server-..."
```

## Verifikasi

`claude mcp list` — server harus terdaftar.

[faq.md](faq.md)
