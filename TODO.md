# Podman

for jetbrains devpod:
```sh
systemctl --user enable podman socket 
ln -s $XDG_RUNTIME_DIR/podman/podman.sock $XDG_RUNTIME_DIR/docker.sock
```
