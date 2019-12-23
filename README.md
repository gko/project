# Project

Create `npm`, `cargo`, `gem` or `pip` project locally and on `github`.

![demo](https://github.com/gko/project/raw/master/demo.png)

After project init you will be prompted to create a `github` repo (private or public).

![github](https://github.com/gko/project/raw/master/github.png)

If the project exist you will just `cd` into its folder.

Supports `zsh-autocomplete`. On <kbd>Tab</kbd> will show the list of available projects.

You can also alias it (in `~/.zshrc` or `~/.bashrc`):
```shell
alias p='project'
```

to get:
```shell
p test-project
```

## Installation

### With [antigen](https://github.com/zsh-users/antigen)

In your .zshrc
```sh
antigen bundle gko/project
```

### Manually

You will need to install [hub](https://github.com/github/hub) to use it.
Then you need to clone repo:

```bash
git clone --recursive --depth 1 https://github.com/gko/project
```
then add it to .bashrc or .zshrc:
```bash
source ./project/project.sh
```

## Usage
```
Usage: project [options]
Example:
  project -p test
Options:
  -h, --help      help
  -p, --private   create private github repository
  -f, --folder    your projects folder(defaults to ~/projects)
  -n, --no-init   avoid initializing package
```

then to create public repo:
```bash
project test
```

create private repo:
```bash
project -p test
```

if project already exists it will only switch to its folder

### Projects path

You can specify projects path by either `-f` key or `$PROJECTS_HOME` variable:
```bash
project -f /projects_path
```
or
```bash
export PROJECTS_HOME=/projects_path
```
Otherwise default path is `~/projects`

## License

[MIT](http://opensource.org/licenses/MIT)

Copyright (c) 2012-2017 Konstantin Gorodinskiy
