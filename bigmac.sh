#!/bin/sh

#  sudo ./preinstall.sh
#  BigMac MacPro pre-install tool v0.0.12
#  Created by StarPlayrX on 10.17.2020

#AutoSwitch to current directory'
dir=$(dirname "$0")
cd "$dir"

if [ "$EUID" -ne 0 ]
  then
    echo
    echo "Please run with sudo!"
    echo
    exit 0
fi

bigmac=$(pwd)
macpro=$(sysctl hw.model)

if [[ "$macpro" != *"MacPro"* ]]
  then
    echo
    echo "Please run Big Mac on a Mac Pro."
    echo
    exit 0
fi

printf '\e[48;5;0m\e[K'
printf '\e[K'
printf "\n[38;5;172m—————————————————————————————–—————————————————————————————————————————————————"
printf '\e[K'
printf "\n[38;5;112m🥤 Big Sur Downloader 🍟 Big Sur USB Installer 🍔 bigmac on separate partition"
printf '\e[K'
printf "\n[38;5;172m—————————————————————————————–—————————————————————————————————————————————————"
printf '\e[K'
printf "\r\n[38;5;112m"
printf '\e[K'
printf "[38;5;112m"
printf '\e[K'
printf '\n\e[K'
printf '\e[K'
read -p "📦 Would you like to download Big Sur macOS 11.0.1 (20B29)? [y]: " install
printf '\e[K'

if [[ "$install" == *"y"* ]]
    then
        printf '\e[K'
        echo
        printf '\e[K'
        
            mark="12885258087"
            printf 'Evalulating Base System checksum...'
            checksum=$(stat ~/Downloads/InstallAssistant.pkg | awk '$2')
            echo $checksum
            if [ $checksum != $mark ]
                then
                    echo "REDOWNLOAD"
                    #rm -Rf $(pwd)/💿/BaseSystem.dmg
                    #curl https://starplayrx.com/downloads/BaseSystem.dmg -o "$(pwd)/💿/BaseSystem.dmg"
                    else
                    printf " Download Complete."
            fi
            
        exit
        ##rm -Rf ~/Downloads/InstallAssistant.pkg
        curl http://swcdn.apple.com/content/downloads/50/49/001-79699-A_93OMDU5KFG/dkjnjkq9eax1n2wpf8rik5agns2z43ikqu/InstallAssistant.pkg -o ~/Downloads/InstallAssistant.pkg
        printf '\e[K'
        echo
        printf '\e[K'
        echo 'Installing the Install macOS Big Sur.app via InstallAssistant.pkg'
        sudo installer -pkg ~/Downloads/InstallAssistant.pkg -target /
fi
    printf '\e[K'
    echo
    printf '\e[K'
    
read -p "🍦 Would you like to create a USB Installer, excluding thumb drives [y]: " create
    printf '\e[K'
    echo
    printf '\e[K'
    #sudo wc $(which sudo) | awk '{printf $3}'
    
    mark="12885257767"
    printf 'Evalulating Base System checksum...'
    checksum=$(stat "$(pwd)/💿/BaseSystem.dmg" | awk '{printf $2}')
    if [ $checksum != $mark ]
        then
            echo "REDOWNLOAD"
            rm -Rf $(pwd)/💿/BaseSystem.dmg
            curl https://starplayrx.com/downloads/BaseSystem.dmg -o $(pwd)/💿/BaseSystem.dmg
            else
            printf " Download Complete."
    fi

  
  exit
while [ ! -d "/Applications/Install macOS Big Sur.app" ] && [[ "$create" == *"y"* ]]

do
    if [ ! -d "/Applications/Install macOS Big Sur.app" ] && [[ "$create" == *"y"* ]]
        then
            printf '\e[K'
            read -p "🤯 Please place the Install macOS Big Sur.app in your 🍎 Applications 📂 Folder and press Return: " install
            printf '\e[K'

    fi
done

disk=""
media=""
volumes="/Volumes/"


