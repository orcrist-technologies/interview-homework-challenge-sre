# Challenge 2: System Stats CLI

## Objective

Build a Python CLI tool to report system information: disk, CPU, RAM, listening ports, and top processes by CPU usage.

## Usage

install Dependencies

```bash
python3 -m venv myscript
source myscript/bin/activate
pip install -r requirements.txt
```

```bash
✗ python myscript.py --help
Usage: myscript.py [OPTIONS]

  Myscript CLI tool to check system stats.

Options:
  -d, --disk      check disk stats
  -c, --cpu       check cpu stats
  -p, --ports     check listen ports
  -r, --ram       check ram stats
  -o, --overview  top 10 processes with most CPU usage
  --help          Show this message and exit.|

Flags can be combined:

```bash
python myscript.py --disk --cpu --ram --overview
python myscript.py -d -c -r -p -o
```

## Implementation

### Files

```bash
challenge-2/src
├── myscript.py   # CLI entrypoint (click)
└── stats.py      # Stats classes
```

### myscript.py

CLI entrypoint built with `click`. Each flag calls the corresponding stats class and prints formatted output. Includes a `format_bytes()` helper to convert raw bytes to human-readable units (B, KB, MB, GB, TB).

### stats.py

Five classes, each with a single public method:

**`DiskStats.get_disk_stats()`** — iterates `psutil.disk_partitions()`, deduplicates base disks, and returns volumes, total, used, free, and used percentage.

**`CpuStats.get_cpu_stats()`** — returns physical/logical core count, current usage percentage, and frequency in MHz via `psutil`.

**`RamStats.get_ram_stats()`** — returns total, used, available, and usage percentage from `psutil.virtual_memory()`.

**`PortStats.get_listening_ports()`** — runs `lsof -iTCP -sTCP:LISTEN` and parses output into a list of port, pid, address, and process name, sorted by port.

**`OverviewStats.get_top_cpu_processes()`** — uses a two-pass approach with `psutil.process_iter()`: first pass initialises the CPU percent counter, second pass reads the actual values, then returns the top 10 sorted by CPU usage.

## Sample output

```bash
✗ python myscript.py --disk --cpu --ram --overview

=== Disk Stats ===
Volumes  : /, /System/Volumes/VM, /System/Volumes/Preboot, /System/Volumes/Update, /System/Volumes/xarts, /System/Volumes/iSCPreboot, /System/Volumes/Hardware, /System/Volumes/Data, /System/Volumes/Update/mnt1
Total    : 228.8 GB
Used     : 200.1 GB
Free     : 28.7 GB
Used %   : 87.5%

=== CPU Stats ===
Cores     : 8 (physical) / 8 (logical)
Usage     : 50.0%
Frequency : 3204 MHz

=== RAM Stats ===
Total    : 16.0 GB
Used     : 5.0 GB
Free     : 2.7 GB
Used %   : 83.0%

=== Top 10 Processes by CPU ===
pid=4596   cpu= 97.6%  mem=  0.1%  name=Python
pid=8665   cpu= 88.8%  mem=  0.4%  name=ReportCrash
pid=79283  cpu= 77.6%  mem=  2.8%  name=Google Chrome Helper (Renderer)
pid=77141  cpu= 69.1%  mem=  9.2%  name=com.apple.Virtualization.VirtualMachine
pid=39863  cpu= 16.2%  mem=  0.7%  name=iTerm2
pid=71378  cpu=  2.4%  mem=  1.0%  name=Google Chrome Helper (Renderer)
pid=523    cpu=  1.4%  mem=  0.1%  name=corespeechd
pid=2576   cpu=  1.2%  mem=  0.1%  name=Siri
pid=54836  cpu=  1.1%  mem=  0.1%  name=Code Helper
pid=82665  cpu=  0.9%  mem=  0.3%  name=Google Chrome Helper (Renderer)

```
