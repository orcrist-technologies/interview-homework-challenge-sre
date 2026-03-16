#!/usr/bin/env python3

import psutil
import click

from stats import DiskStats, CpuStats, RamStats, PortStats, OverviewStats

def format_bytes(n):
    """Convert bytes to human-readable string."""
    for unit in ["B", "KB", "MB", "GB", "TB"]:
        if n < 1024:
            return f"{n:.1f} {unit}"
        n /= 1024
    return f"{n:.1f} PB"


@click.command()
@click.option("--disk", "-d", is_flag=True, help="check disk stats")
@click.option("--cpu", "-c", is_flag=True, help="check cpu stats")
@click.option("--ports", "-p", is_flag=True, help="check listen ports")
@click.option("--ram", "-r", is_flag=True, help="check ram stats")
@click.option("--overview", "-o", is_flag=True, help="top 10 processes with most CPU usage")
def myscript(disk, cpu, ports, ram, overview):
    """Myscript CLI tool to check system stats."""

    if disk:
        result = DiskStats().get_disk_stats()
        click.echo("\n=== Disk Stats ===")
        click.echo(f"Volumes  : {', '.join(result['volumes'])}")
        click.echo(f"Total    : {format_bytes(result['total'])}")
        click.echo(f"Used     : {format_bytes(result['used'])}")
        click.echo(f"Free     : {format_bytes(result['free'])}")
        click.echo(f"Used %   : {result['used_percentage']}%")

    if cpu:
        result = CpuStats().get_cpu_stats()
        click.echo("\n=== CPU Stats ===")
        click.echo(f"Cores     : {result['physical_cores']} (physical) / {result['logical_cores']} (logical)")
        click.echo(f"Usage     : {result['usage']}%")
        if result["frequency_mhz"]:
            click.echo(f"Frequency : {result['frequency_mhz']:.0f} MHz")

    if ports:
        click.echo("\n=== Listening Ports ===")
        for entry in PortStats().get_listening_ports():
            click.echo(
                f"port={entry['port']:<6} pid={entry['pid']:<6} "
                f"address={entry['address']:<16} process={entry['process']}"
            )

    if ram:
        result = RamStats().get_ram_stats()
        click.echo("\n=== RAM Stats ===")
        click.echo(f"Total    : {format_bytes(result['total'])}")
        click.echo(f"Used     : {format_bytes(result['used'])}")
        click.echo(f"Free     : {format_bytes(result['free'])}")
        click.echo(f"Used %   : {result['used_percentage']}%")

    if overview:
        click.echo("\n=== Top 10 Processes by CPU ===")
        for proc in OverviewStats().get_top_cpu_processes():
            click.echo(
                f"pid={proc['pid']:<6} cpu={proc['cpu_percent'] or 0.0:>5.1f}%  "
                f"mem={proc['memory_percent'] or 0.0:>5.1f}%  name={proc['name']}"
            )
if __name__ == "__main__":
    myscript()