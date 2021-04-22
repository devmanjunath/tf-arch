resource "null_resource" "ec2-scripts" {
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = var.public-ip
  }

  provisioner "file" {
    source      = "Modules/Scripts Automation/EC2/default"
    destination = "/tmp/default"
  }

  provisioner "file" {
    source      = "Modules/Scripts Automation/EC2/wordpress.base.sql"
    destination = "/tmp/wordpress.base.sql"
  }

  provisioner "file" {
    source      = "Modules/Scripts Automation/EC2/mysql_installation.sh"
    destination = "/tmp/mysql_installation.sh"
  }

    provisioner "file" {
    source      = "Modules/Scripts Automation/EC2/wp_config_automation.sh"
    destination = "/tmp/wp_config_automation.sh"
  }
  #Step 1: Install NGINX
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt update -y",
      "sudo apt install -y nginx",
      "sudo apt install -y mysql-server",
      "sudo apt install php-fpm php-mysql php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip -y"
    ]
  }

  # # Step 2: Install & Configure Nginx
  provisioner "remote-exec" {
    inline = [
      "sudo ufw allow 'Nginx HTTP'",
      "sudo mkdir /var/www/html",
      "sudo chown -R $USER:$USER /var/www/html",
      "sudo cp /tmp/default /etc/nginx/sites-available/wordpress",
      "sudo ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/",
      "sudo unlink /etc/nginx/sites-enabled/default",
      "sudo nginx -t",
      "sudo nginx -s reload"
    ]
  }

  #Step 3: Install Mysql ( including base configurations )
  provisioner "remote-exec" {
    inline = [
      "sudo apt install mysql-server -y",
      "export MYSQL_ROOT_PASSWORD=${var.mysql_config.password}",
      "sudo chmod +x /tmp/mysql_installation.sh",
      "/tmp/mysql_installation.sh",
      "sudo mysql -u root -p${var.mysql_config.password} < /tmp/wordpress.base.sql"
    ]
  }

  #Step 4: Download Wordpress
  provisioner "remote-exec" {
    inline = [
      "cd /tmp",
      "curl -LO https://wordpress.org/latest.tar.gz",
      "tar xzvf latest.tar.gz",
      "cp /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php"
    ]
  }

  #Step 5: Configuring Wordpress
  provisioner "remote-exec" {
    inline = [
      "sudo chown -R www-data:www-data /var/www/html",
      "sudo find /var/www/html/ -type d -exec chmod 750 {} \\;",
      "sudo find /var/www/html/ -type f -exec chmod 640 {} \\;",
      "export wp_db=${var.wordpress_config.db}",
      "export wp_user=${var.wordpress_config.user}",
      "export wp_password=${var.wordpress_config.password}",
      "export wp_host=${var.mysql_config.host}",
      "sudo chmod +x /tmp/wp_config_automation.sh",
      "/tmp/wp_config_automation.sh",
      "sudo cp -a /tmp/wordpress/. /var/www/html"
    ]
  }
}
