# Tools MCP (server v0.3.3+)

Server v0.3.3+ menyertakan **deskripsi lengkap per tool** (kapan dipakai, edge Graph API, best practice Meta) dan **`.describe()` pada setiap parameter** — agar AI agent memakai MCP secara maksimal.

Token Facebook di-resolve dari **API key Clovy** di server; biasanya **tidak perlu** `fb_accestoken` di setiap call.

## Resource MCP untuk agent (penting)

| Resource | URI | Isi |
|----------|-----|-----|
| Setup singkat | `meta-ads://docs/setup` | Auth Clovy, workflow ringkas |
| **Playbook lengkap** | `meta-ads://docs/agent-playbook` | Semua 18 tool + parameter + error umum |
| Ringkasan akun | `meta-ads://ad-account/{account_id}/summary` | Metadata akun JSON |

**Saran:** minta agent membaca `meta-ads://docs/agent-playbook` di awal sesi analisis/iklan.

## Workflow agent (urutan disarankan)

```text
1. meta_ads_get_account_info
2. meta_ads_list_ad_accounts
3. meta_ads_list_* / meta_ads_get_insights (preset: performance_7d)
4. meta_ads_upload_image | meta_ads_upload_video (jika perlu creative)
5. meta_ads_create_campaign → create_adset → create_ad_creative → create_ad
6. meta_ads_update_status (ACTIVE hanya dengan confirm_active: true)
```

## Prompts MCP

| Prompt | Kegunaan |
|--------|----------|
| `weekly_performance_review` | Review performa mingguan |
| `audit_paused_campaigns` | Audit struktur pause |
| `create_full_ad_flow` | Alur buat campaign → ad (PAUSED) |
| `upload_and_creative_flow` | Upload gambar + creative link ad |

## Akun & aset

| Tool | Kapan dipakai |
|------|----------------|
| `meta_ads_get_account_info` | **Pertama** — cek scope & token |
| `meta_ads_list_businesses` | Konteks Business Manager |
| `meta_ads_list_ad_accounts` | **Wajib** untuk dapat `ad_account_id` |
| `meta_ads_list_pages` | Sebelum creative (butuh `page_id`) |
| `meta_ads_list_instagram_accounts` | IG terhubung ke Page |

## Struktur & detail

| Tool | Kapan dipakai |
|------|----------------|
| `meta_ads_list_campaigns` | Audit / cari `campaign_id` |
| `meta_ads_list_adsets` | Budget, targeting, `adset_id` |
| `meta_ads_list_ads` | Daftar iklan + creative ref |
| `meta_ads_get_entity` | Detail satu objek by id |

## Insights

| Tool | Kapan dipakai |
|------|----------------|
| `meta_ads_get_insights` | Laporan; mulai dengan **preset** `performance_7d` / `performance_30d` / `delivery_today` |
| `meta_ads_get_insights_batch` | Bandingkan hingga 10 campaign/adset/ad sekaligus |

Preset `performance_7d`: spend, impressions, clicks, ctr, cpc (7 hari).

## Media & creative

| Tool | Kapan dipakai |
|------|----------------|
| `meta_ads_upload_image` | URL gambar publik JPEG/PNG → dapat **hash** untuk creative |
| `meta_ads_upload_video` | URL video → **video id** (+ poll processing) |
| `meta_ads_create_ad_creative` | Setelah upload + `page_id`; pakai `simplified` atau `object_story_spec` |
| `meta_ads_create_campaign` | Awal rantai create (default **PAUSED**) |
| `meta_ads_create_ad_set` | Setelah campaign; budget & targeting |
| `meta_ads_create_ad` | Hubungkan adset + `creative_id` |
| `meta_ads_update_status` | Pause / aktifkan / archive |

## Tips Cursor / Codex

- Config: [cursor.md](cursor.md) / [codex.md](codex.md)
- Minta eksplisit: *"Baca resource meta-ads://docs/agent-playbook lalu …"*
- Insights: gunakan `preset` sebelum custom `fields`
- **ACTIVE** hanya dengan `confirm_active: true`

## Scope Facebook

| Kebutuhan | Scope |
|-----------|--------|
| Baca | `ads_read` |
| Tulis / upload / create | `ads_management` |
| Page creative | `pages_read_engagement` (disarankan) |

## Error umum

| Gejala | Solusi |
|--------|--------|
| `(#3) Application does not have the capability` | Marketing API di Meta App + reconnect dashboard |
| 401 / scope | Key atau integrasi Facebook — buat key baru |
| Upload gambar gagal | URL harus file langsung; server v0.3.2+ pakai `bytes` |

Deploy server **v0.3.3** untuk dokumentasi tool terbaru di MCP.
