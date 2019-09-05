### Make vim 8.1, so that YouCompleteMe works
Install dependencies, and remove existing vim
```sudo yum install cscope ncurses ncurses-devel ncurses-libs ncurses-base python-libs ruby-devel python36 python36-pip python36-devel perl perl-devel.x86_64 perl-ExtUtils-CBuilder.noarch perl-ExtUtils-Embed.noarch perl-ExtUtils-XSpp.noarch perl-ExtUtils-XSBuilder.noarch ctags lua lua-devel.x86_64 tcl-devel ctags git luajit
sudo ln -s /usr/bin/xsubpp /usr/share/perl5/ExtUtils/xsubpp
sudo yum remove vim gvim vim-common.x86_64 vim-minimal.x86_64 vim-filesystem.x86_64
```
Clone vim, configure, build and install
```
git clone git@github.com:vim/vim.git
cd vim
./configure --with-features=huge --enable-multibyte --enable-rubyinterp=yes --enable-pythoninterp=yes --with-python-config-dir=/lib64/python2.7/config --enable-python3interp vi_cv_path_python3=/usr/bin/python3.6 --with-python-config-dir=/usr/lib64/python3.6/config-3.6m-x86_64-linux-gnu/ --enable-perlinterp --enable-luainterp --enable-gui=gtk2 --enable-cscope --prefix=/usr/local
make VIMRUNTIMEDIR=/usr/local/share/vim/vim81
sudo make install
```
Link this vim to /usr/bin, so root has vim
`sudo ln -s /usr/local/bin/vim /usr/bin/vim`


### Basic usability enhancements
Add tab toggling shortcuts other then ctrl+PgUp/PgDown
```
cat <<EOF >> .config/xfce4/terminal/accels.scm
(gtk_accel_path "<Actions>/terminal-window/next-tab" "<Primary>n")
(gtk_accel_path "<Actions>/terminal-window/prev-tab" "<Primary>b")
EOF
```

Add window moving hotkeys. Insert the following properties into `~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml`
Mine are in section 'custom', but don't quite how it needs be, but it works. Suggest putting them where existing 'tile' shortcuts are:
```
      <property name="&lt;Super&gt;Right" type="string" value="tile_right_key"/>
      <property name="&lt;Super&gt;Down" type="string" value="tile_down_key"/>
      <property name="&lt;Primary&gt;&lt;Shift&gt;Up" type="string" value="maximize_window_key"/>
      <property name="&lt;Super&gt;Up" type="string" value="tile_up_key"/>
      <property name="&lt;Super&gt;Left" type="string" value="tile_left_key"/>
```

#### Utils file handling
Moved the team and powerline bashrcs out, stuck mine in.

Customised fonts and all that, replacing exiting terminalrc with the one here
Pulled the ssh function back across from the team bashrc into the top of mine.

#### Setup autologin, and no chrome keyring
In /etc/lightdm/lightdm.conf, set:
```
pam-service=lightdm
pam-autologin-service=lightdm-autologin
autologin-user=developer
autologin-user-timeout=0
autologin-session=xfce

```

Run
```
sudo groupadd -r autologin
sudo gpasswd -a developer autologin
```

Chrome changes so it doens't prompt for passwords all the time. This is insecure, but i don't store sensitive things in dev vm password store:
```
cp /usr/share/applications/google-chrome.desktop ~/.local/share/applications
vim ~/.local/share/applications/google-chrome.desktop
```
Add --password-store=basic to all lines starting `Exec`
e.g.
```
11:58:49-devin ~ $ diff /usr/share/applications/google-chrome.desktop ~/.local/share/applications/google-chrome.desktop
108c108
< Exec=/usr/bin/google-chrome-stable %U --disable-async-dns
---
> Exec=/usr/bin/google-chrome-stable --password-store=basic %U --disable-async-dns
```
and to change the 'Web Browser' applications link
```
cp /usr/share/applications/exo-web-browser.desktop .local/share/applications/
vim ~/.local/share/applications/google-chrome.desktop
```
and change the `Exec` line to match one from the chrome file above. You can comment out the exo Exec line with a `#`

N.B. Before the last change, this didn't  seem to work all the time, not sure why. Also, running chrome from the CLI i always forget it's `google-chrome` not just `chrome`, so:
in Bashrc, add:
```
alias chrome='google-chrome --password-store=basic'
```

#### Disable screen saver/screen blanking
Run
```
xset s 0 0
xset s off
xset s noblank
xset -dpms
```
