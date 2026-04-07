#!/bin/bash
# create personalized wallpapers for milanY
# "Down with Big Brother" channel theme

# colors
BLACK="#0a0a0f"
WHITE="#f0f0f5"
PURPLE="#9b59b6"
BLUE="#3498db"
RED="#e74c3c"

# create main wallpaper
create_main_wallpaper() {
    echo "creating main wallpaper..."
    
    # create 1920x1080 wallpaper with imagemagick
    convert -size 1920x1080 xc:"$BLACK" \
        -font "Arial-Bold" -pointsize 72 -fill "$WHITE" -gravity center \
        -annotate +0-100 "milanY" \
        -font "Arial" -pointsize 32 -fill "$BLUE" -gravity center \
        -annotate +0+0 "Down with Big Brother" \
        -font "Arial" -pointsize 24 -fill "$PURPLE" -gravity center \
        -annotate +0+50 "Privacy Focused Linux" \
        /usr/share/milany/wallpapers/milany-main.png
    
    echo "main wallpaper created"
}

# create grid wallpaper
create_grid_wallpaper() {
    echo "creating grid wallpaper..."
    
    # create grid pattern
    convert -size 1920x1080 xc:"$BLACK" \
        -stroke "$PURPLE" -strokewidth 1 \
        -draw "line 0,540 1920,540" \
        -draw "line 960,0 960,1080" \
        -draw "line 0,270 1920,270" \
        -draw "line 0,810 1920,810" \
        -draw "line 480,0 480,1080" \
        -draw "line 1440,0 1440,1080" \
        -font "Arial-Bold" -pointsize 48 -fill "$WHITE" -gravity center \
        -annotate +0-200 "milanY" \
        -font "Arial" -pointsize 20 -fill "$BLUE" -gravity center \
        -annotate +0+200 "Down with Big Brother" \
        /usr/share/milany/wallpapers/milany-grid.png
    
    echo "grid wallpaper created"
}

# create minimal wallpaper
create_minimal_wallpaper() {
    echo "creating minimal wallpaper..."
    
    convert -size 1920x1080 xc:"$BLACK" \
        -font "Arial-Bold" -pointsize 64 -fill "$PURPLE" -gravity center \
        -annotate +0-50 "milanY" \
        -font "Arial" -pointsize 18 -fill "$WHITE" -gravity center \
        -annotate +0+20 "Privacy • Security • Freedom" \
        /usr/share/milany/wallpapers/milany-minimal.png
    
    echo "minimal wallpaper created"
}

# create orwell themed wallpaper
create_orwell_wallpaper() {
    echo "creating orwell themed wallpaper..."
    
    convert -size 1920x1080 xc:"$BLACK" \
        -font "Arial" -pointsize 14 -fill "$GRAY" -gravity northwest \
        -annotate +20+20 "DOWN WITH BIG BROTHER" \
        -annotate +20+50 "DOWN WITH BIG BROTHER" \
        -annotate +20+80 "DOWN WITH BIG BROTHER" \
        -annotate +20+110 "DOWN WITH BIG BROTHER" \
        -annotate +20+140 "DOWN WITH BIG BROTHER" \
        -font "Arial-Bold" -pointsize 48 -fill "$RED" -gravity center \
        -annotate +0+0 "milanY" \
        -font "Arial" -pointsize 16 -fill "$WHITE" -gravity south \
        -annotate +0+30 "1984 was not supposed to be an instruction manual" \
        /usr/share/milany/wallpapers/milany-orwell.png
    
    echo "orwell wallpaper created"
}

# create terminal style wallpaper
create_terminal_wallpaper() {
    echo "creating terminal style wallpaper..."
    
    # create terminal-like appearance
    convert -size 1920x1080 xc:"$BLACK" \
        -font "Courier" -pointsize 12 -fill "$GREEN" -gravity northwest \
        -annotate +20+20 "milanY linux v1.0.0" \
        -annotate +20+50 "kernel: privacy hardened" \
        -annotate +20+80 "tor: active" \
        -annotate +20+110 "dnscrypt: active" \
        -annotate +20+140 "firewall: enabled" \
        -font "Arial-Bold" -pointsize 36 -fill "$PURPLE" -gravity center \
        -annotate +0+0 "milanY" \
        -font "Arial" -pointsize 14 -fill "$BLUE" -gravity south \
        -annotate +0+30 "Down with Big Brother" \
        /usr/share/milany/wallpapers/milany-terminal.png
    
    echo "terminal wallpaper created"
}

# create cyberpunk wallpaper
create_cyberpunk_wallpaper() {
    echo "creating cyberpunk wallpaper..."
    
    # create gradient background
    convert -size 1920x1080 gradient:"$BLACK-$PURPLE" \
        -font "Arial-Bold" -pointsize 72 -fill "$WHITE" -gravity center \
        -annotate +0-100 "milanY" \
        -font "Arial" -pointsize 24 -fill "$CYAN" -gravity center \
        -annotate +0+0 "PRIVACY IS A FUNDAMENTAL RIGHT" \
        -font "Arial" -pointsize 18 -fill "$BLUE" -gravity center \
        -annotate +0+40 "Down with Big Brother" \
        /usr/share/milany/wallpapers/milany-cyberpunk.png
    
    echo "cyberpunk wallpaper created"
}

# main execution
main() {
    echo "creating milanY wallpapers..."
    
    # create wallpaper directory
    mkdir -p /usr/share/milany/wallpapers
    
    # create all wallpapers
    create_main_wallpaper
    create_grid_wallpaper
    create_minimal_wallpaper
    create_orwell_wallpaper
    create_terminal_wallpaper
    create_cyberpunk_wallpaper
    
    echo "all wallpapers created successfully"
    echo "wallpapers saved to /usr/share/milany/wallpapers/"
    
    # list created wallpapers
    echo ""
    echo "created wallpapers:"
    ls -la /usr/share/milany/wallpapers/*.png
}

# run main function
main "$@"
