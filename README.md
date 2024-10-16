# tex-filetypes.nvim

<!-- panvimdoc-ignore-start -->

> A Neovim filetype plugin for TeX-related files

<!-- panvimdoc-ignore-end -->

## Features

- Improved detection of existing filetypes, especially `tex`.
- Additional support for several TeX-related file formats.

## Installation

### With [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "teatimeguest/tex-filetypes.nvim",
  config = true,
  event = { 'BufReadPre', 'BufNewFile' },
}
```

### With [mini.deps](https://github.com/echasnovski/mini.deps)

```lua
add("teatimeguest/tex-filetypes.nvim")
```

## Filetypes

Provides support for the following filetypes:

<!-- panvimdoc-ignore-start -->
<table>
  <thead>
    <tr>
      <th rowspan="2">Filetype</th>
      <th rowspan="2">Language</th>
      <th colspan="4">Supported Features</th>
    </tr>
    <tr>
      <th>
        <sup>
          <a href="https://neovim.io/doc/user/syntax.html#syntax">
            Syntax
          </a>
        </sup>
      </th>
      <th>
        <sup>
          <a href="https://neovim.io/doc/user/indent.html#indent.txt">
            Indent
          </a>
        </sup>
      </th>
      <th>
        <sup>
          <a href="https://neovim.io/doc/user/fold.html#folding">
            Folding
          </a>
        </sup>
      </th>
      <th>
        <sup>
          <a href="https://neovim.io/doc/user/various.html#_3.-commenting">
            Commenting
          </a>
        </sup>
      </th>
    </tr>
  </thead>
  <tbody align="center">
    <tr>
      <td align="left"><code>bibtoolrsc</code></td>
      <td align="left">

[BibTool](https://ctan.org/pkg/bibtool) resource file

**Version:**&ensp;`2.68`

<!-- panvimdoc-include-comment

## bibtoolrsc

```vimdoc
  Language        BibTool <https://ctan.org/pkg/bibtool> resource file

  Version         `2.68`

  Features        ✅ Syntax  ✅ Indent  ➖ Folding  ✅ Commenting
```

-->
</td>
      <td>✅</td><td>✅</td><td>➖</td><td>✅</td>
    </tr>
    <tr>
      <td align="left"><code>chktexrc</code></td>
      <td align="left">

[ChkTeX](https://ctan.org/pkg/chktex) config file

**Version**&ensp;`1.7.9`

<!-- panvimdoc-include-comment

## chktexrc

```vimdoc
  Language         ChkTeX <https://ctan.org/pkg/chktex> config file

  Version          `1.7.9`

  Features         ✅ Syntax  ➖ Indent  ✅ Folding  ✅ Commenting
```

-->
</td>
      <td>✅</td><td>➖</td><td>✅</td><td>✅</td>
    </tr>
    <tr>
      <td align="left"><code>dependstxt</code></td>
      <td align="left">

TeX Live's [`DEPENDS.txt`](https://tug.org/texlive/pkgcontrib.html#deps) format

<!-- panvimdoc-include-comment

## dependstxt

```vimdoc
  Language        TeX Live’s DEPENDS.txt format
                  <https://tug.org/texlive/pkgcontrib.html#deps>

  Features        ✅ Syntax  ➖ Indent  ✅ Folding  ✅ Commenting
```

-->
</td>
      <td>✅</td><td>➖</td><td>✅</td><td>✅</td>
    </tr>
    <tr>
      <td align="left"><code>propertylist</code></td>
      <td align="left">

Property list of TeX font metric data

<div><strong>Version:</strong></div>

- [PLtoTF] `3.6`
- [VPtoVF] `1.6`
- [pPLtoTF] `p230917`

[PLtoTF]: https://mirrors.ctan.org/info/knuth-pdf/texware/pltotf.pdf
[VPtoVF]: https://mirrors.ctan.org/info/knuth-pdf/etc/vptovf.pdf
[pPLtoTF]: https://mirrors.ctan.org/info/ptex-manual/jfm.pdf

<!-- panvimdoc-include-comment

## propertylist

```vimdoc
  Language        Property list of TeX font metric data

  Version         - PLtoTF `3.6`
                    <https://mirrors.ctan.org/info/knuth-pdf/texware/pltotf.pdf>
                  - VPtoVF `1.6`
                    <https://mirrors.ctan.org/info/knuth-pdf/etc/vptovf.pdf>
                  - pPLtoTF `p230917`
                    <https://mirrors.ctan.org/info/ptex-manual/jfm.pdf>

  Features        ✅ Syntax  ✅ Indent  ✅ Folding  ✅ Commenting
```

-->
</td>
      <td>✅</td><td>✅</td><td>✅</td><td>✅</td>
    </tr>
    <tr>
      <td align="left"><code>texliveprofile</code></td>
      <td align="left">

TeX Live
[installation profile](https://www.tug.org/texlive/doc/install-tl.html#PROFILES)

**Version:**&ensp;`2024`

<!-- panvimdoc-include-comment

## texliveprofile

```vimdoc
  Language        TeX Live installation profile
                  <https://www.tug.org/texlive/doc/install-tl.html#PROFILES>

  Version         `2024`

  Features        ✅ Syntax  ➖ Indent  ➖ Folding  ✅ Commenting
```

-->
</td>
      <td>✅</td><td>➖</td><td>➖</td><td>✅</td>
    </tr>
  </tbody>
</table>
<!-- panvimdoc-ignore-end -->

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
