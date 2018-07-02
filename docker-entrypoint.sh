#!/bin/ash
set -e
mkdir -p /etc/pound
(
cd /etc/pound
cat > pound.cfg <<-EOF
User            "pound"
Group           "pound"
LogLevel        ${LOG_LEVEL}
Daemon          0
Grace           0

ListenHTTP
    Address ${SERVER_ADDRESS}
    Port    ${SERVER_PORT}
    RewriteLocation ${REWRITE_LOCATION}
    xHTTP   ${SERVER_XHTTP}

    # Login server
    Service
        HeadRequire "Host: ${LOGIN_FILTER}"
EOF

for i in $LOGIN_ADDRESS
do
cat >> pound.cfg <<-EOF
        BackEnd
            Address ${i}
            Port ${LOGIN_PORT}
        End
EOF
done

cat >> pound.cfg <<-EOF
    End

    # API server (back end)
    Service 
        URL "${BACKEND_FILTER}"

EOF

for i in $BACKEND_ADDRESS
do
cat >> pound.cfg <<-EOF
        BackEnd
            Address ${i}
            Port ${BACKEND_PORT}
        End
EOF
done

cat >> pound.cfg <<-EOF
    End

    # Catch-all (front end)
    Service
EOF

for i in $FRONTEND_ADDRESS
do
cat >> pound.cfg <<-EOF
        BackEnd
            Address ${i}
            Port ${FRONTEND_PORT}
        End
EOF
done

cat >> pound.cfg <<-EOF
    End
End
EOF
)

exec pound
