# "Noniboat"

This is a Docker image build configuration, inspired by Onionboat, but with
a (much) fresher Tor installation.  It is based on Arch Linux.

After it is deployed, it can be updated by simply using the command
`pacman -Syu`, which will update the packages (including tor) found in the
image.  Of course, you'll want to verify that the tor configuration is still
working.

# How to use it?

Follow the directions for [Onionboat](https://github.com/jheretic/onionboat).
The only **visible** difference, really, is support for
[version 3 Hidden Services](https://gitweb.torproject.org/torspec.git/tree/rend-spec-v3.txt)
(in other words, really long `.onion` addresses).  For the most part, it should
"just work" in the same way that Onionboat does.
