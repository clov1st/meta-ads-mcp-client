# FAQ — Meta Ads MCP Client

## Apa itu layanan ini?

Server MCP yang mengekspos **18 tools** Meta Marketing API ke asisten AI (Cursor, Claude, dll.). Server di-host di `meta-ads.clowy.biz.id`; token Facebook milik **Anda** dikirim dari client.

## Di mana saya menyimpan token?

| Data | Lokasi |
|------|--------|
| Facebook access token | MCP client `headers` atau env `FB_ACCESSTOKEN` |
| MCP API key | Env `MCP_API_KEY` atau header `x-mcp-api-key` |
| Meta App Secret | **Hanya di server** — tidak untuk client |

Jangan commit token ke GitHub atau kirim di chat publik.

## Bagaimana cara mendapat MCP API key?

Minta ke **administrator layanan** Meta Ads MCP Clovy. Key ini membedakan akses ke endpoint publik `POST /mcp`.

## Mengapa error `Missing fb_accestoken`?

Client HTTP tidak mengirim field custom `fb_accestoken` di samping `url`. Gunakan:

```json
"headers": { "x-fb-accestoken": "..." }
```

## HTTP 401 Unauthorized

- Header `x-mcp-api-key` kosong atau salah.
- Atau `Authorization: Bearer` berisi MCP key, bukan token Facebook (untuk key server, gunakan header `x-mcp-api-key`).

## HTTP 403 Origin is not allowed

Server production memakai origin guard. Client desktop MCP biasanya **tidak** mengirim header `Origin`. Jika Anda memakai client berbasis browser, hubungi administrator untuk menambahkan origin ke allowlist.

## Error permission dari Meta

Token valid secara format tetapi scope kurang. Perbarui token di [Meta for Developers](https://developers.facebook.com/) / Business Manager dengan permission yang dibutuhkan (`ads_read`, `ads_management`, dll.).

## Apakah `readyz` berarti token saya OK?

`GET /readyz` hanya mengecek **kredensial aplikasi Meta di server** dan koneksi Graph API. Token **user** Anda divalidasi saat pertama kali memanggil tool MCP.

## Endpoint health

```bash
curl -s https://meta-ads.clowy.biz.id/healthz
curl -s https://meta-ads.clowy.biz.id/readyz
```

## Versi server

Dokumentasi ini untuk server **v0.2.0**. Jika administrator meng-upgrade server, daftar tools bisa berubah — lihat [tools.md](tools.md).

## Self-hosted sendiri?

Panduan ini untuk **hosted** `meta-ads.clowy.biz.id`. Self-hosted memerlukan repo server terpisah (privat) dan konfigurasi deploy sendiri — tidak dicakup di repo dokumentasi client ini.
