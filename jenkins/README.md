#

## plugins

- 'Reverse Proxy Auth' with Authelia
    - 'Manage Jenkins' -> 'Configure Global Security' -> `HTTP Header by reverse proxy`
    - 'Header User Name' -> `Remote-Name`
    - 'Header Groups Name' -> `Remote-Groups`
    - 'Header Groups Delimiter Name' -> `,`
