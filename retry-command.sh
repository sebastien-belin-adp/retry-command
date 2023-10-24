#!/bin/bash

max_retries=$1
retry_wait=$2
command=$3

retry() {
  local retries=$1
  local wait=$2
  local cmd="$3"
  local currentRetry="${4:-1}" # 4th arg or default value '1'

  echo "::notice ::Running command '$cmd'"

  # Disable set -e
  set +e

  # Run the command and keep the exit code
  $cmd          
  local exit_code=$?

  # Restore set -e
  set -e

  # If the exit code is a non-zero value (i.e. command failed), and we have not
  # reached the maximum number of retries, run the command again
  if [[ $exit_code -ne 0 && $retries -gt 0 ]]; then
    echo "::warning ::Attempt $(($currentRetry)) failed. Exit code: $exit_code"

    # Wait before attending a retry
    echo "::notice ::Wait ${wait}s before retrying command"
    sleep $wait

    echo "::notice ::Retry command for the $(($currentRetry + 1)) time(s)"
    retry $(($retries - 1)) $wait "$cmd" $(($currentRetry + 1))
  else
    # Return the exit code from the command
    return $exit_code
  fi
}

echo "::notice ::Running retry-command with command: '$command', max_retries: $max_retries, retry_wait: $retry_wait"
retry $max_retries $retry_wait "$command"
