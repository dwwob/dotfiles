#!/usr/bin/env python3
import re
import sys
from pathlib import Path

path = Path(sys.argv[1])
today = sys.argv[2]
lines = path.read_text().splitlines(keepends=True)

with open("/dev/tty") as terminal:
    for i, line in enumerate(lines):
        if line.startswith("## 📅 DAILY LOG:"):
            lines[i] = f"## 📅 DAILY LOG: {today}\n"
            continue

        blank_number = 0
        while re.search(r"_{3,}", line):
            blank_number += 1
            label = re.sub(r"^[\s-]*", "", line).split(":", 1)[0]
            prompt = f"{label}"
            if blank_number > 1:
                prompt += f" (blank {blank_number})"

            print(f"{prompt}: ", end="", flush=True)
            answer = terminal.readline().rstrip("\n")

            if not answer:
                break

            line = re.sub(r"_{3,}", lambda _: answer, line, count=1)
            lines[i] = line

path.write_text("".join(lines))
