# Show/Hide hidden files on open.
# (Off by default)
export FFF_HIDDEN=1

# Use LS_COLORS to color fff.
# (On by default if available)
# (Ignores FFF_COL1)
export FFF_LS_COLORS=1

# Directory color [0-9]
export FFF_COL1=2

# Status background color [0-9]
export FFF_COL2=7

# Selection color [0-9] (copied/moved files)
export FFF_COL3=6

# Cursor color [0-9]
export FFF_COL4=1

# Status foreground color [0-9]
export FFF_COL5=0

# Text Editor
export EDITOR="vim"

# File Opener
export FFF_OPENER="start"

# File Attributes Command
export FFF_STAT_CMD="stat"

# Enable or disable CD on exit.
# (On by default)
export FFF_CD_ON_EXIT=0

# CD on exit helper file
# Default: '${XDG_CACHE_HOME}/fff/fff.d'
#          If not using XDG, '${HOME}/.cache/fff/fff.d' is used.
export FFF_CD_FILE=~/.fff_d

# Trash Directory
# Default: '${XDG_DATA_HOME}/fff/trash'
#          If not using XDG, '${HOME}/.local/share/fff/trash' is used.
export FFF_TRASH=~/.local/share/fff/trash

# Trash Command
# Default: 'mv'
#          Define a custom program to use to trash files.
#          The program will be passed the list of selected files
#          and directories.
export FFF_TRASH_CMD="mv"

# Favourites (Bookmarks) (keys 1-9) (dir or file)
export FFF_FAV1=/c/Users/dumitru.spiridon/Documents
export FFF_FAV2=/c/Users/dumitru.spiridon/Downloads
export FFF_FAV3=~/.bashrc
export FFF_FAV4=~/.vimrc
export FFF_FAV5=/e//
export FFF_FAV6=/c/Users/dumitru.spiridon/
export FFF_FAV7=
export FFF_FAV8=
export FFF_FAV9=
export FFF_FAV9=

# w3m-img offsets.
export FFF_W3M_XOFFSET=0
export FFF_W3M_YOFFSET=0

# File format.
# Customize the item string.
# Format ('%f' is the current file): "str%fstr"
# Example (Add a tab before files): FFF_FILE_FORMAT="\t%f"
export FFF_FILE_FORMAT="%f"

# Mark format.
# Customize the marked item string.
# Format ('%f' is the current file): "str%fstr"
# Example (Add a ' >' before files): FFF_MARK_FORMAT="> %f"
export FFF_MARK_FORMAT=" %f*"

export PATH=$PATH:/c/Users/dumitru.spiridon/fff
