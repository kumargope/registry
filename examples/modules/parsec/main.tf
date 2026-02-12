terraform {
  required_version = ">= 1.0"
  required_providers {
    coder = {
      source  = "coder/coder"
      version = ">= 2.5"
    }
  }
}

variable "agent_id" {
  type        = string
  description = "The ID of a Coder agent."
}

resource "coder_script" "parsec_install" {
  agent_id     = var.agent_id
  display_name = "Parsec Installer"
  icon         = "https://raw.githubusercontent.com/parsec-cloud/parsec-sdk/master/parsec.png"
  script       = file("${path.module}/run.sh")
  run_on_start = true
}

resource "coder_app" "parsec" {
  agent_id     = var.agent_id
  slug         = "parsec"
  display_name = "Parsec"
  url          = "https://parsec.app/local"
  icon         = "https://raw.githubusercontent.com/parsec-cloud/parsec-sdk/master/parsec.png"
}