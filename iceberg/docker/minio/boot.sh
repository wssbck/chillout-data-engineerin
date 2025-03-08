minio server /opt/data --console-address ":9001"

sleep 5

mc alias set local http://localhost:9000 admin password
mc mb local/warehouse
