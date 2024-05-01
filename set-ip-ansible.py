import json

# Open the ips.json file
with open('ips.json', 'r') as json_file:
    data = json.load(json_file)

    # List to store all extracted IP addresses
    ip_addresses = []

    # Iterate over all keys in the JSON data
    for key in data:
        if key.startswith('instance-ip'):
            # Extract the IP address value
            ip_address = data[key]['value']
            ip_addresses.append(ip_address)

    print("Extracted IP addresses:", ip_addresses)  # Debug output

    # Write all IP addresses to the inventory file
    with open('inventory', 'w') as inventory_file:
        for ip_address in ip_addresses:
            inventory_file.write(ip_address + '\n')