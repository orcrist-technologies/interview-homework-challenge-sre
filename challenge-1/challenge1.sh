#!/bin/bash

LOG_FILE="./sample.log"

## Count the number of 500 errors in the log file
awk '{
    if ($5 == "500")
        count++
}
END {
    print "Number of 500 errors: " count
}
' "$LOG_FILE"

## Count the number of requests made by user "yoko" that resulted in a 200 status code and were for the "/rrhh" endpoint
awk '{
    if ($2 == "yoko" && $6 == "\"GET" && $7 == "/rrhh\"" && $5 == "200")
        count++
}
END {
    print "Number of requests by yoko with 200 status for /rrhh: " count
}' "$LOG_FILE"


## Count the number of requests that resulted in a 503 status code and were made by an anonymous user (i.e., where the username is "-")
awk '{
    if($7=="/\"")
        count++
} END {
    print "Number of requests by anonymous user with 503 status: " count
}' "$LOG_FILE"

## Count the number of requests that did not result in a 5XX status code

awk '{
    if($5 !~ /^5[0-9][0-9]$/)
        count++
} END {
    print "Number of requests that did not result in a 5XX status code: " count
}' "$LOG_FILE"


# count the number of requests that resulted in a 500 status code, but also count any requests that resulted in a 503 status code as if they were 500 errors
awk '{
    if($5=="503") $5="500"
} $5=="500" {count++}
    END {
        print "Number of requests that resulted in a 500 status code (including 503 as 500): " count
}' sample.log