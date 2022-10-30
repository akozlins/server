#

```
headscale namespaces create myns
headscale --namespace myns preauthkeys create --reusable --expiration 24h
tailscale up --login-server https://example.com --authkey <AUTH_KEY>
```

create API key:
`headscale apikeys create --expiration 90d`
