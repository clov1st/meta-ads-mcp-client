# Claude — Meta Ads MCP

Endpoint production: `https://meta-ads.clowy.biz.id/mcp`

## Claude Code (CLI)

Gunakan script contoh atau jalankan manual:

```bash
export FB_ACCESSTOKEN="EAAB..."
export MCP_API_KEY="your-mcp-api-key"

claude mcp add meta-ads-clowy \
  --transport http \
  --url "https://meta-ads.clowy.biz.id/mcp" \
  --header "x-fb-accestoken: ${FB_ACCESSTOKEN}" \
  --header "x-mcp-api-key: ${MCP_API_KEY}"
```

Atau salin [`examples/claude-code.sh`](../examples/claude-code.sh), edit placeholder, lalu:

```bash
chmod +x examples/claude-code.sh
./examples/claude-code.sh
```

Verifikasi:

```bash
claude mcp list
```

## Claude Desktop

Desktop umumnya memakai **stdio** atau proxy HTTP. Untuk server hosted Clovy, gunakan **HTTP** via `mcp-remote` (jika tersedia di instalasi Anda):

```bash
npx -y mcp-remote@latest \
  https://meta-ads.clowy.biz.id/mcp \
  --header "x-fb-accestoken: EAAB..." \
  --header "x-mcp-api-key: your-mcp-api-key"
```

Tambahkan entri di config MCP Desktop sesuai dokumentasi versi Claude Desktop Anda, dengan command di atas.

> Versi UI Claude Desktop berubah; ikuti menu **Settings → Developer → MCP** untuk format terbaru.

## Header yang diperlukan

| Header | Isi |
|--------|-----|
| `x-fb-accestoken` | Facebook user access token |
| `x-mcp-api-key` | MCP API key dari administrator |

Alternatif token Facebook: `Authorization: Bearer <token>` atau `x-fb-access-token`.

## Stdio (hanya self-hosted / developer)

Mode stdio membutuhkan menjalankan binary server lokal + `META_APP_ID` / `META_APP_SECRET` di environment. **Tidak** dipakai untuk endpoint production `meta-ads.clowy.biz.id`. Pengguna production cukup HTTP seperti di [cursor.md](cursor.md).

## Troubleshooting

Lihat [faq.md](faq.md).
