
# Font fix
Download, unzip and copy to ~.local/share/fonts/FONTNAME/*
fixed fonts: https://github.com/ryanoasis/nerd-fonts#option-2-release-archive-download
Set new fonts in gnome terminal

# Phpactor
install missing dependencies
## Instant reindex
use following command to install filewatcher for phpactor: https://phpactor.readthedocs.io/en/master/reference/indexer.html#indexer
```
sudo dnf install inotify-tools
```


# Ripgrep
for fuzzy finder <leader>g
```
sudo dnf install ripgrep -y
```

# Delta
used for lazygit diff
```
sudo dnf install git-delta
```

## Always how php syntax
For delta to show php syntax highlighting, it needs to see the php opening tag to know it's php
Use this link: https://github.com/dandavison/delta/issues/162#issuecomment-625952288 to always show php highlighting if it's a php file
