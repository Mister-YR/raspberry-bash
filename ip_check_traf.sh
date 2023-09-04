#!/bin/bash
# Extract RX and TX values via IP
rx_bytes=$(ip -s link show eth0 | awk '{print $1 }' | awk 'NR==4')
tx_bytes=$(ip -s link show eth0 | awk '{print $1 }' | awk 'NR==6')

# Print traffic size in bytes
echo "RX Traffic on eth0: $rx_bytes bytes"
echo "TX Traffic on eth0: $tx_bytes bytes"