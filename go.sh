#!/bin/bash

TEST_DIR=/tmp/OLLVM-16.0_TEST

mkdir $TEST_DIR

# - Anti Class Dump: -enable-acdobf
# - Anti Hooking: -enable-antihook
# - Anti Debug: -enable-adb
# - Bogus Control Flow: -enable-bcfobf
# - (*) Control Flow Flattening: -enable-cffobf
# - Basic Block Splitting: -enable-splitobf
# - Instruction Substitution: -enable-subobf
# - Function CallSite Obf: -enable-fco
# - (*) String Encryption: -enable-strcry
# - Constant Encryption: -enable-constenc
# - (*) Indirect Branching: -enable-indibran
# - (*) Function Wrapper: -enable-funcwra
# - Enable ALL of the above: -enable-allobf (not going to work and you'll probably run out of memory)

CLLVM_ARGS='-Cllvm-args=-enable-acdobf -Cllvm-args=-enable-antihook -Cllvm-args=-enable-adb -Cllvm-args=-enable-bcfobf -Cllvm-args=-enable-splitobf -Cllvm-args=-enable-subobf -Cllvm-args=-enable-fco -Cllvm-args=-enable-constenc'

############################################################
# # target windows
# cargo rustc --target x86_64-pc-windows-gnu --release -- -Cdebuginfo=0 -Cstrip=symbols -Cpanic=abort -Copt-level=3 -Cllvm-args=-enable-allobf
echo "cargo rustc --target x86_64-pc-windows-gnu --release -- -Cdebuginfo=0 -Cstrip=symbols -Cpanic=abort -Copt-level=3 $CLLVM_ARGS"

############################################################
# # target linux
# cargo rustc --target x86_64-unknown-linux-gnu --release -- -Cdebuginfo=0 -Cstrip=symbols -Cpanic=abort -Copt-level=3 -Cllvm-args=-enable-allobf

sudo docker pull ghcr.io/joaovarelas/obfuscator-llvm-16.0:latest
sudo docker run -v $TEST_DIR:/projects/ -it $(sudo docker image ls | grep -i obfuscator-llvm-16.0 | awk '{print $3}') /bin/bash
