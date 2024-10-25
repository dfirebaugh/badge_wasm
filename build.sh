#!/bin/bash

# ### install wasm-opt ###
# cargo install wasm-opt --locked
#
# ### install assembly script for asc ###
# npm i -g assemblyscript


# asc pong.ts --textFile module.wat --outFile demo.wasm --bindings raw -O3 --runtime stub
# asc gol.ts --textFile module.wat --outFile demo.wasm --bindings raw -O3 --runtime stub
# asc falling.ts --textFile module.wat --outFile demo.wasm --bindings raw -O3 --runtime minimal #--runtime stub
asc choppa.ts --textFile module.wat --outFile demo.wasm --bindings raw -O3 --runtime minimal #--runtime stub

wasm-opt -Oz -o demo.wasm demo.wasm --enable-bulk-memory --enable-nontrapping-float-to-int  
xxd -iC demo.wasm > demo.wasm.h

