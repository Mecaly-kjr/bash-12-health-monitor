# 🏷 bash-12-health-monitor

A Bash script that monitors disk usage, memory usage, and CPU load, logs system health, and warns when limits are exceeded.

---

## 📌 Problem Statement

Servers can experience high disk usage, memory usage, and CPU load without warning. This tool helps detect system problems early through automatic monitoring and logging.

---

## 🎯 Project Goals

- Monitor disk usage.
- Check memory usage.
- Monitor CPU load per core.
- Display OK or WARN messages.
- Save health reports in a log file.
- Run automatically every 15 minutes.

---

## 🛠 Tech Stack

**Language:**

- Bash

**Tools:**

- Linux
- ShellCheck
- awk
- Cron
- Git & GitHub

---

## 🖥 Features

- Disk usage monitoring.
- Memory usage monitoring.
- CPU load monitoring.
- Configurable warning limits.
- Timestamped log files.
- Quiet mode (`--quiet`).
- Correct exit codes (0 or 1).
- Automatic monitoring every 15 minutes.

---

## 📷 Screenshots

![alt text](<asset/images/Screenshot From 2026-11-04 17-05-03.png>)
![alt text](<asset/images/Screenshot From 2026-11-04 17-05-20.png>)

---

## ⚙ Installation & Setup

Clone the repository:

```bash
git clone https://github.com/Mecaly-kjr/bash-12-health-monitor.git
cd bash-12-health-monitor
```

Make the script executable:

```bash
chmod +x health.sh
```

Run the health monitor:

```bash
./health.sh
```

Run in quiet mode:

```bash
./health.sh --quiet
```

Test a memory warning:

```bash
MEM_LIMIT=1 ./health.sh
```

## 📋 How to Run

Run the script from the project directory:

```bash
./health.sh
```

Check the log:

```bash
tail -3 ~/logs/health.log
```

## 🧠 Challenges Faced

- Calculating memory usage correctly.
- Comparing decimal CPU load values using awk.
- Implementing warning limits and exit codes.
- Configuring cron for automatic monitoring.

## 📚 What I Learned

- Bash scripting and strict mode.
- Linux system monitoring commands.
- Using awk for calculations.
- Logging system health information.
- Scheduling tasks with cron.
- Installing commands using symbolic links.

## 🚀 Future Improvements

- Monitor additional system resources.
- Add email alerts for warnings.
- Improve log management.
- Add more system health checks.

## 👨🏽‍💻 Author

Mecaly Luther Bobbilla

[mecalyluther64@gmail.com](mailto:mecalyluther64@gmail.com)

Junior Developer | Software Engineering

Based in Cameroon.
