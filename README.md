# Export ppk private key to OpenSSH

If you want to export a private key from PuTTYgen in a format that can be used with OpenSSH. This
is particularly useful if you need to use the key with OpenSSH on a Unix-like system (Linux, macOS, 
etc.) or if you are working with software that requires OpenSSH key formats.

Change pwd to the folder where your `.ppk` files are located and execute:

```
$ docker run --network none --rm -it \
    --volume=${PWD}:/data:rw ghcr.io/jbrazio/docker-putty-tools:main
```
