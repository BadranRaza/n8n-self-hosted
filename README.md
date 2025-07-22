# 🚀 n8n Self-Hosted Instance

A simple way to run n8n (workflow automation tool) on your computer with internet access.

## ✨ What This Does

- **🌐 Internet Access**: Access your n8n from anywhere (when your computer is on)
- **🔄 Always Updated**: Gets the latest version automatically
- **💾 Saves Your Work**: All your workflows are saved on your computer
- **⚡ Easy Setup**: Just double-click and follow the prompts

## 📋 What You Need

- **Docker Desktop** (the script will help you install this)
- **ngrok Account** (free account for internet access)
  - Sign up at: [https://ngrok.com/](https://ngrok.com/)

## 🚀 Getting Started

1. **Double-click** `start-n8n-server.bat`

2. **Follow the instructions** - the program will ask you for some information and help you set everything up

3. **That's it!** - n8n will open in your web browser when ready

**Note**: n8n will only be accessible when your computer is running and the program is started.

**Automatic Setup**: The program automatically creates the `n8n_data` folder to store your workflows and data.

## 🛠️ Using n8n

### After Starting
When the program finishes starting, you can:
- **[L]** See what's happening (logs)
- **[S]** Stop n8n
- **[A]** Open ngrok settings
- **[Q]** Close the program (n8n keeps running)

## 📁 Files in This Folder

```
n8n-self-hosted/
├── start-n8n-server.bat  # ← Double-click this to start
├── docker-compose.yml    # Settings for the program
├── .gitignore           # Technical file (ignore this)
├── README.md            # This help file
├── config.txt           # Your ngrok settings (created automatically)
└── n8n_data/            # Where your work is saved (created automatically)
```

## 🔧 Setup Information

The program will ask you for:
- **ngrok authtoken** (like a password for internet access)
- **ngrok domain** (like a web address for your n8n)

This information is saved in `config.txt` so you don't need to enter it again.

**Automatic Folder Creation**: The program automatically creates the `n8n_data` folder on first run to store your workflows and data. You can also move your old data files into this folder for seamless migration.

## 🛡️ Security

- n8n runs on your computer, internet access is secure
- Your login information is saved safely on your computer
- All your work is saved on your computer

## 🐛 If Something Goes Wrong

### Common Problems

- **Docker not working**: The program will help you install or start Docker
- **Internet access not working**: Delete the `config.txt` file and run the program again
- **Port already in use**: Close other programs that might be using the same ports

## 📚 More Information

- [n8n Help](https://docs.n8n.io/) - Learn how to use n8n
- [ngrok Help](https://ngrok.com/docs/) - Learn about internet access

## 🔄 Updates

The program automatically gets the latest version when you start it.
