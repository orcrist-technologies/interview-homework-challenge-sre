
import re
import subprocess

import psutil
import click

class DiskStats:
    def get_disk_stats(self):
        volumes = []
        seen_base_disks = {}

        for partition in psutil.disk_partitions():
            try:
                usage = psutil.disk_usage(partition.mountpoint)
                volumes.append(partition.mountpoint)
                base = re.sub(r'(/dev/)(disk\d+).*', r'\1\2', partition.device)
                if base not in seen_base_disks:
                    seen_base_disks[base] = usage
            except PermissionError:
                continue

        total = sum(u.total for u in seen_base_disks.values())
        used  = sum(u.total - u.free for u in seen_base_disks.values())
        free  = sum(u.free for u in seen_base_disks.values())

        return {
            "volumes": volumes,
            "total": total,
            "used": used,
            "free": free,
            "used_percentage": round((used / total) * 100, 1) if total else 0,
        }


class CpuStats:
    def get_cpu_stats(self):
        return {
            "physical_cores": psutil.cpu_count(logical=False),
            "logical_cores": psutil.cpu_count(logical=True),
            "usage": psutil.cpu_percent(),
            "frequency_mhz": psutil.cpu_freq().current if psutil.cpu_freq() else None,
        }

class PortStats:
    def get_listening_ports(self):
        ports = []
        result = subprocess.run(
            ["lsof", "-iTCP", "-sTCP:LISTEN", "-n", "-P"],
            capture_output=True,
            encoding="utf-8"
        )
        for line in result.stdout.splitlines()[1:]:  # skip header
            parts = line.split()
            if len(parts) < 9:
                continue
            address, port = parts[8].rsplit(":", 1)
            ports.append({
                "pid": parts[1],
                "process": parts[0],
                "address": address,
                "port": int(port),
            })
        return sorted(ports, key=lambda x: x["port"])


class RamStats:
    def get_ram_stats(self):
        mem = psutil.virtual_memory()
        return {
            "total": mem.total,
            "used": mem.used,
            "free": mem.available,
            "used_percentage": mem.percent,
        }


class OverviewStats:
    def get_top_cpu_processes(self, n=10):
        processes = []
        for proc in psutil.process_iter(["pid", "name", "cpu_percent", "memory_percent"]):
            try:
                proc.cpu_percent(interval=None)  # initialise cpu_percent counter
            except (psutil.NoSuchProcess, psutil.AccessDenied):
                continue

        # second pass: read the actual value after interval
        for proc in psutil.process_iter(["pid", "name", "cpu_percent", "memory_percent"]):
            try:
                processes.append(proc.info)
            except (psutil.NoSuchProcess, psutil.AccessDenied):
                continue

        return sorted(processes, key=lambda x: x["cpu_percent"] or 0.0, reverse=True)[:n]
