# Function to check for available updates using paru
check_updates() {
    # Update the package database and check for updates
    paru -Sy --noconfirm --quiet
    # List upgradable packages and count the number of lines
    paru -Qu 2>/dev/null | wc -l
}

# Call the function and print the result
updates=$(check_updates)

echo "$updates" > ~/.config/rofi/scripts/n_updates.tmp
