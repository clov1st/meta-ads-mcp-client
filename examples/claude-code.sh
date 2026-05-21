#!/usr/bin/env bash
# Claude Code CLI — tambah server HTTP Meta Ads MCP (production)
# Ganti nilai di bawah sebelum menjalankan.

export FB_ACCESSTOKEN="REPLACE_FB_TOKEN"
export MCP_API_KEY="REPLACE_MCP_API_KEY"

claude mcp add meta-ads-clowy \
  --transport http \
  --url "https://meta-ads.clowy.biz.id/mcp" \
  --header "x-fb-accestoken: ${FB_ACCESSTOKEN}" \
  --header "x-mcp-api-key: ${MCP_API_KEY}"
