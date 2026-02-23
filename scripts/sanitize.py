#!/usr/bin/env python3
"""
Sanitize Markdown sources in ./docs

Currently normalizes:
- U+2011 (non-breaking hyphen) → "-"
- U+2010 (hyphen) → "-"
- U+2013 (en dash) → "-"
- U+2212 (mathematical minus) → "-"

Usage:
    python3 scripts/sanitize.py
"""

from pathlib import Path
import sys

ROOT = Path("docs")

# Characters to normalize → ASCII hyphen
REPLACEMENTS = {
    "\u2011": "-",  # non-breaking hyphen
    # "\u2010": "-",  # hyphen
    # "\u2013": "-",  # en dash
    # "\u2212": "-",  # mathematical minus -- could break math formulas, so not replacing for now
}


def sanitize_file(path: Path) -> bool:
    text = path.read_text(encoding="utf-8")
    new_text = text

    for bad, good in REPLACEMENTS.items():
        new_text = new_text.replace(bad, good)

    if new_text != text:
        path.write_text(new_text, encoding="utf-8")
        print(f"Fixed: {path}")
        return True

    return False


def main():
    if not ROOT.exists():
        print("docs/ directory not found.", file=sys.stderr)
        sys.exit(1)

    modified = 0

    for path in ROOT.rglob("*.md"):
        if sanitize_file(path):
            modified += 1

    print(f"\nTotal files modified: {modified}")


if __name__ == "__main__":
    main()
