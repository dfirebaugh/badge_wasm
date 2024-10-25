/* note: this code intended as reference only */
#include "pico/stdlib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <wasm3.h>

#include "buttons.h"
#include "colors.h"
#include "framebuffer.h"
#include "sprite.h"

#define FATAL(func, msg)                                                       \
  {                                                                            \
    printf("Fatal %s: %s\n", func, msg);                                       \
    while (1) {                                                                \
      sleep_ms(100);                                                           \
    }                                                                          \
  }

m3ApiRawFunction(Math_random) {
  m3ApiReturnType(float) float r = (float)rand() / (float)(RAND_MAX);
  m3ApiReturn(r);
}

/*// Memcpy is generic, and much faster in native code*/
/*m3ApiRawFunction(Dino_memcpy) {*/
/*  m3ApiGetArgMem(uint8_t *, dst) m3ApiGetArgMem(uint8_t *, src)*/
/*      m3ApiGetArgMem(uint8_t *, dstend)*/
/**/
/*          do {*/
/*    *dst++ = *src++;*/
/*  }*/
/*  while (dst < dstend)*/
/*    ;*/
/**/
/*  m3ApiSuccess();*/
/*}*/

/*void abort(int message, int fileName, int lineNumber, int columnNumber) {*/
/*  printf("Abort called! Message: %d, File: %d, Line: %d, Column: %d\n",
 * message,*/
/*         fileName, lineNumber, columnNumber);*/
/*}*/

m3ApiRawFunction(EnvAbort) {
  m3ApiGetArg(int32_t, message);
  m3ApiGetArg(int32_t, fileName);
  m3ApiGetArg(int32_t, lineNumber);
  m3ApiGetArg(int32_t, columnNumber);

  printf("Abort called! Message: %d, File: %d, Line: %d, Column: %d\n", message,
         fileName, lineNumber, columnNumber);
  m3ApiSuccess();
}

m3ApiRawFunction(FbClear_wasm) {
  FbClear();
  m3ApiSuccess();
}

m3ApiRawFunction(FbColor_wasm) {
  m3ApiGetArg(uint16_t, color);
  FbColor(color);
  m3ApiSuccess();
}

m3ApiRawFunction(FbRGB_wasm) {
  m3ApiGetArg(uint8_t, r);
  m3ApiGetArg(uint8_t, g);
  m3ApiGetArg(uint8_t, b);
  FbColor(PACKRGB888(r, g, b));
  m3ApiSuccess();
}

m3ApiRawFunction(FbMove_wasm) {
  m3ApiGetArg(uint8_t, x);
  m3ApiGetArg(uint8_t, y);
  FbMove(x, y);
  m3ApiSuccess();
}

m3ApiRawFunction(FbPoint_wasm) {
  m3ApiGetArg(uint8_t, x);
  m3ApiGetArg(uint8_t, y);
  FbPoint(x, y);
  m3ApiSuccess();
}

m3ApiRawFunction(FbHorizontalLine_wasm) {
  m3ApiGetArg(uint8_t, x1);
  m3ApiGetArg(uint8_t, y1);
  m3ApiGetArg(uint8_t, x2);
  m3ApiGetArg(uint8_t, y2);
  FbHorizontalLine(x1, y1, x2, y2);
  m3ApiSuccess();
}

m3ApiRawFunction(FbVerticalLine_wasm) {
  m3ApiGetArg(uint8_t, x1);
  m3ApiGetArg(uint8_t, y1);
  m3ApiGetArg(uint8_t, x2);
  m3ApiGetArg(uint8_t, y2);
  FbVerticalLine(x1, y1, x2, y2);
  m3ApiSuccess();
}

m3ApiRawFunction(FbLine_wasm) {
  m3ApiGetArg(uint8_t, x0);
  m3ApiGetArg(uint8_t, y0);
  m3ApiGetArg(uint8_t, x1);
  m3ApiGetArg(uint8_t, y1);
  FbLine(x0, y0, x1, y1);
  m3ApiSuccess();
}

m3ApiRawFunction(FbRectangle_wasm) {
  m3ApiGetArg(uint8_t, width);
  m3ApiGetArg(uint8_t, height);
  FbRectangle(width, height);
  m3ApiSuccess();
}

