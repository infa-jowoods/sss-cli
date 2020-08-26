#!/bin/zsh

echo "[Installing Shamir sharding tool]";
echo "Checking for Homebrew package manager...";
if [[ $(command -v brew) == "" ]]; then
    echo "Homebrew not found, installing Homebrew...";
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
else
    echo "Homebrew found, continuing...";
fi
echo "Checking for Rust toolchain...";
if [[ $(command -v cargo) == "" ]]; then
    echo "Rust toolchain not found, installing Rust...";
    brew install rust;
else
    echo "Rust found, continuing...";
fi
echo "[Building SSS binaries, libraries & bindings]";
cargo install --git https://github.com/infa-jowoods/sss-cli --branch v0.1;
echo "Installing symbolic links to Rust binaries...";
ln -s $HOME/.cargo/bin/secret-share-split /usr/local/bin/sss;
ln -s $HOME/.cargo/bin/secret-share-combine /usr/local/bin/ssc;
clear;
echo "[Installation of Shamir sharding tool completed]\n";
echo "[Example usage requiring 5 shares, with a reconstruction threshold of 4]:";
echo "echo \"someSecretString\" | sss -n 5 -t 4 > ./shares.list\n\n";
echo "[Example share reconstruction needing only 4 of 5 shares]:";
echo "head -n 4 ./shares.list | ssc\n\n";
echo "[Shamir sharding tool also works with stdin/out]";
echo "[Uninstallation procedure]:";
echo "\"cargo uninstall shamirsecretsharing-cli\"";
echo "\"rm /usr/local/bin/sss; rm /usr/local/bin/ssc;\"";
echo "[Done]";
