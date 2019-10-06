# (WIP) Shortcuts to quickly start Flutter project on simulators/emulators

This little script is to be used with `zsh`.

## How to install
Open terminal and paste the following line.

`git clone https://github.com/Schroefdop/flutterShortcuts.git ~/.oh-my-zsh/custom/plugins/flutter`

After cloning is done, add the plugin to you `.zshrc` file.
1. `vim ~/.zshrc`
2. Add `flutter` to the plugins
3. Save and quit
4. Restart terminal

## How to use
There are some aliases which shorten some of the longer Flutter commands
```
alias fd='flutter devices'
alias fpg='flutter packages get'
alias frb='flutter pub run build_runner build --delete-conflicting-outputs' # Auto generate files
alias frw='flutter pub run build_runner watch' # Auto generate files continuous
alias frl10n='flutter pub run intl_translation:extract_to_arb --output-dir=lib/foundation/locale lib/foundation/locale/locales.dart'
alias frtranslate='flutter pub run intl_translation:generate_from_arb --output-dir=lib/foundation/locale --generated-file-prefix=.g. --no-use-deferred-loading lib/foundation/locale/intl_en.arb lib/foundation/locale/intl_nl.arb lib/foundation/locale/intl_messages.arb lib/foundation/locale/locales.dart'
```

The command `fra`, short for `flutter run all` will build and launch the application on all booted simulators/emulators.

The command `fr`, short for `flutter run` lets you choose on which device you want to build and launch your application. When only one simulator/emulator is active, it will build and launch on this one.
