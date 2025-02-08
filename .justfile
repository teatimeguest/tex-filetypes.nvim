export PATH := x'${PWD}/.luarocks/bin:${PATH}'

unexport LUAROCKS_CONFIG

[private]
@default:
    just --list

# Show diagnostic report using LuaLS
check: llscheck

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
    luarocks install llscheck
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
    pnpm \
      --package @johnnymorganz/stylua-bin@0.20.0 \
      --package dprint \
      dlx \
      dprint --config .config/dprint/dprint.jsonc {{ subcommand }} {{ args }}

[private]
llscheck $VIMRUNTIME=`nvim --clean --noplugin -es '+pu=$VIMRUNTIME|pr|q!'`:
    llscheck --checklevel Hint --configpath .config/luarc.json

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
        network_mode: none
        read_only: true
        volumes:
          - ${PWD}/README.md:/workdir/README.md:ro
          - ${PWD}/doc:/workdir/doc
        working_dir: /workdir
        command:
          - --project-name
          - >-
            {{ `sed -n 's/^# //;T;p;q' README.md` }}
          - --description
          - >-
            {{ `sed -n 's/^> //;T;p;q' README.md` }}
          - --doc-mapping
          - "true"
          - --shift-heading-level-by
          - "-1"
          - --input-file
          - README.md
