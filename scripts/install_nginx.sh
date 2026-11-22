#!/bin/bash
set -e
apt-get update -y
apt-get install -y nginx curl

TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 60")
INSTANCE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/instance-id)
AZ=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/placement/availability-zone)

cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head><title>Project 20 - Load Balancing</title></head>
<body style="font-family:Arial;text-align:center;margin-top:80px">
  <h1>Load balanced by an ALB</h1>
  <p>Instance ID: $INSTANCE_ID</p>
  <p>Availability Zone: $AZ</p>
  <p>Built by Hussain Hakeem</p>
</body>
</html>
EOF

echo "ok" > /var/www/html/health

systemctl enable nginx
systemctl restart nginx
