# FAQ — Meta Ads MCP Client (v0.3)

## Apakah saya masih perlu token Facebook di Cursor?

**Tidak** untuk production Clovy. Token Facebook disimpan di server setelah OAuth di dashboard. Client hanya mengirim **API key** (`clowy-mcp-server-…`).

## Di mana membuat API key?

[https://meta-ads.clowy.biz.id/app/](https://meta-ads.clowy.biz.id/app/) → Login → Integrations (Facebook) → API Keys.

## Kenapa menu API Keys terkunci?

Anda belum menghubungkan akun Facebook. Selesaikan **Integrations → Connect Facebook** dulu.

## Bisa beberapa akun Facebook?

Ya. Setiap koneksi bisa punya **maksimal satu** API key. Buat key terpisah per koneksi jika perlu.

## Format config Cursor

```json
"url": "https://meta-ads.clowy.biz.id/mcp",
"api-key": "clowy-mcp-server-..."
```

Jika tidak jalan, gunakan `headers.api-key` (lihat [cursor.md](cursor.md)).

## Apakah `x-mcp-api-key` atau `x-fb-accestoken` masih dipakai?

v0.3 production memakai **`api-key`** (atau `x-api-key`). `x-fb-accestoken` hanya untuk debugging/self-hosted lama.

## Token Facebook kedaluwarsa?

Long-lived token Meta (~60 hari). Jika tools gagal, buka dashboard → reconnect Facebook → buat key baru jika perlu.

## Health check

```bash
curl -s https://meta-ads.clowy.biz.id/healthz
curl -s https://meta-ads.clowy.biz.id/readyz
```

`readyz` tidak memvalidasi API key Anda — hanya server Meta app.
