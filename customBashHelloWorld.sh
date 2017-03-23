
# Enable IP forwarding
sudo -i sysctl -w net.ipv4.ip_forward=1

# Enable eth1 and get an IP address
sudo ifconfig eth1 up
sudo dhclient

# Firewall config rules
# =====================
# Deny forwarded ICMP
sudo iptables -A FORWARD -p icmp -j DROP
# Allow forwarded traffic
sudo iptables -A FORWARD -i eth1 -j ACCEPT
sudo iptables -A FORWARD -o eth1 -j ACCEPT
# SNAT for traffic coming from Internet
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
