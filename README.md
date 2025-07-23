# 🚀 n8n Self-Hosted

![Docker](https://img.shields.io/badge/Docker-Required-blue.svg)
![Version](https://img.shields.io/badge/version-1.0.0-brightgreen.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![Platform](https://img.shields.io/badge/platform-Windows-lightgrey.svg)

A powerful and production-ready **one-click n8n self-hosted solution** for Windows. Features automatic Docker setup, secure ngrok tunneling, persistent data storage, and a guided setup wizard for seamless workflow automation deployment.

## ✨ Core Features

- **🚀 One-Click Setup**: Double-click to start with an intelligent setup wizard that guides you through the entire process
- **🌐 Internet Access**: Secure public access via ngrok with static domains - access your n8n from anywhere when your computer is running
- **🔄 Always Updated**: Automatically pulls the latest n8n Docker images on every start
- **💾 Persistent Data**: All workflows, credentials, and data are safely stored locally in the `n8n_data` folder
- **🛡️ Security First**: Runs entirely on your local machine with encrypted tunneling for internet access
- **⚡ Smart Docker Management**: Automatic Docker detection, installation assistance, and startup management
- **🎯 Zero Configuration**: First-time setup wizard saves your ngrok credentials for future use
- **📊 Interactive Management**: Built-in menu system for viewing logs, stopping services, and accessing ngrok admin

## 🎮 How to Use

This guide will walk you through setting up your n8n self-hosted instance in minutes.

### 1. Download & Extract
1. **Download** the latest release from [GitHub Releases](https://github.com/BadranRaza/n8n-self-hosted/releases/tag/v1.0.0)
2. **Extract** the zip file to a folder on your computer
3. **Navigate** to the extracted folder

### 2. First-Time Setup
1. **Double-click** `start-n8n-server.bat`
2. **Follow the guided setup** - the wizard will help you:
   - Sign up for a free ngrok account (if needed)
   - Get your ngrok authentication token
   - Create a static domain for your n8n instance
3. **Wait for initialization** - Docker images will be downloaded and services started
4. **That's it!** - n8n will automatically open in your web browser

### 3. Using Your n8n Instance

After the initial setup, you can:

- **[L]** View live logs to monitor your n8n instance
- **[S]** Stop all services (n8n and ngrok)
- **[A]** Open ngrok admin dashboard for tunnel management
- **[Q]** Close the management console (n8n keeps running)

### 4. Accessing Your n8n

- **Public URL**: `https://your-domain.ngrok-free.app` (accessible from anywhere)
- **Local URL**: `http://localhost:5678` (when on your computer)
- **ngrok Admin**: `http://localhost:4040` (for tunnel management)

## 🔧 Technical Details

### System Requirements
- **Windows 10/11** (64-bit)
- **Internet connection** (for initial setup and ngrok tunneling)
- **4GB RAM** (minimum, 8GB recommended)
- **2GB free disk space**

### Architecture
```
n8n-self-hosted/
├── start-n8n-server.bat    # One-click launcher with setup wizard
├── docker-compose.yml      # Container orchestration
├── config.txt              # ngrok credentials (auto-generated)
├── n8n_data/               # Persistent data storage (auto-created)
└── README.md               # This documentation
```

### Services
- **n8n**: Latest version with SQLite database for data persistence
- **ngrok**: Secure tunnel service with static domain support
- **Docker**: Container management and orchestration

### Data Persistence
All your n8n data is stored locally in the `n8n_data` folder:
- Workflows and their configurations
- Credentials and API keys
- Execution history and logs
- Custom nodes and extensions

## 🛡️ Security & Privacy

- **Local Execution**: n8n runs entirely on your computer
- **Encrypted Tunneling**: ngrok provides secure HTTPS access
- **Credential Safety**: All sensitive data stored locally
- **No Cloud Dependencies**: Your data never leaves your machine
- **Automatic Updates**: Always runs the latest secure n8n version

## 🚀 Installation Guide

### Quick Start
1. **Download** from [GitHub Releases](https://github.com/BadranRaza/n8n-self-hosted/releases/tag/v1.0.0)
2. **Extract** the zip file
3. **Double-click** `start-n8n-server.bat`
4. **Follow** the setup wizard
5. **Start** automating!

### Manual Installation (Advanced)
If you prefer to clone the repository:
```bash
git clone https://github.com/BadranRaza/n8n-self-hosted.git
cd n8n-self-hosted
start-n8n-server.bat
```

## 🐛 Troubleshooting

### Common Issues

**Docker Not Working**
- The script will automatically help you install Docker Desktop
- If Docker is installed but not starting, the script will attempt to start it
- Restart your computer if prompted after Docker installation

**Internet Access Issues**
- Delete the `config.txt` file and run the script again
- Verify your ngrok credentials are correct
- Check that your ngrok account has an active static domain

**Port Conflicts**
- Close other applications that might be using ports 5678 or 4040
- The script will automatically handle port management

**Data Migration**
- Copy your existing n8n data files into the `n8n_data` folder
- The system will automatically detect and use your existing workflows

### Getting Help
- Check the [n8n Documentation](https://docs.n8n.io/) for workflow help
- Visit [ngrok Documentation](https://ngrok.com/docs/) for tunnel issues
- Open an issue on GitHub for script-related problems

## 📚 More Information

- **[n8n Documentation](https://docs.n8n.io/)** - Learn how to use n8n workflows
- **[ngrok Documentation](https://ngrok.com/docs/)** - Understand tunnel configuration
- **[Docker Documentation](https://docs.docker.com/)** - Learn about containerization

## 🔄 Updates

The system automatically updates to the latest n8n version on every start. No manual intervention required.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**⭐ Star this repo if it helped you!** 

Made with ❤️ by [Badran Raza](https://github.com/BadranRaza)
