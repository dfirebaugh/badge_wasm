# badge wasm runtime

> experimental!

(my testing was done using a [waveshare-RP2040-Zero](https://www.waveshare.com/rp2040-zero.htm))

I started this to explore a potential way to get more people contributing to the hackrva badge software dev.
see:
  - https://wiki.hackrva.org/index.php/RVAsec_Badge_Builds
  - https://www.hackrva.org/badge/
  - https://github.com/hackrva/badge2024



## How does it work?
1. add the wasm3 library
2. build a runtime (an interface to some C functions)
3. write an app in some language that compiles to web assembly
4. convert that wasm to something c friendly
5. embed the wasm into the c code

## Language choice
You could use any language that compiles to wasm.  I went with [AssemblyScript](https://www.assemblyscript.org/) because, in my testing, it produced a pretty good [wat](https://developer.mozilla.org/en-US/docs/WebAssembly/Understanding_the_text_format)

I also tested out [tinygo](https://tinygo.org/) (which is basically just golang that compiles with llvm), but the wat and wasm that it produced was much larger than what assemblyscript produced.  Also, there was a lot of ambiguity around import/export in wasm.

C, rust, and zig are also reasonable options.  However, I did not test these out.

### Observations
When defining the runtime, you specify a stacksize. I set this to 8192 bytes.  Anything larger than this seemed to cause the pico to not display anything.
```
m3_NewRuntime(env, 8192, NULL)
```
The rp2040-zero has 264KB of SRAM, and 2MB of on-board Flash memory.  However, the `understanding memory layout` article states the nominal stack size to be about 2KB.
So, setting it to 8192 is probably dangerous.

To get around some memory limitations of the runtime, I played around with allocating assets in the C code and then referencing them via a memory address in the wasm.  This approach seemed to work out ok.
The Dino example takes a different approach where it shares a block of memory that it basically draws to and then draws that in C (see: https://github.com/vshymanskyy/wasm3_dino_rpi_pico/blob/main/dino_vm.cpp#L90-L101).

### Conclusion
For these minimal examples, it worked fairly well.

It's interesting but it's probably easier to just write badge apps in C (which has decent documentation at this point - https://github.com/HackRVA/badge2024/blob/main/BADGE-APP-HOWTO.md).
... and realistically, probably not many people would be interested in this.

Also, not dummy proof.

### Reference
 - [Dino pico wasm](https://github.com/vshymanskyy/wasm3_dino_rpi_pico)
 - [wasm3](https://github.com/wasm3/wasm3)
 - [understanding raspberry pi pico's memory layout](https://petewarden.com/2024/01/16/understanding-the-raspberry-pi-picos-memory-layout/)
 - [assemblyscript](https://www.assemblyscript.org/)
