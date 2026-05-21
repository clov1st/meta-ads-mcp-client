# Memulai — Meta Ads MCP (Client)

## Langkah 1 — Siapkan kredensial

1. **Facebook User Access Token**  
   Buat di [Meta for Developers](https://developers.facebook.com/) → Tools → Access Token Tool, atau via flow OAuth aplikasi Anda.  
   Sertakan scope yang sesuai (mis. `ads_read`, `ads_management`).

2. **MCP API Key**  
   Minta ke administrator layanan Clovy (`x-mcp-api-key`).

## Langkah 2 — Pilih client

| Client | Mulai di |
|--------|----------|
| Cursor | [cursor.md](cursor.md) |
| Claude Code / Desktop | [claude.md](claude.md) |
| Codex | [codex.md](codex.md) |

## Langkah 3 — Config MCP

**URL selalu:**

```text
https://meta-ads.clowy.biz.id/mcp
```

**Header minimal:**

```http
x-fb-accestoken: <token facebook>
x-mcp-api-key: <key dari admin>
```

## Langkah 4 — Restart client & uji

1. Restart aplikasi (Cursor / Claude / Codex).
2. Pastikan server MCP **enabled** di pengaturan MCP.
3. Panggil tool: `meta_ads_get_account_info`.

## Langkah 5 — Jika gagal

1. `curl -s https://meta-ads.clowy.biz.id/healthz` — harus `ok`.
2. Buka MCP Logs di client — catat kode HTTP (401, 403, timeout).
3. Baca [faq.md](faq.md).

## Keamanan

- Jangan screenshot config yang memuat token.
- Rotasi token Facebook jika bocor.
- Gunakan `${env:FB_ACCESSTOKEN}` di Cursor jika memungkinkan.
