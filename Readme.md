Linux-file-cleaner

Problem Statement

In Linux systems, temporary and old files often occupy disk space unnecessarily.
Usually, users manually check directories and delete files older than a certain number of days, which is time-consuming and risky.

This script helps automate that process safely using shell scripting.

What this script does

Finds files older than a specified number of days

Works on a user-provided directory

Shows the files before deleting (safe by default)

Deletes files only if -r option is given

Uses getopts to handle command-line arguments properly

Usage

./cleanup.sh -d <directory_path> -n <days> [-r]

Options Explained
Option	Meaning
-d	Directory path to check for old files
-n	Number of days (files older than this will be considered)
-r	Remove files (if not used, script only shows files)

Examples

Just check old files (no delete):

./cleanup.sh -d /var/log -n 10


Delete old files:

./cleanup.sh -d /var/log -n 10 -r

Safety Feature

By default, the script does NOT delete files.
Deletion happens only when -r option is provided.
This helps avoid accidental data loss.

Explanation of Important Terms

getopts

getopts is a shell built-in used to read command-line options like -d, -n, and -r.It makes scripts flexible and easier to use compared to fixed positional arguments.

OPTARG

OPTARG stores the value passed to an option.

Example:

-d /tmp


Here:

d is the option

/tmp is stored in OPTARG

ase statement

Used to handle different options cleanly.

Example:

case $opt in
  d) DIR="$OPTARG" ;;
  n) DAYS="$OPTARG" ;;
esac


This assigns values based on which option is used.

find command

Used to search files in a directory.

find "$DIR" -type f -mtime +"$DAYS"


Meaning:

-type f → only files

-mtime +DAYS → files older than given days

Validation checks

The script checks:

If directory and days are provided

If directory exists

If files matching criteria exist

This avoids runtime errors and unsafe execution.

This script is created as a learning project to apply Linux and shell scripting concepts in a real-world scenario.