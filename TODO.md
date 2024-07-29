# Podman

for jetbrains devpod:
```sh
systemctl --user enable podman socket 
ln -s $XDG_RUNTIME_DIR/podman/podman.sock $XDG_RUNTIME_DIR/docker.sock
```

# If using greetd
For DE to use local bin programs add to ~/.profile

`export PATH="$HOME/.local/bin:$PATH"`
