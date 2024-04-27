### Homelab system

This project encapsulates the hardware / server level setup of my homelab via ansible.

Captured in this repo are the details relating to the underlying Debian and k3s installation, setup of prometheus node-exporters, local development scripts, etc.

The sister project exists under a corresponding `homelab-application` repo, which manages applications deployed within the k3s cluster.

### File structure

**`roles`**:
Contains ansible roles in which the majority of the setup functionality is stored

**`inv`**:
Contains environment-dependent inventory files and vars

### Deployments
This repo relies heavily on [taskfile.dev](https://taskfile.dev/) for most development / deployment operations