### Devcontainer wizard

My personal bash file to create .devcontainer projects, based on my daily use of Docker.

## Prerequisites
Have [Gum](https://github.com/charmbracelet/gum) installed

## Notes
This is a personal script, so its only tested on Linux, can't really check if it works on mac...

## How to create new projects?
Clone and copy `vwizard` to `/usr/local/bin`

```sh
sudo cp vwizard /usr/local/bin/
```

Copy `.stub/` directory to same folder

```sh
sudo cp -R .stubs /usr/local/bin/
```

Give execute permission to `vwizard` 

```sh
sudo chmod +x /usr/local/bin/vwizard
```

That should do it, you can call it from anywhere by calling `vwizard`

## use with a know template?
sure we have the `vinit`

Clone and copy `vinit` to `/usr/local/bin`

```sh
sudo cp vinit /usr/local/bin/
```

Give execute permission to `vinit` 

```sh
sudo chmod +x /usr/local/bin/vinit
```

### use on directory
```sh
vinit --template=<template> --db=[mysql,pg,supabase]
```
only template is required


## How to convert existing directory?

Clone and copy `vmaker` to `/usr/local/bin`

```sh
sudo cp vmaker /usr/local/bin/
```

Copy `.stub/` directory to same folder

```sh
sudo cp -R .stubs /usr/local/bin/
```

Give execute permission to `vmaker` 

```sh
sudo chmod +x /usr/local/bin/maker
```

That should do it, you can call it from anywhere by calling `vmaker`
