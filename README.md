# rpc-near

# ReadME for RPC mainnet node setup
AWS_INSTANCE_ID:        i-0a43ade9a9b4637f8
AWS_REGION:             us-east-1
AWS_INSTANCE_NAME:      mainnet
AWS_INSTANCE_PUBLIC_IP: 44.203.125.87

# To Connect to the instance
>> On the AWS console click on the instance id 
>> Navigate to security and click on the security group id "sg-02071c31ad4e9bf20 (launch-wizard-4)"
>> Open port 22 and add your IP for SSH Connection
>> Proceed to terminal and run <ssh -i "testnet.pem" ubuntu@ec2-44-203-125-87.compute-1.amazonaws.com> to connect to the instance

# Run the neard service
>> Run <sudo systemctl status neard.service> to view the running neard service
>> Run <sudo systemctl stop neard.service>   to stop the neard service
>> Run <sudo systemctl start neard.service>  to start the neard service

# NB
>> The neard service config file can be found in /etc/systemd/system/neard.service. It starts the mainnet node by running <./target/release/neard --home ~/.near run> command which is found in bash script ./neard.sh.
>> The testnet.pem file is attached to this README
