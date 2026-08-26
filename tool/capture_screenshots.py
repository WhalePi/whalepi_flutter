#!/usr/bin/env python3
"""Capture App Store screenshots from a booted simulator.

Runs integration_test/screenshots_test.dart against a simulator and grabs the
screen each time the test prints a SCREENSHOT_READY marker. The test holds each
screen still for a few seconds, which is the window this script captures in.

Usage:
    python3 tool/capture_screenshots.py <udid> <output-dir>
"""

import pathlib
import subprocess
import sys

MARKER = "SCREENSHOT_READY:"


def main() -> int:
    if len(sys.argv) != 3:
        print(__doc__)
        return 2

    udid, out_dir = sys.argv[1], pathlib.Path(sys.argv[2])
    out_dir.mkdir(parents=True, exist_ok=True)

    proc = subprocess.Popen(
        [
            "flutter", "test",
            "integration_test/screenshots_test.dart",
            "-d", udid,
        ],
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        bufsize=1,
    )

    captured = []
    assert proc.stdout is not None
    for line in proc.stdout:
        line = line.rstrip()
        if MARKER in line:
            name = line.split(MARKER, 1)[1].strip()
            path = out_dir / f"{name}.png"
            subprocess.run(
                ["xcrun", "simctl", "io", udid, "screenshot", str(path)],
                capture_output=True,
                check=False,
            )
            captured.append(path)
            print(f"  captured {path.name}")
        elif line.strip():
            print(f"  | {line}")

    code = proc.wait()
    print(f"\nflutter test exited {code}; captured {len(captured)} screenshots")
    for p in captured:
        print(f"  {p}")
    return 0 if captured else 1


if __name__ == "__main__":
    raise SystemExit(main())