m3ApiRawFunction(FbCircle_wasm) {
  m3ApiGetArg(int, x);
  m3ApiGetArg(int, y);
  m3ApiGetArg(int, r);
  FbCircle(x, y, r);
  m3ApiSuccess();
}

m3ApiRawFunction(FbFilledCircle_wasm) {
  m3ApiGetArg(int, x);
  m3ApiGetArg(int, y);
  m3ApiGetArg(int, r);
  FbFilledCircle(x, y, r);
  m3ApiSuccess();
}

m3ApiRawFunction(FbWriteString_wasm) {
  m3ApiGetArgMem(const char *, string);
  FbWriteString(string);
  m3ApiSuccess();
}

m3ApiRawFunction(FbFilledRectangle_wasm) {
  m3ApiGetArg(uint8_t, width);
  m3ApiGetArg(uint8_t, height);
  FbFilledRectangle(width, height);
  m3ApiSuccess();
}

m3ApiRawFunction(FbDrawObject_wasm) {
  m3ApiGetArgMem(const struct point *, drawing);
  m3ApiGetArg(int, npoints);
  m3ApiGetArg(int, color);
  m3ApiGetArg(int, x);
  m3ApiGetArg(int, y);
  m3ApiGetArg(int, scale);
  FbDrawObject(drawing, npoints, color, x, y, scale);
  m3ApiSuccess();
}

m3ApiRawFunction(SpriteLoadPalette_wasm) {
  m3ApiGetArgMem(const unsigned int *, palette);
  sprite_load_palette(palette);
  m3ApiSuccess();
}

m3ApiRawFunction(FbWriteCharacter_wasm) {
  m3ApiGetArg(uint8_t, charin);
  FbWriteCharacter(charin);
  m3ApiSuccess();
}

/*m3ApiRawFunction(SpriteInitSpritesheet_wasm) {*/
/*  m3ApiGetArgMem(const char *, sprite_sheet);*/
/*  m3ApiGetArg(unsigned int, len);*/
/*  printf(sprite_sheet);*/
/*  sprite_init_spritesheet(sprite_sheet, len);*/
/*  m3ApiSuccess();*/
/*}*/
#define MAX_DIGITS_U8 3
m3ApiRawFunction(u8ToString_wasm) {
  m3ApiReturnType(const char *) m3ApiGetArg(uint8_t, value);

  char *str = (char *)malloc(MAX_DIGITS_U8 + 1);
  if (str == NULL) {
    m3ApiReturn(NULL);
  }

  snprintf(str, MAX_DIGITS_U8 + 1, "%u", value);

  m3ApiReturn(str);
}

m3ApiRawFunction(SpriteDrawInline_wasm) {
  m3ApiGetArg(int, x);
  m3ApiGetArg(int, y);
  m3ApiGetArgMem(const char *, hex);
  sprite_draw_inline(x, y, hex);
  m3ApiSuccess();
}

m3ApiRawFunction(SpriteSampleSpritesheetPixel_wasm) {
  m3ApiReturnType(uint32_t) m3ApiGetArg(int, sprite_index);
  m3ApiGetArg(int, pixel_index);
  unsigned int color =
      sprite_sample_spritesheet_pixel(sprite_index, pixel_index);
  m3ApiReturn(color);
}

m3ApiRawFunction(SpriteDraw_wasm) {
  m3ApiGetArg(int, x);
  m3ApiGetArg(int, y);
  m3ApiGetArg(int, sprite_index);
  sprite_draw(x, y, sprite_index);
  m3ApiSuccess();
}

m3ApiRawFunction(SpriteDrawExcludeColor_wasm) {
  m3ApiGetArg(int, x);
  m3ApiGetArg(int, y);
  m3ApiGetArg(int, sprite_index);
  m3ApiGetArgMem(const char *, exclude_colors_hex);
  sprite_draw_exclude_color(x, y, sprite_index, exclude_colors_hex);
  m3ApiSuccess();
}

m3ApiRawFunction(SpriteDrawPaletteGrid_wasm) {
  m3ApiGetArg(int, grid_x);
  m3ApiGetArg(int, grid_y);
  sprite_draw_palette_grid(grid_x, grid_y);
  m3ApiSuccess();
}

