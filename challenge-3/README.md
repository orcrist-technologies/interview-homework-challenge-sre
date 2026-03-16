# Challenge 3: Is it running?

## Objective

Containerize the Python HTTP server in `server.py` using Docker and verify it responds correctly to a `GET` request with the header `Challenge: orcrist.org`.

## Build and run

```bash
✗ docker build -t challenge-3:1.0.0 .
...
✗ docker run -p 8080:8080 challenge-3:1.0.0

INFO:root:Listening on 8080...
```

## Test

```bash
✗ curl -i -H "Challenge: orcrist.org" http://localhost:8080
HTTP/1.0 200 OK
Server: SimpleHTTP/0.6 Python/3.12.13
Date: Mon, 16 Mar 2026 08:25:01 GMT
Content-type: text/html

Everything works!%
```

Without the header, the server returns `404 Wrong header!`
