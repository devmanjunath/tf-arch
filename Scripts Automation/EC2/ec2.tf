resource "null_resource" "ec2-scripts" {
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = "13.126.38.104"
    #host        = data.terraform_remote_state.ec2.outputs.public_ip
  }

  provisioner "file" {
    source      = "default"
    destination = "/tmp/default"
  }

  provisioner "file" {
    source      = "kestrel-core.service"
    destination = "/tmp/kestrel-core.service"
  }

  #Step 1: Install the SDK & Runtime
  provisioner "remote-exec" {
    inline = [
      "wget https://packages.microsoft.com/config/ubuntu/20.10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb",
      "sudo dpkg -i packages-microsoft-prod.deb",
      "sudo apt-get update",
      "sudo apt-get install -y apt-transport-https",
      "sudo apt-get install -y dotnet-sdk-5.0"
    ]
  }

  # # Step 2: Install & Configure Nginx
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get install -y nginx",
      "sudo service nginx start",
      "sudo cp /tmp/default /etc/nginx/sites-available/default",
      "sudo nginx -t",
      "sudo nginx -s reload"
    ]
  }

  #Step 2: Install & Configure Nginx
  provisioner "remote-exec" {

    inline = [
      "sudo mkdir -p /var/www/publish/",
      "cd /tmp && sudo rm -rf coremusic && git clone https://github.com/devmanjunath/coremusic.git",
      "export ConnectionStrings__DefaultConnection=Server='${data.terraform_remote_state.rds.outputs.rds_endpoint};Database=Cloudbreathe;User ID=${data.terraform_remote_state.rds.outputs.rds_username};Password=${data.terraform_remote_state.rds.outputs.rds_password};MultipleActiveResultSets=true'",
      "cd coremusic && sudo dotnet publish -o /var/www/publish/",
      "sed -i 's/{ENV_CON}/$ConnectionStrings_DefaultConnection/g' /tmp/kestrel-core.service",
      "sudo cp /tmp/kestrel-core.service /etc/systemd/system/kestrel-core.service",
      "sudo systemctl enable kestrel-core.service",
      "sudo systemctl start kestrel-core.service"
    ]
  }
}