m3ApiRawFunction(SpriteColorFromPaletteIndex_wasm) {
  m3ApiReturnType(uint16_t) m3ApiGetArg(uint8_t, index)

      uint16_t color = color_from_palette_index(index);
  m3ApiReturn(color);
}

IM3Environment env;
IM3Runtime runtime;
IM3Module module;
IM3Function func_run;
IM3Function func_update;
IM3Function func_render;
IM3Function func_init;
IM3Function func_checkButtons;
uint8_t *mem;

#define BUTTON_STATE_ADDR 0x0000

static void button_callback(BADGE_BUTTON button, bool state) {
  uint32_t *input = (uint32_t *)(mem + BUTTON_STATE_ADDR);
  if (state) {
    switch (button) {
    case BADGE_BUTTON_UP:
      printf("UP button pressed\n");
      *input |= 0x1;
      break;
    case BADGE_BUTTON_DOWN:
      printf("DOWN button pressed\n");
      *input |= 0x2;
      break;
    case BADGE_BUTTON_LEFT:
      printf("LEFT button pressed\n");
      *input |= 0x4;
      break;
    case BADGE_BUTTON_RIGHT:
      printf("RIGHT button pressed\n");
      *input |= 0x8;
      break;
    case BADGE_BUTTON_A:
      printf("A button pressed\n");
      *input |= 0x10;
      break;
    case BADGE_BUTTON_B:
      printf("B button pressed\n");
      *input |= 0x20;
      break;
    case BADGE_BUTTON_X:
      printf("X button pressed\n");
      *input |= 0x40;
      break;
    case BADGE_BUTTON_Y:
      printf("Y button pressed\n");
      *input |= 0x80;
      break;
    case BADGE_BUTTON_START:
      printf("START button pressed\n");
      *input |= 0x100;
      break;
    case BADGE_BUTTON_SELECT:
      printf("SELECT button pressed\n");
      *input |= 0x200;
      break;
    default:
      printf("Unknown button pressed\n");
      break;
    }
  } else {
    switch (button) {
    case BADGE_BUTTON_UP:
      *input &= ~0x1;
      break;
    case BADGE_BUTTON_DOWN:
      *input &= ~0x2;
      break;
    case BADGE_BUTTON_LEFT:
      *input &= ~0x4;
      break;
    case BADGE_BUTTON_RIGHT:
      *input &= ~0x8;
      break;
    case BADGE_BUTTON_A:
      *input &= ~0x10;
      break;
    case BADGE_BUTTON_B:
      *input &= ~0x20;
      break;
    case BADGE_BUTTON_X:
      *input &= ~0x40;
      break;
    case BADGE_BUTTON_Y:
      *input &= ~0x80;
      break;
    case BADGE_BUTTON_START:
      *input &= ~0x100;
      break;
    case BADGE_BUTTON_SELECT:
      *input &= ~0x200;
      break;
    default:
      break;
    }
  }
}

