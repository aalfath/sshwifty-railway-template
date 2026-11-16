[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/sshwifty?utm_medium=integration&utm_source=button&utm_campaign=sshwifty)

# Sshwifty on Railway

This repo packages [Sshwifty](https://github.com/nirui/sshwifty), an open-source web SSH and Telnet client, as a Railway template. Open your Railway URL, enter the access password, and connect to any SSH or Telnet server from the browser.

## What it deploys

| Service | Source | Notes |
|---|---|---|
| `Sshwifty` | this repo (`Dockerfile`) | `niruix/sshwifty:0.4.12-beta-release`, pinned by digest, public HTTPS domain on port 8182, health check on `/` |

Sshwifty keeps no data of its own. Everything it needs is in its environment variables, so it needs no volume or database.

The wrapper (`start.sh`) does two things only:

- makes Sshwifty listen on Railway's `PORT`;
- refuses to start when `SSHWIFTY_SHAREDKEY` is empty, so the gateway is never public without a password.

## Variables

| Variable | Default | What it is |
|---|---|---|
| `SSHWIFTY_SHAREDKEY` | `${{secret(32)}}` | Password for the web interface. Railway generates it; read it in the service's **Variables** tab |
| `PORT` | `8182` | Port Sshwifty listens on. The public domain points at it |

Optional settings (add them to the service when you need them; see the [upstream docs](https://github.com/nirui/sshwifty#environment-variables)):

- `SSHWIFTY_PRESETS`: a JSON list of saved remotes shown under "Known remotes". It is sent to the browser without protection, so never put secrets in it.
- `SSHWIFTY_ONLYALLOWPRESETREMOTES`: set to `true` with presets to block connections to any other host.
- `SSHWIFTY_SOCKS5`, `SSHWIFTY_SOCKS5_USER`, `SSHWIFTY_SOCKS5_PASSWORD`: connect to remotes through a SOCKS5 proxy.
- `SSHWIFTY_DIALTIMEOUT`: seconds to wait when dialling a remote (default 10).
- `SSHWIFTY_SERVERMESSAGE`: a short message on the home page.

## Security

Anyone who knows the access password can open SSH and Telnet connections from your Railway service, including to services on your project's private network. Keep the password secret, change it if it leaks (edit `SSHWIFTY_SHAREDKEY` and redeploy), and consider `SSHWIFTY_PRESETS` plus `SSHWIFTY_ONLYALLOWPRESETREMOTES=true` to limit where it can connect.

## Updates

The `Dockerfile` pins the upstream image by version and digest. When a new Sshwifty release comes out, this repo bumps the pin and adds a `CHANGELOG.md` entry. Railway then shows an "update available" notice to everyone who deployed the template, and you choose when to apply it. Read the changelog first.

## Local test

```sh
SSHWIFTY_SHAREDKEY=change-me docker compose up --build
```

Then open the port Docker assigned (`docker compose port sshwifty 8182`) and enter the password.

## License

Sshwifty is licensed under AGPL-3.0 by its authors. This repo contains only the Railway wrapper.
