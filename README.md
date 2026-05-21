# Meta Ads MCP — Panduan Client

Dokumentasi untuk menghubungkan **Cursor**, **Claude**, **Codex**, dan client MCP lain ke server Meta Ads MCP yang di-host di Clovy.

> Repo ini hanya berisi **panduan konfigurasi client**. Kode server tidak dipublikasikan di sini.

## Endpoint production

| Item | Nilai |
|------|--------|
| **MCP URL** | `https://meta-ads.clowy.biz.id/mcp` |
| **Health** | `https://meta-ads.clowy.biz.id/healthz` |
| **Readiness** | `https://meta-ads.clowy.biz.id/readyz` |
| **Versi server** | `0.2.0` |

## Yang Anda butuhkan

1. **Facebook User Access Token** dengan scope Marketing API yang sesuai (mis. `ads_read`, `ads_management` — tergantung tool yang dipakai).
2. **MCP API Key** (`x-mcp-api-key`) — minta ke administrator layanan jika belum punya.
3. Client MCP yang mendukung **HTTP transport** (disarankan) atau stdio (self-hosted lokal saja).

## Model keamanan

- Token Facebook disimpan di **config client** atau **variabel lingkungan OS**, bukan di server.
- Server memvalidasi token via Meta Graph API menggunakan aplikasi Meta milik operator layanan.
- Jangan commit file config yang berisi token nyata ke git.

## Quick start — Cursor

1. Salin [`examples/cursor.mcp.json`](examples/cursor.mcp.json) ke:
   - Windows: `%USERPROFILE%\.cursor\mcp.json`
   - macOS/Linux: `~/.cursor/mcp.json`
2. Ganti placeholder `REPLACE_...` dengan token dan API key Anda.
3. Restart Cursor → **Settings → MCP** → aktifkan **Meta Ads MCP**.
4. Di chat Agent, coba tool `meta_ads_get_account_info` (tanpa mengisi `fb_accestoken` di argumen tool).

Lihat [docs/cursor.md](docs/cursor.md) untuk detail dan troubleshooting.

## Panduan per client

Mulai di [docs/getting-started.md](docs/getting-started.md).

| Client | Dokumen |
|--------|---------|
| Cursor | [docs/cursor.md](docs/cursor.md) |
| Claude (Code / Desktop) | [docs/claude.md](docs/claude.md) |
| OpenAI Codex | [docs/codex.md](docs/codex.md) |
| FAQ & error umum | [docs/faq.md](docs/faq.md) |
| Daftar tools MCP | [docs/tools.md](docs/tools.md) |

## Header HTTP wajib (production)

```http
x-fb-accestoken: <Facebook user access token>
x-mcp-api-key: <MCP API key dari administrator>
```

Alias yang juga diterima untuk token Facebook:

- `Authorization: Bearer <token>`
- `x-fb-access-token`

## Verifikasi koneksi

Dari terminal (tanpa menampilkan token di log publik):

```bash
curl -s https://meta-ads.clowy.biz.id/healthz
curl -s https://meta-ads.clowy.biz.id/readyz
```

`readyz` dengan `"status":"ready"` berarti server dan kredensial Meta aplikasi operator OK. Koneksi MCP client tetap membutuhkan token user + API key Anda.

## Contoh config

- [examples/cursor.mcp.json](examples/cursor.mcp.json) — literal placeholder
- [examples/cursor.mcp.json.env](examples/cursor.mcp.json.env) — pakai `${env:...}`
- [examples/codex.config.toml](examples/codex.config.toml)
- [examples/claude-code.sh](examples/claude-code.sh)

## Dukungan

- Masalah koneksi MCP: lihat [docs/faq.md](docs/faq.md)
- Permintaan API key atau akses: hubungi administrator layanan Meta Ads MCP Clovy

## Publish repo ini ke GitHub (admin)

Di mesin lokal, dari folder `meta-ads-mcp-client`:

```bash
cd "E:\Project 2026\meta-ads-mcp-client"
git init
git add .
git commit -m "docs: panduan client Meta Ads MCP production"
```

Buat repo **public** kosong di GitHub (mis. `meta-ads-mcp-client`), lalu:

```bash
git remote add origin https://github.com/clov1st/meta-ads-mcp-client.git
git branch -M main
git push -u origin main
```

Ganti URL remote sesuai nama repo yang Anda pilih.

## Lisensi

Dokumentasi ini dilisensikan [MIT](LICENSE).
