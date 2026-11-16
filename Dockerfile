# Sshwifty, official image pinned by version and digest.
# Upstream: https://github.com/nirui/sshwifty
FROM niruix/sshwifty:0.4.12-beta-release@sha256:1a3ef74bd2e2dea175dee02763f918933f5f28954c3f7788883daede382c3f6b

# Small wrapper: listen on Railway's PORT and refuse to start without a web access password.
COPY start.sh /railway-start.sh

EXPOSE 8182
ENTRYPOINT ["/railway-start.sh"]
