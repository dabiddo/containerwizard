### Devcontainer wizard

My personal bash file to create .devcontainer projects, based on my daily use of Docker.

## Prerequisites
Have [Gum](https://github.com/charmbracelet/gum) installed

## Notes
This is a personal script, so its only tested on Linux, can't really check if it works on mac...

## How to use?
Clone and copy `vwizard` to `/usr/local/bin`

```sh
sudo cp vwizard /usr/local/bin/
```

Copy `.stub/` directory to same folder

```sh
sudo cp -R .stub /usr/local/bin/
```

Give execute permission to `vwizard` 

```sh
sudo chmod +x /usr/local/bin/vwizard
```

That should do it, you can call it from anywhere by calling `vwizard

