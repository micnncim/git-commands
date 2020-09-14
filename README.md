# Git Commands

[![license][license-badge]][license]

A collection of Git custom subcommands.

## Commands

### `git prune-branch`

Deletes all the merged branches.

```console
$ git prune-branch
==> Deleted branch 'test1'
==> Deleted branch 'test2'
```

## Installation

For example:

```bash
readonly commands=$(find commands -name '*.sh')

declare command_base
for command in $commands; do
  command_base=$(basename "${command}" '.sh')
  cp "${command}" "/usr/local/bin/${command_base}"
done
```

<!-- badge links -->

[license]: LICENSE
[license-badge]: https://img.shields.io/github/license/micnncim/git-commands?style=for-the-badge