if [[ "$create" == *"y"* ]]
    then
        while [[ "$media" != *"$volumes"* ]] || [[ "$disk" != *"disk"* ]]
            do
                if [[ "$media" != *"$volumes"* ]] || [[ "$disk" != *"disk"* ]]
              then
                printf '\e[K'
                read -p "💾 Please Format using Disk Utility
   to Mac OS Extended (Journaled)
   Drag your External Disk here -> " media
                printf '\e[K'
                disk=$(diskutil info "$media" | grep 'Part of Whole:' | sed 's/^.\{30\}//')
                
                echo
                printf '\e[K'
                echo "🔍 Detected Whole disk: "$disk
                printf '\e[K'
    
                number=$RANDOM
                
                disk="$disk"
                
                ##echo '🧻 Wiping clean the USB disk your missing toilet paper.'
                ##printf '\e[K'
                ##echo
                ##printf '\e[K'
                ##diskutil erasedisk jhfs+ bmo "$disk"
                
                echo
                printf '\e[K'
                
                echo '🍩 Paritioning the drive with bigmac and install volumes.'
                printf '\e[K'
                echo
                printf '\e[K'
                sudo diskutil partitionDisk "$disk" GPT jhfs+ bigmac_"$disk$number" 1g jhfs+ installer_"$disk$number" 16g jhfs+ clone 0
                
                echo
                printf '\e[K'
                echo 🍟 Copying bigmac patcher to volume: bigmac_"$disk$number"
                echo
                printf '\e[K'
                
                
                if [ -d /Volumes/bigmac_"$disk$number" ] && [ -d $bigmac ]
                    then
                        sudo ditto -v $bigmac /Volumes/bigmac_"$disk$number"
                    else
                    echo "We can't find the destination or source disk for bigmac. Exiting"
                    exit 0
                fi
                
                echo
                printf '\e[K'
                echo 🍔 Renaming bigmac_"$disk$number" volume to bigmac
                echo
                printf '\e[K'
                diskutil rename bigmac_"$disk$number" bigmac
                
                echo
                printf '\e[K'
                echo 🤠 Creating bootable installer using volume: installer_"$disk$number"
                
                printf '\e[K'
                echo
                sudo /Applications/'Install macOS Big Sur.app'/Contents/Resources/createinstallmedia --nointeraction --volume /Volumes/installer_"$disk$number"

                bootplist="com.apple.Boot.plist"
                boot="/💾/"
                printf '\e[K'
                echo "Boot.plist -v -no_compat_check to USB Installer"
                printf '\e[K'
                systemconfig="/Volumes/Install macOS Big Sur/Library/Preferences/SystemConfiguration/"
                bootdisk=$(pwd)$boot
                base="base/"
                
                if [ -d "$bootdisk$base" ] && [ -d "$systemconfig" ]
                    then
                        printf '\e[K'
                        echo "$bootdisk$base$bootplist"
                        printf '\e[K'
                        echo "$systemconfig$bootplist"
                        printf '\e[K'
                        rm -Rf "$systemconfig$bootplist"
                        sudo ditto -v "$bootdisk$base$bootplist" "$systemconfig$bootplist"
                    else
                        printf '\e[K'
                        echo "$bootdisk$base$bootplist"
                        printf '\e[K'
                        echo "$systemconfig$bootplist"
                        printf '\e[K'
                    echo "We are not able to write to the Boot.plist file on Installer macOS Big Sur because it's missing."
                    printf '\e[K'
                    exit 0
                fi
                
                chown -R 0:0 "$systemconfig$bootplist"
                chmod -R 755 "$systemconfig$bootplist"
                printf '\e[K'
                echo
                printf '\e[K'
                ##echo "☠️  Renaming Install macOS Big Sur volume to BigMac11USB"
                ##diskutil rename "Install macOS Big Sur" "BigMac11USB"
                ##printf '\e[K'
            fi
        done
fi

printf '\e[K'
printf "[38;5;172m———————————————————————————————–———————————————————————————————————————————\n"
printf '\e[K'
printf "[38;5;112m Reboot -> HOLD Down OPTION Key -> Select macOS Big Sur Installer\n"
printf '\e[K'
printf "[38;5;112m Open Terminal and Type 'cd /Volumes/bigmac; ./preinstall.sh'\n"
printf '\e[K'
printf "[38;5;172m———————————————————————————————–———————————————————————————————————————————\n"
printf '\e[K'
printf "[38;5;112m Quit Terminal. Open the Installer App from the Window. Wait for 3 reboots.\n"
printf '\e[K'
printf "[38;5;172m———————————————————————————————–———————————————————————————————————————————\n"
printf '\e[K'
printf "[38;5;112m Reboot -> HOLD Down OPTION Key -> Select macOS Big Sur Installer\n"
printf '\e[K'
printf "[38;5;112m Open Terminal and Type 'cd /Volumes/bigmac; ./postinstall.sh'\n"
printf '\e[K'
printf "[38;5;172m———————————————————————————————–———————————————————————————————————————————\n"
printf '\e[K'
printf "[38;5;112m"
printf '\e[K'
echo
printf '\e[K'
echo "🍟 HappyMeal Partition has FREE SPACE on it!"
printf '\e[K'
echo
printf '\e[K'
printf '\e[K'; echo "💰 Tips via PayPal are accepted here: https://tinyurl.com/y2dsjtq3"; printf '\e[K'
printf '\e[K'
echo
printf '\e[K'
