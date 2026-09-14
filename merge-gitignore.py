#!/usr/bin/env python3
#
# NOTE: Strictly speaking, it does not perform a merge; instead, it checks
# whether the new file is a superset of the old file.

import sys
import os

def read_gitignore(filepath):
    """Reads a file and returns a set of valid patterns, excluding blank lines and comments."""
    patterns = set()
    if not os.path.exists(filepath):
        return patterns
    with open(filepath, 'r', encoding='utf-8') as f:
        for line in f:
            clean_line = line.strip()
            if clean_line and not clean_line.startswith('#'):
                patterns.add(clean_line)
    return patterns

def main():
    if len(sys.argv) < 3:
        print("ERROR: not enough arguments", file=sys.stderr)
        print("USAGE: python3 merge-gitignore.py {new file path} {old file path}", file=sys.stderr)
        sys.exit(1)

    new_path = sys.argv[1]
    old_path = sys.argv[2]

    # Extract patterns
    new_patterns = read_gitignore(new_path)
    old_patterns = read_gitignore(old_path)

    # Determine that, is the pattern from the old file completely contained
    # within the new file?
    if old_patterns.issubset(new_patterns):
        #print(f"deleted old file {old_path}: it is a subset of new file {new_path}", file=sys.stderr)
        os.remove(old_path)
        sys.exit(0)
    else:
        #print(f"keeping old file {old_path}: it has unique patterns", file=sys.stderr)
        sys.exit(2)

if __name__ == '__main__':
    main()
