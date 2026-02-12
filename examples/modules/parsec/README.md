# Parsec Module

This module installs Parsec on your Coder workspace for low-latency remote desktop access.

## Features
- Supports both **Linux** and **Windows**.
- Automatic installation of dependencies on Linux.
- Silent installer for Windows workspaces.

## Usage
```hcl
module "parsec" {
  source   = "[registry.coder.com/modules/parsec](https://registry.coder.com/modules/parsec)"
  agent_id = coder_agent.main.id
}

                 Note: Parsec requires a GPU-enabled workspace for the best experience.