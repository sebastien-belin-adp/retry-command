# retry-command

[![GitHub tag](https://img.shields.io/github/tag/sebastien-belin-adp/retry-command.svg)](https://github.com/sebastien-belin-adp/retry-command/tags) ![license](https://img.shields.io/github/license/sebastien-belin-adp/retry-command.svg)

A simple Gihub action that retry a simple command if it fails. This is intended to replace the run step for single line bash commands.

It is designed for a single purpose, running gradle commands, and hasn't been tested with too many bash commands. 

# Inputs

## command

The single like bash command to run

## max_retries

The Maximum number of retries to make before failing the step. Defaults to 3.

## retry_wait

The number of seconds to wait before the next retry. Defaults to 5.

# Example

## Simple

```yaml
name: Run command
uses: sebastien-belin-adp/retry-command@main
  with:
    command: ./gradlew check
    max_retries: 3
    retry_wait: 10
```

## With environment variables

```yaml
name: Run command
uses: sebastien-belin-adp/retry-command@main
  with:
    command: ./gradlew check
    max_retries: 3
    retry_wait: 10
  env:
    VAR_NAME: varValue
```
