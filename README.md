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

### `git delete-squash-merged-branch`

Deletes the squash-merged branches with inquiries.

```console
$ git delete-squash-merged-branch
>>> Are you sure to delete branch 'test1'? [Y/n] Y
==> Deleted branch 'test1'
>>> Are you sure to delete branch 'test2'? [Y/n] Y
==> Deleted branch 'test2'
```

## License

Copyright &copy; 2020 micnncim All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.

You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0.

<!-- badge links -->

[license]: LICENSE
[license-badge]: https://img.shields.io/github/license/micnncim/git-commands?style=for-the-badge
