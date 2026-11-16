#!/bin/sh
# Railway wrapper for Sshwifty.
# - Listens on Railway's PORT (falls back to Sshwifty's default 8182).
# - Refuses to start without SSHWIFTY_SHAREDKEY, so the SSH/Telnet gateway is never public without a password.
set -e

export SSHWIFTY_LISTENPORT="${PORT:-${SSHWIFTY_LISTENPORT:-8182}}"
export SSHWIFTY_LISTENINTERFACE="${SSHWIFTY_LISTENINTERFACE:-0.0.0.0}"

if [ -z "${SSHWIFTY_SHAREDKEY}" ]; then
  echo "SSHWIFTY_SHAREDKEY is empty. Set it to the password for the web interface; refusing to start an open SSH/Telnet gateway." >&2
  exit 1
fi

echo "Starting Sshwifty on ${SSHWIFTY_LISTENINTERFACE}:${SSHWIFTY_LISTENPORT}"
exec /sshwifty.sh "$@"
