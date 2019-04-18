#!/usr/bin/env bash

# Set to the program's basename.
scriptName=$(basename "${0}")

# Provide a variable with the location of this script.
scriptPath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Set default flags
examples=0
args=()

# Main function
function mainScript() {

  echo $args
  echo $examples

}

# Exit cleanly
function safeExit() {
  trap - INT TERM EXIT
  exit
}

# Print usage
usage() {
  echo -n "${scriptName} [--options] <path-to-venv>

Install OpenCV into a Python Virtual Environment

 Options:
  -e, --build-examples   Build and install OpenCV examples
  -h, --help             Display this help and exit

"
}

# Iterate over options breaking -ab into -a -b when needed and --foo=bar into
# --foo bar
optstring=h
unset options
while (($#)); do
  case $1 in
    # If option is of type -ab
    -[!-]?*)
      # Loop over each character starting with the second
      for ((i=1; i < ${#1}; i++)); do
        c=${1:i:1}

        # Add current char to options
        options+=("-$c")

        # If option takes a required argument, and it's not the last char make
        # the rest of the string its argument
        if [[ $optstring = *"$c:"* && ${1:i+1} ]]; then
          options+=("${1:i+1}")
          break
        fi
      done
      ;;

    # If option is of type --foo=bar
    --?*=*) options+=("${1%%=*}" "${1#*=}") ;;
    # add --endopts for --
    --) options+=(--endopts) ;;
    # Otherwise, nothing special
    *) options+=("$1") ;;
  esac
  shift
done
set -- "${options[@]}"
unset options

# Print help if no arguments were passed.
[[ $# -eq 0 ]] && set -- "--help"

# Read the options and set stuff
while [[ $1 = -?* ]]; do
  case $1 in
    -h|--help) usage >&2; safeExit ;;
    -e|--build-examples) examples=1 ;;
    --endopts) shift; break ;;
    *) die "invalid option: '$1'."; exit 1 ;;
  esac
  shift
done

# Store the remaining part as arguments.
args+=("$@")

# Run script
mainScript

# Exit cleanly
safeExit
