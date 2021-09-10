# ![MiniShell](https://raw.githubusercontent.com/coconutteamdev/minishell/b5d8231b100e836203c59087ce0ce9ef06ed6c86/logo.svg)

## Welcome to MiniShell's Readme!
#### [MiniShell installation guide for complete beginners to Linux](https://github.com/coconutteamdev/minishell/wiki/Get-Started-with-MiniShell)


### Table of Contents 

1. [Features](https://github.com/coconutteamdev/minishell#features)

    a. [Planned features](https://github.com/coconutteamdev/minishell#planned-features)

1. [Setting up](https://github.com/coconutteamdev/minishell#setting-up)

    a. [Auto install](https://github.com/coconutteamdev/minishell#auto-install)

    b. [Manual install](https://github.com/coconutteamdev/minishell#manual-install)

2. [Troubleshooting](https://github.com/coconutteamdev/minishell#troubleshooting)

    a. [Missing all packages error](https://github.com/coconutteamdev/minishell#missing-all-packages-error)

    b. [Missing X packages error](https://github.com/coconutteamdev/minishell#missing-x-packages-error)


[![GitHub last commit](https://img.shields.io/github/last-commit/datkat21/minishell?style=flat-square)](https://github.com/coconutteamdev/minishell/commits/main)

[![GitHub release (latest by date)](https://img.shields.io/github/v/release/datkat21/minishell?style=flat-square)](https://github.com/coconutteamdev/minishell/releases)

MiniShell is a small "shell" made in Bash for fun.
You can type `help` for some commands.


# Features

- Command suggestions [[#3]](https://github.com/coconutteamdev/minishell/issues/3)

![img](https://raw.githubusercontent.com/coconutteamdev/minishell/main/assets/img/command_suggestions.png)

- Check for installed packages at startup [[#5]](https://github.com/coconutteamdev/minishell/issues/5)

![img](https://raw.githubusercontent.com/coconutteamdev/minishell/main/assets/img/missing1.png)

- Simple to use and colorful [[#4]](https://github.com/coconutteamdev/minishell/issues/4)


![img](https://raw.githubusercontent.com/coconutteamdev/minishell/main/assets/img/drawexample2.png)

## Planned features:
- Multiple arguments per command
- Colors in `draw`
- Support for [CoconutApp packages](https://github.com/coconutteamdev/coconutapp)
- Bug reporting inside the app (creates an issue link)
# Setting up
Git is required to clone the repo.
If you are new to Linux, or just want a simple setup, [check the wiki](https://github.com/coconutteamdev/minishell/wiki/Get-Started-with-MiniShell).
## Auto install
Soon. (coming in 1.2)
<!-- Clone the repo with Git:
```bash
git clone https://github.com/coconutteamdev/minishell && bash minishell/install.sh
```
This command above clones the repo and runs the installer if you have Bash installed. -->
## Manual install
Clone the repository, you need `git` .

```
git clone https://github.com/datkat21/minishell
```

Next, run the script.

```
bash minishell/assets/script/mini.sh
```

# Troubleshooting

(Note that `toilet` , `figlet` , and `dialog` are required for MiniShell to work.)

## Missing all packages error

If you get this during startup, 

```
[Warning] Dialog not found. Please install it!
[Warning] Figlet not found. Please install it!
[Warning] Toilet not found. Please install it!
[Error] Missing all required packages. Please check above.
``` 

please make sure you have `toilet` , `figlet` , and `dialog` installed.

On any distro that has the `apt` command, you can use this handy command to install them:

```
sudo apt install toilet figlet dialog
``` 

## Missing X packages error

If you get this error at startup:

```
[Warning] Missing 2 packages. Please check above.
``` 

check the text above and install those packages. If it says, for example, 

```
[Warning] Dialog not found. Please install it!
[Warning] Toilet not found. Please install it!
```

then you would install those packages using ex. `sudo apt install toilet dialog`

# Support

[![Discord](https://img.shields.io/discord/507735969731182592?style=flat-square)](https://discord.gg/KgQGXEGHDE)
