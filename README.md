# tex-filetypes.nvim

<!-- panvimdoc-ignore-start -->

> A Neovim filetype plugin for TeX-related files

<!-- panvimdoc-ignore-end -->

## Features

- Improved support for existing filetypes, especially `tex`.
- Additional filetypes for several TeX-related file formats.

## Installation

### With [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "teatimeguest/tex-filetypes.nvim",
  config = true,
  event = { "BufReadPre", "BufNewFile" },
}
```

### With [mini.deps](https://github.com/echasnovski/mini.deps)

```lua
add("teatimeguest/tex-filetypes.nvim")
```

## Improvements

### `tex`

- Improved versions of `include` and `includeexpr` are provided.

### `lua`

<!-- panvimdoc-include-comment ```vimdoc
                                              *tex-filetypes.nvim-b:is_texlua*
``` -->

- The plugin sets `b:is_texlua` to `v:true`
  if the file is considered to be for `texlua`.
  This can be used to change the behavior only for tex-related lua files.

## Extra Filetypes

The plugin provides support for the following file formats:

<!-- panvimdoc-ignore-start -->

| Filetype         | Language                                                          | <sup>[Syntax]<sup> | <sup>[Indent]<sup> |  <sup>[Fold]<sup>  | <sup>[Comments]<sup> | <sup>[Include]<sup> | <sup>[Define]</sup> |
| ---------------- | ----------------------------------------------------------------- | :----------------: | :----------------: | :----------------: | :------------------: | :-----------------: | :-----------------: |
| `bibtoolrsc`     | [BibTool] resource file                                           | :white_check_mark: | :white_check_mark: | :heavy_minus_sign: |  :white_check_mark:  | :heavy_minus_sign:  | :heavy_minus_sign:  |
| `chktexrc`       | [ChkTeX] config file                                              | :white_check_mark: | :heavy_minus_sign: | :white_check_mark: |  :white_check_mark:  | :heavy_minus_sign:  | :heavy_minus_sign:  |
| `dependstxt`     | TeX Live's [`DEPENDS.txt`] format                                 | :white_check_mark: | :heavy_minus_sign: | :white_check_mark: |  :white_check_mark:  | :heavy_minus_sign:  | :heavy_minus_sign:  |
| `fontmap`        | TeX [fontmap file]                                                | :white_check_mark: | :heavy_minus_sign: | :heavy_minus_sign: |  :white_check_mark:  | :white_check_mark:  | :heavy_minus_sign:  |
| `propertylist`   | [Property list] of TeX font metric data                           | :white_check_mark: | :white_check_mark: | :white_check_mark: |  :white_check_mark:  | :heavy_minus_sign:  | :heavy_minus_sign:  |
| `subfonts`       | `ttfutils`' [subfont definition file]                             | :white_check_mark: | :heavy_minus_sign: | :heavy_minus_sign: |  :white_check_mark:  | :heavy_minus_sign:  | :heavy_minus_sign:  |
| `texliveprofile` | TeX Live [installation profile]                                   | :white_check_mark: | :heavy_minus_sign: | :heavy_minus_sign: |  :white_check_mark:  | :heavy_minus_sign:  | :heavy_minus_sign:  |
| `tlpdb`          | TeX Live [Database][tlpdb]/[Object][tlpobj]/[Source][tlpsrc] file | :white_check_mark: | :heavy_minus_sign: | :white_check_mark: |  :white_check_mark:  | :heavy_minus_sign:  | :white_check_mark:  |

[BibTool]: https://ctan.org/pkg/bibtool
[ChkTeX]: https://ctan.org/pkg/chktex
[`DEPENDS.txt`]: https://tug.org/texlive/pkgcontrib.html#deps
[fontmap file]: https://tug.org/fontname/html/Name-mapping-file.html
[installation profile]: https://www.tug.org/texlive/doc/install-tl.html#PROFILES
[Property list]: https://mirrors.ctan.org/info/knuth-pdf/texware/pltotf.pdf
[subfont definition file]: https://www.tug.org/texlive//devsrc/Master/texmf-dist/doc/man/man1/ttf2tfm.man1.pdf
[tlpdb]: https://www.tug.org/texlive/doc/tlpkgdoc/TLPDB.html
[tlpobj]: https://www.tug.org/texlive/doc/tlpkgdoc/TLPOBJ.html
[tlpsrc]: https://www.tug.org/texlive/doc/tlpkgdoc/TLPSRC.html
[Syntax]: https://neovim.io/doc/user/syntax.html#syntax
[Indent]: https://neovim.io/doc/user/indent.html#indent.txt
[Fold]: https://neovim.io/doc/user/fold.html#folding
[Comments]: https://neovim.io/doc/user/various.html#_3.-commenting
[Include]: https://neovim.io/doc/user/options.html#'includeexpr'
[Define]: https://neovim.io/doc/user/options.html#'define'

<!-- panvimdoc-ignore-end -->
<!-- panvimdoc-include-comment

## bibtoolrsc

```vimdoc
  Language        BibTool <https://ctan.org/pkg/bibtool> resource file

  Version         `2.68`

  Features        ✅ Syntax    ✅ Indent    ➖ Folding   ✅ Commenting
                  ➖ Include   ➖ Define
