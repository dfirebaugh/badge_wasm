/* requires a spritesheet to be loaded into memory before running this app */

@external("Fb", "clear")
declare function FbClear(): void;

@external("Fb", "color")
declare function FbColor(color: u16): void;

@external("Fb", "rgb")
declare function FbRGB(r: u8, g: u8, b: u8): void;

@external("Fb", "move")
declare function FbMove(x: u8, y: u8): void;

@external("Fb", "rectangle")
declare function FbRectangle(width: u8, height: u8): void;

@external("Fb", "circle")
declare function FbCircle(x: i32, y: i32, r: i32): void;

@external("Fb", "filledCircle")
declare function FbFilledCircle(x: i32, y: i32, r: i32): void;

@external("Fb", "filledRectangle")
declare function FbFilledRectangle(width: u8, height: u8): void;

@external("Sprite", "loadPalette")
declare function SpriteLoadPalette(palette: usize): void;

@external("Sprite", "initSpritesheet")
declare function SpriteInitSpritesheet(sprite_sheet: usize, len: u32): void;

@external("Sprite", "drawInline")
declare function SpriteDrawInline(x: i32, y: i32, hex: usize): void;

@external("Sprite", "sampleSpritesheetPixel")
declare function SpriteSampleSpritesheetPixel(sprite_index: i32, pixel_index: i32): u32;

@external("Sprite", "draw")
declare function SpriteDraw(x: i32, y: i32, sprite_index: i32): void;

@external("Sprite", "drawExcludeColor")
declare function SpriteDrawExcludeColor(x: i32, y: i32, sprite_index: i32, exclude_colors_hex: usize): void;

@external("Sprite", "drawPaletteGrid")
declare function SpriteDrawPaletteGrid(grid_x: i32, grid_y: i32): void;

@external("Sprite", "colorFromPaletteIndex")
declare function SpriteColorFromPaletteIndex(index: u8): u16;

const SCREEN_WIDTH: u8 = 128;
const SCREEN_HEIGHT: u8 = 160;

const BUTTON_STATE_ADDR: usize = 0x0000;

const BUTTON_UP: u32 = 0x1;
const BUTTON_DOWN: u32 = 0x2;
const BUTTON_LEFT: u32 = 0x4;
const BUTTON_RIGHT: u32 = 0x8;
const BUTTON_A: u32 = 0x10;
const BUTTON_B: u32 = 0x20;
const BUTTON_X: u32 = 0x40;
const BUTTON_Y: u32 = 0x80;
const BUTTON_START: u32 = 0x100;
const BUTTON_SELECT: u32 = 0x200;

function isButtonPressed(buttonMask: u32): bool {
  return (load<u32>(BUTTON_STATE_ADDR) & buttonMask) != 0;
}

class Rectangle {
  x: u8;
  y: u8;
  width: u8;
  height: u8;
  vx: i8;
  vy: i8;
  color: u16;

  constructor(x: u8, y: u8, width: u8, height: u8, color: u16, vx: i8, vy: i8) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.color = color;
    this.vx = vx;
    this.vy = vy;
  }

  update(): void {
    this.x += this.vx;
    this.y += this.vy;

    if (this.x <= 0 || this.x + this.width >= SCREEN_WIDTH) this.vx *= -1;
    if (this.y <= 0 || this.y + this.height >= SCREEN_HEIGHT) this.vy *= -1;
  }

  render(): void {
    FbColor(this.color);
    FbMove(this.x, this.y);
    FbRectangle(this.width, this.height);
  }

  renderFilled(): void {
    FbColor(this.color);
    FbMove(this.x, this.y);
    FbFilledRectangle(this.width, this.height);
  }
}

class Circle {
  x: u8;
  y: u8;
  radius: u8;
  vx: i8;
  vy: i8;
  color: u16;

