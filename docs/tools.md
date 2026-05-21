# Tools MCP (server v0.2.0)

Semua tools memvalidasi token Facebook Anda. Jika token dikonfigurasi di client header, **tidak perlu** mengisi `fb_accestoken` di setiap pemanggilan tool.

## Akun & aset

| Tool | Deskripsi |
|------|-----------|
| `meta_ads_get_account_info` | Info user/token & permission |
| `meta_ads_list_businesses` | Daftar Business Manager |
| `meta_ads_list_ad_accounts` | Daftar akun iklan |
| `meta_ads_list_pages` | Halaman Facebook |
| `meta_ads_list_instagram_accounts` | Akun Instagram terhubung |

## Struktur kampanye

| Tool | Deskripsi |
|------|-----------|
| `meta_ads_list_campaigns` | Daftar campaign |
| `meta_ads_list_ad_sets` | Daftar ad set |
| `meta_ads_list_ads` | Daftar iklan |
| `meta_ads_get_entity` | Detail satu entitas by ID |

## Insights

| Tool | Deskripsi |
|------|-----------|
| `meta_ads_get_insights` | Insights dengan field fleksibel + preset (`performance_7d`, dll.) |
| `meta_ads_get_insights_batch` | Hingga 10 target paralel |

## Buat & ubah

| Tool | Deskripsi |
|------|-----------|
| `meta_ads_create_campaign` | Buat campaign |
| `meta_ads_create_ad_set` | Buat ad set |
| `meta_ads_create_ad` | Buat iklan |
| `meta_ads_create_ad_creative` | Buat creative |
| `meta_ads_update_status` | Pause / aktifkan / archive |
| `meta_ads_upload_image` | Upload gambar dari URL |
| `meta_ads_upload_video` | Upload video dari URL |

## Prompts MCP (bukan tool)

| Prompt | Kegunaan |
|--------|----------|
| `weekly_performance_review` | Template review performa mingguan |
| `audit_paused_campaigns` | Template audit campaign pause |

## Resource MCP

| Resource | URI |
|----------|-----|
| Setup doc (statis) | `meta-ads://docs/setup` |
| Ringkasan akun (template) | `meta-ads://ad-account/{account_id}/summary` |

## Tips di Cursor / Claude

- Mulai dengan `meta_ads_get_account_info` dan `meta_ads_list_ad_accounts`.
- Untuk insights cepat, gunakan parameter `preset` di `meta_ads_get_insights`.
- Mengaktifkan status **ACTIVE** pada create/update mungkin memerlukan `confirm_active: true` (guard keamanan server).

## Scope Facebook yang umum

| Kebutuhan | Scope contoh |
|-----------|----------------|
| Baca data & insights | `ads_read` |
| Buat / ubah kampanye | `ads_management` |
| Halaman / IG | `pages_read_engagement`, `instagram_basic`, dll. |

Scope tepat bergantung operasi; error Meta akan menjelaskan permission yang kurang.
