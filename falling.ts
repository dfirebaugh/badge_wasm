@external("Math", "random")
declare function Math_random(): f32;

@external("Fb", "clear")
declare function FbClear(): void;

@external("Fb", "color")
declare function FbColor(color: u16): void;

@external("Fb", "move")
declare function FbMove(x: u8, y: u8): void;

@external("Fb", "filledRectangle")
declare function FbFilledRectangle(width: u8, height: u8): void;

const SCREEN_WIDTH: u8 = 128;
const SCREEN_HEIGHT: u8 = 160;

const BUTTON_STATE_ADDR: usize = 0x0000;

const BUTTON_LEFT: u32 = 0x4;
const BUTTON_RIGHT: u32 = 0x8;

function isButtonPressed(buttonMask: u32): bool {
  return (load<u32>(BUTTON_STATE_ADDR) & buttonMask) != 0;
}

const PADDLE_WIDTH: u8 = 20;
const PADDLE_HEIGHT: u8 = 4;
const OBJECT_SIZE: u8 = 4;
const OBJECT_FALL_SPEED: u8 = 1;

const WHITE: u16 = 0xFFFF;
const BLACK: u16 = 0x0000;
const red: u16 = 0b1111100000000000;

class Paddle {
  x: u8;
  y: u8;
  color: u16;

  constructor(x: u8, y: u8, color: u16) {
    this.x = x;
    this.y = y;
    this.color = color;
  }

  update(): void {
    if (isButtonPressed(BUTTON_LEFT) && this.x > 0) {
      this.x -= 1;
    } else if (isButtonPressed(BUTTON_RIGHT) && this.x + PADDLE_WIDTH < SCREEN_WIDTH) {
      this.x += 1;
    }
  }

  render(): void {
    FbColor(this.color);
    FbMove(this.x, this.y);
    FbFilledRectangle(PADDLE_WIDTH, PADDLE_HEIGHT);
  }
}

class FallingObject {
  x: u8;
  y: u8;
  speed: u8;
  color: u16;

  constructor() {
    this.reset();
    this.speed = OBJECT_FALL_SPEED;
    this.color = red;
  }

  update(): void {
    this.y += this.speed;
    if (this.y > SCREEN_HEIGHT) {
      this.reset();
    }
  }

  reset(): void {
    this.x = Math_random() * (SCREEN_WIDTH - OBJECT_SIZE) as u8;
    this.y = 0;
  }

  render(): void {
    FbColor(this.color);
    FbMove(this.x, this.y);
    FbFilledRectangle(OBJECT_SIZE, OBJECT_SIZE);
  }

  isCaught(paddle: Paddle): bool {
    return this.y + OBJECT_SIZE >= paddle.y && this.x + OBJECT_SIZE >= paddle.x && this.x <= paddle.x + PADDLE_WIDTH;
  }
}

let paddle = new Paddle(SCREEN_WIDTH / 2 - PADDLE_WIDTH / 2, SCREEN_HEIGHT - 10, WHITE);
let fallingObject = new FallingObject();
let score: u8 = 0;

export function update(): void {
  paddle.update();
  fallingObject.update();

  if (fallingObject.isCaught(paddle)) {
    score++;
    fallingObject.reset();
  }
}

export function render(): void {
  FbClear();
  paddle.render();
  fallingObject.render();
  renderScore(score);
}

function renderScore(score: u8): void {
  FbColor(WHITE);
  FbMove(5, 5);

  let tens = Math.floor(score / 10);
  let ones = score % 10;

  renderDigit(tens as u8, 5, 5);
  renderDigit(ones, 11, 5);
}

function renderDigit(digit: u8, x: u8, y: u8): void {
  FbMove(x, y);
  FbFilledRectangle(5, 7);
}
