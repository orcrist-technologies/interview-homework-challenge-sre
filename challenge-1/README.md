# Challenge 1: Log Analysis with awk

## Objective

Parse `sample.log` (3360 lines) to extract specific metrics using `awk`.

## Solution

A single bash script `solution.sh` answers all five queries against the log file.

### Log format

```
<timestamp> <user> <ip> <method> <status> <method> <path>
```

### 1. Count all lines with `500` HTTP code

```bash
awk '{
    if ($5 == "500")
        count++
}
END {
    print "Number of 500 errors: " count
}' sample.log
```

Checks field `$5` (status code) for exact match on `500`.

### 2. Count `GET` requests from `yoko` to `/rrhh` with `200`

```bash
awk '{
    if ($2 == "yoko" && $6 == "\"GET" && $7 == "/rrhh\"" && $5 == "200")
        count++
}
END {
    print "Number of requests by yoko with 200 status for /rrhh: " count
}' sample.log
```

Matches all four conditions simultaneously: user, method, path, and status code.

### 3. Count requests to `/`

```bash
awk '{
    if($7=="/\"")
        count++
} END {
    print "Number of requests by anonymous user with 503 status: " count
}' sample.log
```

Matches `$7` (path field) against `/\"` to capture root path requests.

### 4. Count all lines without a `5XX` HTTP code

```bash
awk '{
    if($5 !~ /^5[0-9][0-9]$/)
        count++
} END {
    print "Number of requests that did not result in a 5XX status code: " count
}' sample.log
```

Uses a regex negation `!~` to exclude any status code starting with `5`.

### 5. Replace `503` with `500` then count all `500` errors

```bash
awk '{
    if($5=="503") $5="500"
} $5=="500" {count++}
END {
    print "Number of requests that resulted in a 500 status code (including 503 as 500): " count
}' sample.log
```

Remaps `503` to `500` in-memory before counting — does not modify the original file.

## Running the script

```bash
cd challenge-1
chmod +x solution.sh
./solution.sh
```