  constructor(x: u8, y: u8, radius: u8, color: u16, vx: i8, vy: i8) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.color = color;
    this.vx = vx;
    this.vy = vy;
  }

  update(): void {
    this.x += this.vx;
    this.y += this.vy;

    if (this.x - this.radius <= 0 || this.x + this.radius >= SCREEN_WIDTH) this.vx *= -1;
    if (this.y - this.radius <= 0 || this.y + this.radius >= SCREEN_HEIGHT) this.vy *= -1;
  }

  render(): void {
    FbColor(this.color);
    FbMove(this.x, this.y);
    FbCircle(this.x, this.y, this.radius);
  }
  renderFilled(): void {
    FbColor(this.color);
    FbMove(this.x, this.y);
    FbFilledCircle(this.x, this.y, this.radius);
  }
}

const red: u16 = 0b1111100000000000;
const green: u16 = 0b0000011111100000;
const blue: u16 = 0b0000000000011111;
const yellow: u16 = 0b1111111111100000;
const purple: u16 = 0b1111100000011111;
const cyan: u16 = 0b0000011111111111;
const white: u16 = 0b1111111111111111;
const orange: u16 = 0b1111111000000000;

let rect1 = new Rectangle(10, 20, 30, 30, red, 1, 1);
let rect2 = new Rectangle(50, 50, 20, 20, green, -1, 1);
let rect3 = new Rectangle(90, 70, 25, 25, blue, 2, -1);
let rect4 = new Rectangle(30, 90, 15, 15, yellow, 1, -2);
let rect5 = new Rectangle(20, 40, 25, 25, orange, 1, 1);
let rect6 = new Rectangle(60, 20, 15, 15, white, -2, 1);
let rect7 = new Rectangle(70, 30, 20, 20, purple, 1, -1);
let rect8 = new Rectangle(40, 60, 30, 30, cyan, -1, -1);

let circle1 = new Circle(80, 80, 15, purple, 1, -1);
let circle2 = new Circle(40, 40, 10, cyan, -1, 1);
let circle3 = new Circle(60, 100, 12, red, 2, 2);
let circle4 = new Circle(50, 120, 18, orange, -1, -1);
let circle5 = new Circle(30, 30, 20, green, 1, 1);
let circle6 = new Circle(90, 50, 15, blue, -1, 2);

export function update(): void {
  if (!isButtonPressed(BUTTON_Y)) {
    rect1.update();
    rect2.update();
    rect3.update();
    rect4.update();
    rect5.update();
    rect6.update();
    rect7.update();
    rect8.update();
  }
  if (!isButtonPressed(BUTTON_X)) {
    circle1.update();
    circle2.update();
    circle3.update();
    circle4.update();
    circle5.update();
    circle6.update();
  }
}

export function render(): void {
  FbClear();
  SpriteDrawPaletteGrid(0, 32);
  SpriteDrawPaletteGrid(0, 64);
  SpriteDrawPaletteGrid(0, 96);
  SpriteDrawPaletteGrid(64, 32);
  SpriteDrawPaletteGrid(64, 64);
  SpriteDrawPaletteGrid(64, 96);

  if (!isButtonPressed(BUTTON_DOWN)) {
    rect1.renderFilled();
    rect2.renderFilled();
    rect3.renderFilled();
    rect4.renderFilled();
    rect5.renderFilled();
    rect6.renderFilled();
    rect7.renderFilled();
    rect8.renderFilled();
  }
  if (!isButtonPressed(BUTTON_UP)) {
    circle1.renderFilled();
    circle2.renderFilled();
    circle3.renderFilled();
    circle4.renderFilled();
    circle5.renderFilled();
    circle6.renderFilled();
  }
  SpriteDrawPaletteGrid(0, 0);
  SpriteDrawExcludeColor(
    80,
    80,
    0,
    changetype<usize>("0")
  );
  SpriteDrawExcludeColor(
    40,
    40,
    4,
    changetype<usize>("0")
  );
  SpriteDraw(100, 100, 0);
  FbColor(red);
}
