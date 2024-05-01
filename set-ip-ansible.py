import json

# Open the ips.json file
with open('/home/ubuntu/ips.json', 'r') as json_file:
    data = json.load(json_file)

    # List to store all extracted IP addresses
    ip_addresses = []

    # Iterate over all keys in the JSON data
    for key in data:
        # Check if the key represents an IP address (e.g., instance_ipX where X is a number)
        if key.startswith('instance_ip'):
            # Extract the IP address value
            ip_address = data[key]['value']
            # Append the IP address to the list
            ip_addresses.append(ip_address)

    # Write all IP addresses to the inventory file
    with open('/home/ubuntu/project/project102', 'w') as inventory_file:
        for ip_address in ip_addresses:
            inventory_file.write(ip_address + '\n')
