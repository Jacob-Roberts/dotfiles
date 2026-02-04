#!/usr/bin/env zsh

# Exit on error
set -e

# This script runs some static analysis tools against our code base.
# To only run the static analysis tools against the services that
# have been changed in the current branch use the following:
#   ./bin/_run_rpcmap --diff

if [[ "$1" == "--diff" ]]; then
  echo "⏱  Finding services modified in branch"
  # Use an array to store results
  testable_raw=(${(f)"$(aps --include-dependencies=false)"})
  
  # Check if any element matches bedrock or libraries/
  if (( ${testable_raw[(I)(bedrock|libraries/*)]} )); then
      echo "⏱  Finding dependencies of modified services due to change in libraries"
      testable_raw=(${(f)"$(aps --include-dependencies=true)"})
  fi
else
  echo "⏱  Running against all services"
  # Use Zsh recursive globbing and qualifiers:
  # (/) matches only directories
  testable_raw=(
    (edge-proxy*|cron.*|service.*|bedrock|ingress-*|libraries/*|staff-vpn/*)(/)
  )
fi

# Filter: Only keep directories containing .go files or starting with 'cron.'
testable=()
for dir in $testable_raw; do
  if [[ -n $dir/*.go(N[1]) ]] || [[ $dir == cron.* ]]; then
    testable+=("$dir")
  fi
done

# Check if array is empty
if (( ${#testable} == 0 )); then
  echo "Nothing to test, exiting"
  exit 0
fi

echo "Running tests against:"
print -l "${testable[@]}"

EXIT=0
echo "⏱  Checking cronjobs"
for dir in $testable; do
  [[ $dir != cron.* ]] && continue

  # Zsh-friendly grep check
  if grep -Roh "Host: service\..*" "$dir" >/dev/null 2>&1; then
    # Check if any .rule files exist using (N) nullglob
    if [[ -z $dir/manifests/egress/*.rule(N) ]]; then
      echo "$dir has no egress rules but appears to call service(s)"
      EXIT=1
    fi
  fi
done

echo "⏱  Running rpcmap"
rpcmap_dirs=()
for dir in $testable; do
  # Get the first part of the path
  top_level_dir="${dir%%/*}"
  if [[ -f "$top_level_dir/main.go" ]]; then
    rpcmap_dirs+=("$top_level_dir")
  fi
done

# Remove duplicates and specific service
# ${(u)...} makes the array unique
rpcmap_dirs=(${(u)rpcmap_dirs})
# Filter out service.acceptance-tests using array subtraction
rpcmap_dirs=(${rpcmap_dirs:#service.acceptance-tests})

if (( ${#rpcmap_dirs} > 0 )); then
  echo "rpcmap is generating: ${rpcmap_dirs[*]}"
  
  # Format package names
  rpcmap_packages=()
  for d in $rpcmap_dirs; do
    rpcmap_packages+=("github.com/monzo/wearedev/$d")
  done

  # Run rpcmap with xargs
  NUM_SERVICES_PER_RPCMAP="15"
  print -l "${rpcmap_packages[@]}" | xargs -n "$NUM_SERVICES_PER_RPCMAP" rpcmap -generate || {
    echo "Make sure you are using an up-to-date version of rpcmap."
    exit 1
  }
else
  echo "rpcmap found no services to check!"
fi

exit $EXIT