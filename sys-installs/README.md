# Singularity CE Install Script

The script installs these dependencies for Singularity CE:
* build-essential  
* libssl-dev  
* uuid-dev  
* libgpgme11-dev  
* squashfs-tools  
* libseccomp-dev  
* pkg-config  
* libfuse-dev  
* libfuse3-dev  
* libsubid-dev  
* autoconf  
* automake  
* libtool

[Source for dependencies](https://docs.sylabs.io/guides/3.8/admin-guide/installation.html#id1)
Claude was used for some dependency issues:
Prompt: "fuse / fuse3 (libfuse / libfuse3) headers are required to build squashfuse."

The script then downloads the Singularity CE version from their GitHub repository and compiles it using the Makefile in the repository
[Source for compilation](https://docs.sylabs.io/guides/3.8/admin-guide/installation.html#compile-singularity)

Once the install script is finished installing Singularity, it runs `singularity --version` to prove to the user that is has been installed successfully.