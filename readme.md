# ![MiniShell](https://raw.githubusercontent.com/coconutteamdev/minishell/b5d8231b100e836203c59087ce0ce9ef06ed6c86/logo.svg)

![GitHub last commit](https://img.shields.io/github/last-commit/datkat21/minishell?style=flat-square)

[![GitHub release (latest by date)](https://img.shields.io/github/v/release/datkat21/minishell?style=flat-square)](https://github.com/coconutteamdev/minishell/releases)

MiniShell is a small "shell" made in Bash for fun.
You can type `help` for some commands.

## Setting up

Clone the repository, you need `git` .

```
git clone https://github.com/datkat21/minishell
```

Next, run the script.

```
bash minishell/mini.sh
```

## Troubleshooting

(Note that `toilet` , `figlet` , and `dialog` are required for MiniShell to work.)

### Missing all packages error

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

### Missing X packages error

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
