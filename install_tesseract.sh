#!/usr/bin/env bash

echo "Installation Script for Tesseract"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
        echo "Begining to install Tesseract package"
        sudo apt-get install tesseract-ocr
        which -s pip
        if [[ $? != 0 ]] ; then
          echo "Installing Pip"
          sudo easy_install pip
        else
          echo "Pip Detected"
        fi
        pip install pytesseract
elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
        # Check for Homebrew,
        # Install if we don't have it
        if test ! $(which brew); then
          echo "Installing homebrew..."
          ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        fi
        # Ensure `homebrew` is up-to-date and ready
        echo "Updating homebrew..."
        brew doctor

        # Ensure the Homebrew cache directory exists
        mkdir ~/Library/Caches/Homebrew

        # Install leptonica with TIFF support (and every other format, just in case)
        echo "Installing leptonica..."
        brew install --with-libtiff --with-openjpeg --with-giflib leptonica

        # Install Ghostscript
        echo "Installing ghostscript..."
        brew install gs

        # Install ImageMagick with TIFF and Ghostscript support
        echo "Installing imagemagick..."
        brew install --with-libtiff --with-ghostscript imagemagick

        # Install Tesseract devel with all languages
        echo "Installing tesseract..."
        brew install tesseract --all-languages
else
        # Unknown.
        echo "This script supports only POSIX, LINUX, MacOS"
        echo "Exiting script"
        exit 1
fi