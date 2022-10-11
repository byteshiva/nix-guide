derivation {
    builder = ./builder.sh;
    src = ./hello.sh;
    name = "hello-1.0";
    system = "x86_64-linux"; # Replace with x86_64-darwin, aarch64-darwin or aarch64-linux if needed
    cp = ./busybox_CP;
}
