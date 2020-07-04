# How to use Resume?

## Install Yarn

```sh
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb http://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn
```

## Path Setup

You will need to set up the PATH environment variable in your terminal to have access to Yarn’s binaries globally.

Add export PATH="$PATH:`yarn global bin`" to your profile (this may be in your .profile, .bashrc, .zshrc, etc.)

Yarn: <https://yarnpkg.com/en/docs/install>

## Installing and Running

```sh
# Install Node Modules
yarn

# Start the App
yarn start
