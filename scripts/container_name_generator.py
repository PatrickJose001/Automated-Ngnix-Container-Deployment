import os
import random
import string

# Helper function to generate a random ID
def generate_random_id(length=8):
    return ''.join(random.choices(string.ascii_lowercase + string.digits, k=length))

# Determine the directory of the script
script_dir = os.path.dirname(os.path.abspath(__file__))

# File to store the counter
counter_file = os.path.join(script_dir, 'counter.txt')

# Define paths to Terraform directories/files
terraform_dir = os.path.join(script_dir, '../terraform')
outputs_file = os.path.join(terraform_dir, 'outputs.tf')

# Check if the counter file exists; if not, create it with an initial value of 0
if not os.path.exists(counter_file):
    with open(counter_file, 'w') as file:
        file.write('0')

# Read the current counter value
with open(counter_file, 'r') as file:
    counter = int(file.read().strip())

# Increment the counter
counter += 1

# Write the new counter value back to the file
with open(counter_file, 'w') as file:
    file.write(str(counter))

# Generate a unique name and random ID
unique_name = f"instance{counter}"
random_id = generate_random_id()

# Read the template file from the templates directory
with open(os.path.join(script_dir, '../templates/template.tf'), 'r') as file:
    template = file.read()

# Replace the placeholders with the unique name and random ID
config = template.replace('${unique_name}', unique_name).replace('${random_id}', random_id)

# Write the new configuration to a new file in the Terraform directory
new_config_file = os.path.join(terraform_dir, f'deployment_{unique_name}.tf')
with open(new_config_file, 'w') as file:
    file.write(config)

# REWRITE outputs.tf to include all existing and new resources
with open(outputs_file, 'w') as file:
    file.write("// Terraform outputs\n\n")
    for filename in os.listdir(terraform_dir):
        if filename.startswith("deployment_instance") and filename.endswith(".tf"):
            # Extract instance name from file name
            instance_name = filename.replace("deployment_", "").replace(".tf", "")
            file.write(f"""
output "{instance_name}_public_ip" {{
  value = azurerm_container_group.{instance_name}.ip_address
}}

output "{instance_name}_container_name" {{
  value = azurerm_container_group.{instance_name}.name
}}
""")
