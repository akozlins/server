{
  "subject" : "acct:user@example.com",
  "links" : [
    {
      "rel" : "http://openid.net/specs/connect/1.0/issuer",
      "href" : "https://auth.example.com"
    }
  ]
}
