#!/usr/bin/bash

PKG_NAME=$(grep 'name' typst.toml | cut -d'"' -f2)
PKG_VERSION=$(grep 'version' typst.toml | cut -d'"' -f2)
TYPST_PKG_DEST=$HOME/.local/share/typst/packages/local/${PKG_NAME}/${PKG_VERSION}

FONT_DIR=$HOME/.local/share/fonts
# Font mapping dictionary
declare -A FONT_NAMES=(
    ["text"]="Poppins"
    ["math"]="Libertinus"
    ["code"]="Geist Mono"
)

print_phase() {
    pkg=$1
    phase=$2
    printf '\033[34m==>\033[0m %s: Executing phase `%s`\n' $pkg $phase
}

install_package() {
    # Check if package is already installed
    if [ -d "$TYPST_PKG_DEST" ]; then
        printf '\033[1;32m[+]\033[0m package already installed (%s-%s)\n' $PKG_NAME $PKG_VERSION
        read -p "replace? [y/N]: " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            return
        fi
        rm -rf "$TYPST_PKG_DEST"
    fi

    printf '\033[1;34m==>\033[0;1m Installing local Typst package `\033[32m%s-%s\033[0m`\n' $PKG_NAME $PKG_VERSION

    print_phase "$PKG_NAME" "prepare"
    mkdir -p $TYPST_PKG_DEST

    print_phase "$PKG_NAME" "install"
    cp -r src/ assets/ template/ typst.toml LICENSE README.md $TYPST_PKG_DEST

    printf '\033[1;32m[+]\033[0m %s\n' $TYPST_PKG_DEST
}

install_font() {
    local font_type=$1
    # Check if font type is valid
    if [[ ! -v FONT_NAMES[$font_type] ]]; then
        printf '\033[1;31m==>\033[0m Error: unknown font type `%s` (available options: `text`, `math`, `code`)\n' $font_type
        return 1
    fi

    local font_name="${FONT_NAMES[$font_type]}"
    # Check if font is already installed
    if typst fonts | grep -qF "${font_name}"; then
        printf '\033[1;32m[+]\033[0m %s font already installed (%s)\n' $font_type "${font_name}"
        read -p "install anyway? [y/N]: " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            return
        fi
    fi

    printf '\033[1;34m==>\033[0;1m Installing %s font `\033[32m%s\033[0m`\n' $font_type $font_name

    print_phase "$font_name" "prepare"
    mkdir -p $FONT_DIR
    
    print_phase "$font_name" "install"
    case $font_type in
        text)
            unzip -qq ./fonts/poppins.zip -d $FONT_DIR
            ;;
        math)
            unzip -qq ./fonts/libertinus-math.zip -d $FONT_DIR
            ;;
        code)
            unzip -qq ./fonts/geist-mono.zip -d $FONT_DIR
            ;;
    esac

    print_phase "$font_name" "cache"
    fc-cache -Ef "$font_dest/$font_name"

    printf '\033[1;32m[+]\033[0m %s/%s\n' $FONT_DIR $font_name
}

# Parse command line arguments
FONT_TYPES=""
for arg in "$@"; do
    case $arg in
        --with-fonts=*)
            FONT_TYPES="${arg#*=}"
            shift
            ;;
        *)
            # Unknown option
            ;;
    esac
done

install_package

# Install fonts if requested
if [ -n "$FONT_TYPES" ]; then
    IFS=',' read -ra FONT_ARRAY <<< "$FONT_TYPES"
    for font_type in "${FONT_ARRAY[@]}"; do
        install_font "$font_type"
    done
fi
