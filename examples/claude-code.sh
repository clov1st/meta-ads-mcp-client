#!/usr/bin/env bash
export CLOVY_MCP_API_KEY="clowy-mcp-server-PASTE_FROM_DASHBOARD"

claude mcp add meta-ads-clowy \
  --transport http \
  --url "https://meta-ads.clowy.biz.id/mcp" \
  --header "api-key: ${CLOVY_MCP_API_KEY}"
