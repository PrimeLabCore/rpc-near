# RPC-NEAR MAINNET

# ReadME for RPC mainnet node setup infrastructure as code
<h2>Requirements</h2>
 + Ansible
 + Packer
 + Terraform


- clone the repository
- cd into the packer/
- vi `aws-mainnet.pkr.hcl` and replace necessary values 
- run `packer build aws-mainnet.pkr.hcl` 
- copy ami-id from output `mainnet-manifest.json` and replace value in `variables.tf`
- run `terraform init`
- run `terraform plan` to view infrastructure
- run `terraform apply` to spin up instance with neard service running as RPC mainnet
- connect to the instance

# Run the neard service
- Run <sudo systemctl status neard.service> to view the running neard service
- Run <sudo systemctl stop neard.service>   to stop the neard service
- Run <sudo systemctl start neard.service>  to start the neard service

# NB
- The neard service config file can be found in /etc/systemd/system/neard.service. It starts the mainnet node by running <./target/release/neard --home ~/.near run> command which is found in bash script ./neard.sh.


