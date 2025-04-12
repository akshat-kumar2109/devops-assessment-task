# Ansible Configuration

This directory contains Ansible playbooks and roles for setting up monitoring and logging infrastructure.

## Directory Structure

```
ansible/
├── roles/
│   ├── common/          # Common configurations
│   ├── grafana/        # Grafana setup and configuration
│   ├── loki/          # Loki log aggregation
│   ├── node_exporter/ # Node Exporter for system metrics
│   ├── prometheus/    # Prometheus metrics collection
│   └── promtail/     # Promtail log shipping
├── group_vars/        # Global variables
├── site.yml          # Main playbook
├── install-tools.yml # Tools installation playbook
├── inventory.ini.template  # Template for inventory
├── ansible.cfg      # Ansible configuration
└── README.md        # This documentation
```

## Prerequisites

1. **Install Ansible**
   ```bash
   # For Ubuntu/Debian
   sudo apt update
   sudo apt install ansible

   # For macOS
   brew install ansible
   ```

2. **Install Required Collections**
   ```bash
   ansible-galaxy collection install community.docker
   ```

## Configuration

### 1. Set Up Inventory File

1. Copy the template:
   ```bash
   cp inventory.ini.template inventory.ini
   ```

2. Update the inventory with your server IPs:
   ```ini
   # Monitoring server
   [monitoring]
   monitor.example.com ansible_host="54.162.249.25" ansible_user=ubuntu  # Replace with actual monitoring server IP

   # Nodes servers
   [nodes]
   aws-node ansible_host="54.224.81.165" ansible_user=ubuntu     # Replace with actual AWS EC2 instance IP
   ibm-node ansible_host="150.239.109.201" ansible_user=ubuntu     # Replace with actual IBM Cloud instance IP

   [all_nodes:children]
   monitoring
   nodes
   ```

3. Update ansible/roles/grafana/files/ec2-instance-metrics-dashboard.json with EC2 instance IP

4. Update ansible/roles/grafana/files/ibm-instance-metrics-dashboard.json with IBM instance IP

5. Update the monitoring server IP in `group_vars/all.yml`:
   ```yaml
   monitor_host: "YOUR_MONITORING_SERVER_IP"
   ```

### 2. Security Notes

- Never commit `inventory.ini` with actual IPs
- Keep the inventory file in `.gitignore`
- Use the template file for version control
- Protect SSH private keys and sensitive configurations

## Monitoring Components

- **Grafana**: Visualization (Port 3000)
- **Prometheus**: Metrics collection (Port 9090)
- **Loki**: Log aggregation (Port 3100)
- **Node Exporter**: System metrics (Port 9100)
- **Promtail**: Log shipping (Port 9080)

## Default Credentials

- **Grafana**:
  - Username: admin
  - Password: admin123 (change this in production)

## Running the Playbook
   ```bash
   ansible-playbook -i inventory.ini site.yml install-tools.yml
   ```

## Troubleshooting

1. **Check Container Status**
   ```bash
   docker ps
   ```

2. **View Container Logs**
   ```bash
   docker logs grafana
   docker logs prometheus
   docker logs loki
   docker logs promtail
   ```

3. **Verify Ports**
   ```bash
   netstat -tulpn | grep -E '3000|9090|3100|9100|9080'
   ```

4. **Verify Connectivity**
   ```bash
   # Test each component
   curl http://YOUR_MONITOR_IP:9090/targets  # Prometheus
   curl http://YOUR_MONITOR_IP:3100/ready    # Loki
   curl http://YOUR_AWS_IP:9100/metrics      # AWS Node Exporter
   curl http://YOUR_IBM_IP:9100/metrics      # IBM Node Exporter
   ```

## Security Notes

- All components are running in Docker containers
- Default passwords should be changed in production
- Firewall rules are managed by AWS/IBM security groups
- SSH access is restricted to the deployer key
- All IPs should be restricted to your organization's IP range in production
- Never commit files containing actual IPs or credentials 