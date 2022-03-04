packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "mainnet" {
  ami_name      = "mainnet-ami-iac-2"
  instance_type = "c5.2xlarge"
  profile       = ""
  
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-20211129"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = [""]
  }
  ssh_username = "ubuntu"
  launch_block_device_mappings {
    device_name           = "/dev/sda1"
    volume_size           = 1000
    volume_type           = "gp2"
    delete_on_termination = true
    encrypted             = true
  }
  tags = {
    OS_Version    = "Ubuntu"
    Release       = "Lastest"
    Base_Ami_Name = "{{ .SourceAMIName }}"
    Name          = "mainnet"
    Env           = "mainnet"
  }

  aws_polling {
    delay_seconds = 180
    max_attempts  = 100
  }

}

build {
  name = "mainnet"
  sources = [
    "source.amazon-ebs.mainnet"
  ]

  provisioner "shell" {
  script       = "install-rust.sh"
  pause_before = "10s"
  timeout      = "10s"
  max_retries  = 3
  }

  provisioner "shell" {
  script       = "install-near.sh"
  pause_before = "10s"
  timeout      = "10s"
  max_retries  = 3
  }

  # provisioner "shell" {
  #   inline = [
  #     "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y",
  #     ". $HOME/.cargo/env",
  #     "rustup target add wasm32-unknown-unknown",
  #     "rustup --version",
  #     "echo export PATH='$HOME/.cargo/bin:$PATH' >> ~/.bashrc",
  #     "sudo apt-get update",
  #     "sudo apt-get install -y git binutils-dev libcurl4-openssl-dev zlib1g-dev libdw-dev libiberty-dev cmake gcc g++ python docker.io protobuf-compiler libssl-dev pkg-config clang llvm cargo awscli libclang-dev llvm-dev",
  #     "git clone  https://github.com/near/nearcore",
  #     "cd nearcore",
  #     "git fetch origin --tags",
  #     "git checkout tags/1.24.0 -b mynode",
  #     "make release",
  #     "./target/release/neard --home ~/.near init --chain-id mainnet --download-genesis --download-config",
  #     "rm ~/.near/config.json",
  #     "wget https://s3-us-west-1.amazonaws.com/build.nearprotocol.com/nearcore-deploy/mainnet/config.json -P ~/.near/",
  #     "aws s3 --no-sign-request cp s3://near-protocol-public/backups/mainnet/rpc/latest .",
  #     "LATEST=$(cat latest)",
  #     "aws s3 --no-sign-request cp --no-sign-request --recursive s3://near-protocol-public/backups/mainnet/rpc/$LATEST ~/.near/data",
  #   ]
  #   max_retries = 5
  # }

  provisioner "ansible" {
    playbook_file   = "../ansible/playbook.yml"
    extra_arguments = ["-vv"]
  }
  post-processors {
    post-processor "manifest" {
      output     = "mainnet-manifest.json"
      strip_path = true
    }
  }
  post-processors {
    post-processor "checksum" {
      checksum_types = ["md5", "sha512"] # Inspect artifact
    }
  }
}
