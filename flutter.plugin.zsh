# ----------------------
# Multiple handy terminal commands to use with Flutter!
# ----------------------

alias fd='flutter devices'
alias fpg='flutter packages get'
alias frb='flutter pub run build_runner build --delete-conflicting-outputs' # Auto generate files
alias frw='flutter pub run build_runner watch' # Auto generate files continuous
alias frl10n='flutter pub run intl_translation:extract_to_arb --output-dir=lib/foundation/locale lib/foundation/locale/locales.dart'
alias frtranslate='flutter pub run intl_translation:generate_from_arb --output-dir=lib/foundation/locale --generated-file-prefix=.g. --no-use-deferred-loading lib/foundation/locale/intl_en.arb lib/foundation/locale/intl_nl.arb lib/foundation/locale/intl_messages.arb lib/foundation/locale/locales.dart'

fra() {
  printf "⏳ Starting '%s"${PWD##*/}"' on following devices:\n"

  rawDevicesFile=$TMPDIR"fdOutput.txt"
  trap "rm $fdOutputLocation" EXIT

  devicesFile=$TMPDIR"devices.txt"
  trap "rm $deviceFile" EXIT

  fd > $rawDevicesFile | tail -n+3 > $devicesFile

  while read line; do
    echo $line | cut -d '•' -f1 | sed 's/^[ \t]*//;s/[ \t]*$//'
  done < $devicesFile

  open -a simulator
  flutter run -d all --flavor staging -t lib/main_staging.dart
}

# Get a list of connected devices and choose which one to run
# If only one simulator/emulator is present, run that one
fr() {
  rawDevicesFile=$TMPDIR"fdOutput.txt"
  trap "rm $fdOutputLocation" EXIT

  # Get the device list with original `flutter devices` command
  fd > $rawDevicesFile
  
  devicesCount=$(head -c 1 $rawDevicesFile)
  deviceId=
  
  if [ $devicesCount -eq 1 ] ; then
    deviceId=$(cat $rawDevicesFile | tail -1 | cut -d'•' -f 2 | tr -d '[:space:]')
  else
    devicesFile=$TMPDIR"devices.txt"
    trap "rm $devicesFile" EXIT
  
    cat $rawDevicesFile | tail -n+3 > $devicesFile

    echo "Which device do you want to run?"

    # Loop all lines in the file containing the devices and prepend a number
    n=1
    while read line; do 
      echo $n. $line
      n=$((n+1))
    done < $devicesFile

    # Read the user input and read the corresponding line in the file of devices
    printf 'Device number: '
    read tmp

    # Filter the deviceId from the chosen line
    device=$(head -$tmp $devicesFile | tail -1)
    deviceId=$(echo $device | cut -d '•' -f2 | tr -d '[:space:]')
    deviceName=$(echo $device | cut -d '•' -f1 | sed 's/^[ \t]*//;s/[ \t]*$//') # Remove leading and trailing whitespaces
  fi

  printf "⏳ Starting '%s"${PWD##*/}"' on $deviceName...\n"
  open -a simulator
  flutter run -d $deviceId --flavor staging -t lib/main_staging.dart
}

frp() {
  iosDeviceId=(fGetDeviceId ios)
  echo $iosDeviceId

}
## WIP Need to be translated from Fish to bash ##


# # Function to run a `--profile` build on all available physical devices
# # TODO: When iPhone device is found, Android device will not be triggered.
# function frp
#   # First try to run iOS device
#   set iosResult (fGetDeviceId ios)

#   if test -n "$iosResult"
#     echo "Starting iPhone build..."
#     flutter run --profile -d $iosResult --flavor production -t lib/main_production.dart
#   else
#     echo "No physical iPhone device found!"
#   end

#   # Secondly try to run Android device
#   set androidResult (fGetDeviceId android)

#   if test -n "$androidResult"
#     echo "Starting Android build..."
#     flutter run --profile -d $androidResult
#   else
#     echo "No physical Android device found!"
#   end
# end

# getDeviceId() { 
  # tmp=$TMPDIR"tmp.txt"
  # fd > $tmp
  
  # if [ $argv = ios ]; then
  #   # Lookup for physical iPhone device
  #   device=$(echo | grep -v "simulator" $tmp | grep ios)
  # else if [ $argv = android ]; then
  #   # Lookup for physical Android device
  #   device=$(echo | grep -v "emulator" $fileLocation | grep android)
  # fi

  # echo $device | cut -d'•' -f 2 | tr -d '[:space:]'
# }

# function fGetDeviceId
#   set fileLocation $TMPDIR/devices.txt
#   # Add all devices to a file
#   fd > $fileLocation
#   if [ $argv = ios ]
#     # Lookup for physical iPhone device
#     set device (grep -v "simulator" $fileLocation | grep ios)
#   else if [ $argv = android ]
#     # Lookup for physical Android device
#     set device (grep -v "emulator" $fileLocation | grep android)
#   end

#   echo $device | cut -d'•' -f 2 | tr -d '[:space:]'
# end
