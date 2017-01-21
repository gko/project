# Create project locally and on github

## Installation

You will need to install hub to use it.
Then you need to clone repo:
```bash
git clone --depth 1 https://github.com/gko/project
```

## Usage

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
