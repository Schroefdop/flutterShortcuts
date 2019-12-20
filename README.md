# Shortcuts to quickly start Flutter project on simulators/emulators

This `oh-my-zsh` plugin add shortcuts for Flutter to your terminal

## How to install

### Prerequisites
1. `zsh`
2. [`oh-my-zsh`](https://github.com/robbyrussell/oh-my-zsh)

### Installation
Open terminal and paste the following lines. This will clone the repository to the right location, add `flutter` to the plugins located in `~/.zshrc` and restart your shell.

```
git clone https://github.com/Schroefdop/flutterShortcuts.git ~/.oh-my-zsh/custom/plugins/flutter
while read line; do; if [[ $line == plugins* ]]; then; sed -i -e 's/plugins=(/plugins=(flutter /g' ~/.zshrc; fi;  done < ~/.zshrc
exec zsh
```

## Configuration

For now there are two variables to configure.
```
FLUTTER_FLAVOR_NAME="staging"
FLUTTER_START_FILE="lib/main_staging.dart"
```

These variables should be set in `~/.zshrc`.
If these variables are not set, vanilla `flutter run -d <deviceId>` will run.

## How to use
There are some aliases which shorten some of the longer Flutter commands
```
alias fa='flutter analyze'
alias fd='flutter devices'
alias fpg='flutter packages get'
alias frb='flutter pub run build_runner build --delete-conflicting-outputs' # Auto generate files
alias frw='flutter pub run build_runner watch' # Auto generate files continuous
```

The command `fra`, short for `flutter run all` will build and launch the application on all booted simulators/emulators.

The command `fr`, short for `flutter run` lets you choose on which device you want to build and launch your application. When only one simulator/emulator is active, it will build and launch on this one.