static void load_wasm(unsigned char *wasm_app, int wasm_app_size) {
  M3Result result = m3Err_none;

  if (!env) {
    env = m3_NewEnvironment();
    if (!env)
      FATAL("NewEnvironment", "failed");
  }

  m3_FreeRuntime(runtime);

  runtime = m3_NewRuntime(env, 8192, NULL);
  if (!runtime)
    FATAL("NewRuntime", "failed");

  result = m3_ParseModule(env, &module, wasm_app, wasm_app_size);
  if (result)
    FATAL("ParseModule", result);

  result = m3_LoadModule(runtime, module);
  if (result)
    FATAL("LoadModule", result);

  m3_LinkRawFunction(module, "Math", "random", "f()", &Math_random);

  m3_LinkRawFunction(module, "env", "abort", "v(iiii)", &EnvAbort);

  m3_LinkRawFunction(module, "Fb", "clear", "v()", &FbClear_wasm);
  m3_LinkRawFunction(module, "Fb", "color", "v(i)", &FbColor_wasm);
  m3_LinkRawFunction(module, "Fb", "rgb", "v(iii)", &FbRGB_wasm);
  m3_LinkRawFunction(module, "Fb", "move", "v(ii)", &FbMove_wasm);
  m3_LinkRawFunction(module, "Fb", "rectangle", "v(ii)", &FbRectangle_wasm);
  m3_LinkRawFunction(module, "Fb", "circle", "v(iii)", &FbCircle_wasm);
  m3_LinkRawFunction(module, "Fb", "filledCircle", "v(iii)",
                     &FbFilledCircle_wasm);
  m3_LinkRawFunction(module, "Fb", "filledRectangle", "v(ii)",
                     &FbFilledRectangle_wasm);
  m3_LinkRawFunction(module, "Fb", "drawObject", "v(*iiiiii)",
                     &FbDrawObject_wasm);
  m3_LinkRawFunction(module, "Fb", "writeCharacter", "v(i)",
                     &FbWriteCharacter_wasm);
  m3_LinkRawFunction(module, "Fb", "writeString", "v(*)", &FbWriteString_wasm);
  m3_LinkRawFunction(module, "Sprite", "loadPalette", "v(*i)",
                     &SpriteLoadPalette_wasm);
  m3_LinkRawFunction(module, "Sprite", "drawInline", "v(ii*)",
                     &SpriteDrawInline_wasm);
  m3_LinkRawFunction(module, "Sprite", "sampleSpritesheetPixel", "i(ii)",
                     &SpriteSampleSpritesheetPixel_wasm);
  m3_LinkRawFunction(module, "Sprite", "draw", "v(iii)", &SpriteDraw_wasm);
  m3_LinkRawFunction(module, "Sprite", "drawExcludeColor", "v(ii*i)",
                     &SpriteDrawExcludeColor_wasm);
  m3_LinkRawFunction(module, "Sprite", "drawPaletteGrid", "v(ii)",
                     &SpriteDrawPaletteGrid_wasm);
  m3_LinkRawFunction(module, "Sprite", "colorFromPaletteIndex", "i(i)",
                     &SpriteColorFromPaletteIndex_wasm);

  m3_LinkRawFunction(module, "Utils", "u8ToString", "i(i)", &u8ToString_wasm);
  mem = m3_GetMemory(runtime, NULL, 0);
  /*if (!mem)*/
  /*  FATAL("GetMemory", "failed");*/

  result = m3_FindFunction(&func_update, runtime, "update");
  /*if (result)*/
  /*  FATAL("FindFunction", result);*/
  result = m3_FindFunction(&func_render, runtime, "render");
  /*if (result)*/
  /*  FATAL("FindFunction", result);*/
}

static void drawImage(uint16_t *src, int dst_x, int dst_y, int src_w,
                      int src_h) {
  for (int y = 0; y < src_h; y++) {
    for (int x = 0; x < src_w; x++) {
      FbMove(dst_x + x, dst_y + y);
      FbColor(__builtin_bswap16(*src++));
      FbPoint(dst_x + x, dst_y + y);
    }
  }
}

static void wasmrt_init() {
  button_set_interrupt(button_callback);

  printf("\nWasm3 v" M3_VERSION " (" M3_ARCH "), build " __DATE__ " " __TIME__
         "\n");

  uint32_t *input = (uint32_t *)(mem + BUTTON_STATE_ADDR);
  *input = 0;

  FbColor(WHITE);
  FbClear();

  FbColor(BLACK);
  FbMove(5, 5);
  FbWriteString("Wasm3 " M3_VERSION "  (" M3_ARCH " M0)");
  FbSwapBuffers();
}

void wasmrt_load_app(unsigned char *wasm_app, int wasm_app_size,
                     char *sprite_sheet) {
  wasmrt_init();
  load_wasm(wasm_app, wasm_app_size);
  sprite_init_spritesheet(sprite_sheet, strlen(sprite_sheet));
}

void wasmrt_update() {
  button_task();
  M3Result result;
  result = m3_CallV(func_update);
  if (result) {
    M3ErrorInfo info;
    m3_GetErrorInfo(runtime, &info);
    printf("Error: %s (%s)\n", result, info.message);
    if (info.file && strlen(info.file) && info.line) {
      printf("at %s:%d\n", info.file, info.line);
    }
    return;
  }
  result = m3_CallV(func_render);
  if (result) {
    M3ErrorInfo info;
    m3_GetErrorInfo(runtime, &info);
    printf("Error: %s (%s)\n", result, info.message);
    if (info.file && strlen(info.file) && info.line) {
      printf("at %s:%d\n", info.file, info.line);
    }
    return;
  }

  /*printf("Wasm function 'run' executed successfully\n");*/
}
