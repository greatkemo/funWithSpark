# funWithSpark 🚀✨

> A fun exploration project for learning Spark on Kubernetes with k3s, Multipass, and Ansible on Apple Silicon Macs!

*🤖 This project was crafted with the help of Claude Sonnet 4 with GitHub Copilot - because even AI loves playing with Spark! ⚡️*

[![Made with ❤️](https://img.shields.io/badge/Made%20with-❤️-red.svg)](https://github.com/greatkemo/funWithSpark)
[![ARM64](https://img.shields.io/badge/ARM64-Compatible-green.svg)](https://github.com/greatkemo/funWithSpark)
[![k3s](https://img.shields.io/badge/k3s-Kubernetes-blue.svg)](https://k3s.io/)
[![Spark](https://img.shields.io/badge/Apache-Spark-orange.svg)](https://spark.apache.org/)

## 🎯 What is this?

This is a **fun learning project** that demonstrates how to:
- Spin up a 3-node Kubernetes cluster using **k3s** and **Multipass** on Mac Studio (Apple Silicon)
- Deploy the **Spark Operator** using Helm
- Run Spark applications on Kubernetes
- Automate everything with **Ansible** and **Make**
- Use **VS Code** for a great developer experience

**Disclaimer**: This is a playground for experimenting and learning! Not intended for production use. 😄

## 🏗️ What You Get

- **3-node k3s cluster** running on Ubuntu 24.04 ARM64 VMs
- **Spark Operator** deployed and configured
- **Automated provisioning** with Ansible playbooks
- **One-command setup** with Makefile targets
- **VS Code integration** with tasks and recommended extensions
- **ARM64 compatible** everything (perfect for Apple Silicon Macs)

## 🚀 Quick Start

### Prerequisites (on macOS)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install multipass ansible kubectl helm
```

### One-Command Demo
```bash
make demo
```

This magical command will:
1. 🖥️ Create 3 Ubuntu 24.04 VMs via Multipass
2. 🔑 Configure passwordless SSH access
3. ⚙️ Deploy k3s cluster via Ansible (1 master + 2 workers)
4. 📋 Fetch and configure kubeconfig
5. 🎡 Install Spark Operator with Helm
6. ✨ Submit a Spark Pi calculation job
7. 📊 Stream the logs

## 🎮 Available Commands

```bash
make vms          # Create VMs with Multipass
make ssh          # Setup SSH keys
make k3s          # Deploy k3s cluster
make kubeconfig   # Get cluster access
make helm         # Install Spark Operator
make submit       # Submit Spark Pi job
make logs         # Watch Spark logs
make status       # Check cluster health
make test         # Run Spark functionality tests
make destroy      # Clean up everything
```

## 📁 Project Structure

```
funWithSpark/
├── 📖 README.md              # This file!
├── 🔧 Makefile               # One-command automation
├── 📋 inventory.ini          # Ansible inventory
├── 🏗️ ansible/               # k3s cluster setup
│   ├── k3s-cluster.yml       # Main playbook
│   └── group_vars/all.yml    # Variables
├── 🚀 manifests/             # Kubernetes manifests
│   ├── spark-pi.yaml         # Spark Pi job
│   ├── spark-rbac.yaml       # RBAC configuration
│   └── *-test.yaml           # Various test jobs
├── 📜 scripts/               # Helper scripts
│   ├── create_vms.sh         # VM creation
│   ├── setup_ssh.sh          # SSH configuration
│   └── fetch_kubeconfig.sh   # Kubeconfig setup
├── 🧪 TESTING.md             # Testing guide
└── 🛠️ .vscode/               # VS Code configuration
```

## 🎯 VS Code Integration

Open in VS Code and enjoy:
- **Recommended extensions** auto-install
- **Tasks** available via Command Palette (`Cmd+Shift+P` → "Tasks: Run Task")
- **Integrated terminal** with all commands ready
- **YAML/Ansible syntax highlighting**

## 🧪 Testing Your Setup

```bash
# Quick health check
make status

# Run functionality tests  
make test

# Check individual components
kubectl --kubeconfig=~/.kube/config-k3s get nodes
kubectl --kubeconfig=~/.kube/config-k3s get pods -n spark-operator
```

## 🎉 What's Working

- ✅ **Infrastructure**: 3-node k3s cluster on ARM64
- ✅ **Networking**: All nodes communicating
- ✅ **Spark Operator**: Deployed and functional
- ✅ **RBAC**: Properly configured permissions
- ✅ **Container Runtime**: containerd working
- ✅ **Automation**: Full pipeline automated

## 🤔 Known Quirks

- ⚠️ **Ivy Configuration**: Spark Shell has some dependency resolution issues in containerized environment
- 💡 **Workaround**: Use pre-compiled Spark applications or different images
- 🔧 **Resource Tuning**: May need adjustment for smaller VMs

## 🧹 Cleanup

```bash
# Clean up test resources
make clean-tests

# Full teardown (removes VMs)
make destroy
```

## 🎓 What You'll Learn

- **Kubernetes orchestration** with k3s
- **Infrastructure as Code** with Ansible
- **Container orchestration** concepts
- **Spark on Kubernetes** deployment patterns
- **Development workflow** automation
- **ARM64 compatibility** considerations

## 🎈 Why "Fun"?

Because learning should be enjoyable! This project:
- 🚀 Gets you up and running quickly
- 🎯 Focuses on the fun parts (not production complexity)
- 🧪 Encourages experimentation
- 💡 Teaches real-world skills
- ❤️ Made with love for the learning community

## 🤝 Contributing

This is a fun learning project! Feel free to:
- 🐛 Report issues
- 💡 Suggest improvements  
- 🔧 Submit PRs
- ⭐ Star if you found it useful
- 📢 Share your experiments

## 📜 License

MIT License - Have fun with it! 🎉

## 🙏 Acknowledgments

- **k3s team** for making Kubernetes accessible
- **Spark community** for the amazing framework
- **Multipass team** for easy VM management
- **Ansible community** for automation magic
- **Everyone** who makes learning fun! 🌟

---

**Happy Sparking!** ✨🚀

> Made with ❤️ on Apple Silicon • Built for Fun • Shared for Learning
