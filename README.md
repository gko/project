# Project 

Create project locally and on github

![demo](https://github.com/gko/project/raw/master/demo.gif)

## Installation

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

### With [antigen](https://github.com/zsh-users/antigen)

In your .zshrc
```sh
antigen bundle gko/project
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

## License

[MIT](http://opensource.org/licenses/MIT)

Copyright (c) 2012-2017 Konstantin Gorodinskiy
