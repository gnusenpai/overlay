"""
Generate a colorscheme using gnucolor.
"""
import logging
import shutil
import subprocess
import sys

from .. import colors
from .. import util


def gen_colors(img, light):
    """Generate a colorscheme using Colorz."""
    if light:
        cmd = ["gnucolor", "-f", "hex", "-o", "0", "-i"]
        print("light is enabled")
    else:
        cmd = ["gnucolor", "-f", "hex", "-o", "0", "-i"]
        print("light is disabled")
    return subprocess.check_output([*cmd, img]).splitlines()


def adjust(cols, light):
    """Create palette."""
    raw_colors = [*cols]

    """return colors.generic_adjust(raw_colors, light)"""
    return raw_colors


def get(img, light=False):
    """Get colorscheme."""
    if not shutil.which("gnucolor"):
        logging.error("gnucolor wasn't found on your system.")
        logging.error("Try another backend. (wal --backend)")
        sys.exit(1)

    cols = [col.decode('UTF-8') for col in gen_colors(img, light)]
    return adjust(cols, light)