```

## chktexrc

```vimdoc
  Language        ChkTeX <https://ctan.org/pkg/chktex> config file

  Version         `1.7.9`

  Features        ✅ Syntax    ➖ Indent    ✅ Folding   ✅ Commenting
                  ➖ Include   ➖ Define
```

## dependstxt

```vimdoc
  Language        TeX Live’s DEPENDS.txt format
                  <https://tug.org/texlive/pkgcontrib.html#deps>

  Features        ✅ Syntax    ➖ Indent    ✅ Folding   ✅ Commenting
                  ➖ Include   ➖ Define
```

## fontmap

```vimdoc
  Language        TeX fontmap file
                  <https://tug.org/fontname/html/Name-mapping-file.html>

  Features        ✅ Syntax    ➖ Indent    ➖ Folding   ✅ Commenting
                  ✅ Include   ➖ Define
```

## propertylist

```vimdoc
  Language        Property list of TeX font metric data

  Version         - PLtoTF `3.6`
                    <https://mirrors.ctan.org/info/knuth-pdf/texware/pltotf.pdf>
                  - VPtoVF `1.6`
                    <https://mirrors.ctan.org/info/knuth-pdf/etc/vptovf.pdf>
                  - pPLtoTF `p230917`
                    <https://mirrors.ctan.org/info/ptex-manual/jfm.pdf>

  Features        ✅ Syntax    ✅ Indent    ✅ Folding  ✅ Commenting
                  ➖ Include   ➖ Define
```

## subfonts

```vimdoc
  Language        `ttfutils`' subfont definition file
                  <https://www.tug.org/texlive//devsrc/Master/texmf-dist/doc/man/man1/ttf2tfm.man1.pdf>

  Version         `r70015`

  Features        ✅ Syntax    ➖ Indent    ➖ Folding   ✅ Commenting
                  ➖ Include   ➖ Define
```

## texliveprofile

```vimdoc
  Language        TeX Live installation profile
                  <https://www.tug.org/texlive/doc/install-tl.html#PROFILES>

  Version         `2024`

  Features        ✅ Syntax    ➖ Indent    ➖ Folding   ✅ Commenting
                  ➖ Include   ➖ Define
```

## tlpdb

```vimdoc
  Language        TeX Live Database/Object/Source file
                  <https://www.tug.org/texlive/doc/tlpkgdoc>

  Features        ✅ Syntax    ➖ Indent    ✅ Folding   ✅ Commenting
                  ➖ Include   ✅ Define
```

-->

## Configuration

The plugin respects the [filetype-overrule] and [filetype-ignore] global config.
In particular, the following variables affect filetype detection:

- `g:filetype_cfg`
- `g:filetype_def`
- `g:filetype_pl`
- `g:ft_ignore_pat`

[filetype-ignore]: https://neovim.io/doc/user/filetype.html#filetype-ignore
[filetype-overrule]: https://neovim.io/doc/user/filetype.html#filetype-overrule

## License

[MIT License](https://github.com/teatimeguest/tex-filetypes.nvim/blob/main/LICENSE)

<!-- panvimdoc-include-comment --- -->
