provider "cloudinit" {}

# data source for init.cfg
data "template_file" "init_script" {
  template = file(var.cloudinit_script_path)
}

# data source for mounting ebs volume script
data "template_file" "mount_ebs_volume_script" {
  template = file(var.mount_ebs_volume_script_path)
  vars = {
    DEVICE = var.ebs_device_name_hack
  }
}

# render a multipart cloud-init config using all data sources
data "template_cloudinit_config" "init_scripts" {
  gzip          = false
  base64_encode = false
  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.init_script.rendered
  }
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.mount_ebs_volume_script.rendered
  }
}