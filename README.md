# bash-12-health-monitor

A Bash system health monitor that checks disk usage, memory usage, and CPU load, logs results, and warns when system limits are exceeded.

## 📌 Problem Statement

Servers can experience high disk usage, memory usage, and CPU load without warning. This tool helps detect potential system problems early through automatic monitoring and logging.

## 🎯 Project Goals

- Monitor root disk usage.
- Check memory usage.
- Monitor CPU load per core.
- Display OK or WARN messages.
- Save health reports with timestamps.
- Run automatically every 15 minutes.

## 🛠 Tech Stack

- Bash
- Linux
- awk
- ShellCheck
- Cron
- Git and GitHub Actions

## 🖥 Features

- Disk usage monitoring.
- Memory usage monitoring using MemAvailable.
- CPU load monitoring per core.
- Configurable warning limits.
- Timestamped log files.
- Quiet mode using `--quiet`.
- Exit codes: 0 for OK and 1 for warnings.
- Automatic monitoring every 15 minutes.

## 📷 Screenshots

![alt text](<asset/images/Screenshot From 2026-11-04 17-05-03.png>)
![alt text](<asset/images/Screenshot From 2026-11-04 17-05-20.png>)

## ⚙ Installation & Setup

### 1. Clone the repository

```bash
git clone https://github.com/Mecaly-kjr/bash-12-health-monitor.git
cd bash-12-health-monitor
```

### 2. Make the script executable

```bash
chmod +x health.sh
```

### 3. Run the health monitor

```bash
./health.sh
```

### 4. Test quiet mode

```bash
./health.sh --quiet
```

### 5. Test warning detection

```bash
MEM_LIMIT=1 ./health.sh
echo $?
```

Expected exit code: `1` when a warning is detected.

## 📋 Install as a System Command

Create the local bin directory:

```bash
mkdir -p ~/.local/bin
```

Create a symbolic link:

```bash
ln -sf "$PWD/health.sh" ~/.local/bin/health
```

Add the local bin directory to PATH only once:

```bash
grep -q 'local/bin' ~/.bashrc || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
```

Reload the Bash configuration:

```bash
source ~/.bashrc
hash -r
```

Now run the monitor from any directory:

```bash
health
```

## 📝 Logging

Health check results are saved in:

```bash
~/logs/health.log
```

View the latest entries:

```bash
tail -3 ~/logs/health.log
```

## ⏰ Automatic Monitoring with Cron

Open your crontab:

```bash
crontab -e
```

Add this line to run the monitor every 15 minutes:

```cron
*/15 * * * * $HOME/.local/bin/health --quiet
```

Check your scheduled task:

```bash
crontab -l
```

## 🔧 Configuration

Default warning limits:

- Disk usage: 3%.
- Memory usage: 69%.
- CPU load: 0.90 0n 12 cores.

You can customize the limits:

```bash
DISK_LIMIT=90 MEM_LIMIT=75 health
```

## 🧪 Testing

Check Bash syntax:

```bash
bash -n health.sh
```

Run ShellCheck:

```bash
shellcheck health.sh
```

Test normal monitoring:

```bash
health
echo $?
```

Test quiet mode and warning detection:

```bash
MEM_LIMIT=1 health --quiet
echo $?
```

Check the log:

```bash
tail -3 ~/logs/health.log
```

## 🧠 Challenges Faced

- Calculating memory usage using MemAvailable.
- Comparing decimal load averages using awk.
- Implementing configurable warning limits.
- Handling quiet mode and exit codes.
- Configuring automatic monitoring with cron.

## 📚 What I Learned

- Bash scripting with strict mode.
- Linux system monitoring commands.
- Using awk for calculations.
- Logging system health information.
- Scheduling tasks with cron.
- Installing commands using symbolic links.
- Automating code checks with GitHub Actions.

## 🚀 Future Improvements

- Add email alerts when warnings occur.
- Monitor additional system resources.
- Improve log rotation.
- Add more health checks.

## 👨🏽‍💻 Author

**Mecaly Luther Bobbilla**

Computer Engineering Graduate  
Cameroon | Open to opportunities