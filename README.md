# cea-slides

**cea-slides** is a [Touying][touying] theme for crafting [Typst][typst] presentations in accordance with the corporate identity of the [French Atomic Energy and Alternative Energies Commission (CEA)][cea].

Please be aware that it is an **unofficial** theme not endorsed by the CEA, and may not fully adhere to the design specifications.


## Installation

### 1. Obtain the template

Download from GitHub:
```sh
git clone https://github.com/dssgabriel/cea-slides.git
```

### 2. Install the package

Prefer using the provided installation script:
```sh
./install.sh
```

If prefer to do it manually:
```sh
dest=$HOME/.local/share/typst/packages/$(grep 'name' typst.toml | cut -d'"' -f2)/$(grep 'version' typst.toml | cut -d'"' -f2)
mkdir -p $dest
cp -r src/ assets/ template/ typst.toml LICENSE README.md $dest
```

### 3. Use the theme

Once installed, the package can be imported into your project using the following statement:
```typ
#import "@local/cea-slides:0.1.0": *
```

Alternatively, you can directly start a new project using the provided template:
```sh
typst init @local/cea-slides:0.1.0 <PROJECT_PATH>
```

For more information on local package installation, please refer to the [dedicated Typst documentation][typst-pkg-doc].


## Fonts

This project also (re)distributes the fonts used by the package under the Open Font License (OFL v1.1):
- Poppins (text font), the official typeface of the CEA corporate identity;
- Libertinus (math font), the typeface used for equations (Typst's default);
- Geist Mono (code font), the typeface used for raw text/code blocks.

Install using the provided script:
```bash
./install.sh --with-fonts={text,math,code}
```

Or manually (for e.g., Poppins):
```bash
mkdir -p $HOME/.local/share/fonts
unzip fonts/poppins.zip -d $HOME/.local/share/fonts
# IMPORTANT: Reload font cache
fc-cache -f $HOME/.local/share/fonts
```

You can validate that Typst correctly detects the installed fonts using the following command:
```bash
typst fonts | grep <FONT_NAME>
```

Alternatively, you can obtain these fonts directly from the official repositories:
- [Poppins](https://github.com/itfoundry/Poppins)
- [Libertinus](https://github.com/alerque/libertinus)
- [Geist](https://github.com/vercel/geist-font)

[cea]: https://www.cea.fr/
[touying]: https://typst.app/universe/package/touying/
[typst]: https://typst.app/
[typst-pkg-doc]: https://github.com/typst/packages?tab=readme-ov-file#local-packages
