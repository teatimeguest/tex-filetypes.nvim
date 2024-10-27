export PATH := (justfile_dir() / '.luarocks' / 'bin') + ':' + env('PATH')

unexport LUAROCKS_CONFIG

[private]
@default:
    just --list

# Generate Vim help file from README.md
doc: (compose 'run' '--rm' 'panvimdoc')

# Format source files
fmt: (dprint 'fmt')

# Check if source files are formatted correctly
fmt-check: (dprint 'check')
    uvx editorconfig-checker

# Install dev dependencies using hererocks
install:
    uvx \
      --from git+https://github.com/luarocks/hererocks.git@0.25.1 \
      hererocks -j2.1 -rlatest .luarocks
    echo '*' >| .luarocks/.gitignore
    luarocks install busted
    luarocks install nlua

# Run linters
lint:
    selene . --config .config/selene.toml
    uvx --from vim-vint --with setuptools vint -cs --enable-neovim .

# Run unit tests with busted
test:
    eval $(luarocks path --no-bin) && busted

[private]
dprint subcommand *args:
    dprint --config .config/dprint/dprint.jsonc {{ subcommand }} {{ args }}

panvimdoc_version := '4.0.1'

[positional-arguments]
[private]
compose +args:
    #!/usr/bin/env -S docker compose -f
    services:
      panvimdoc:
        platform: linux/amd64
        image: panvimdoc:{{ panvimdoc_version }}
        build:
          context: >-
            https://github.com/kdheepak/panvimdoc.git#{{ panvimdoc_version }}
        volumes:
          - ${PWD}/README.md:/workdir/README.md:ro
          - ${PWD}/doc:/workdir/doc
        working_dir: /workdir
        command:
          - --project-name
          - tex-filetypes.nvim
          - --description
          - A Neovim filetype plugin for TeX-related files
          - --shift-heading-level-by
          - "-1"
          - --input-file
          - README.md
