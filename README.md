# Create project locally and on github

## Installation

You will need to install [hub](https://github.com/github/hub) to use it.
Then you need to clone repo:
```bash
git clone --depth 1 https://github.com/gko/project
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

Add it to .bashrc or .zshrc:
```bash
source ./project/project.sh
```
then to create public repo:
```bash
project test
```

create private repo:
```bash
project -p test
```

## License

[MIT](http://opensource.org/licenses/MIT)

Copyright (c) 2012-2017 Konstantin Gorodinskiy
