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

const PADDLE_WIDTH: u8 = 4;
const PADDLE_HEIGHT: u8 = 25;
const BALL_SIZE: u8 = 4;

const WHITE: u16 = 0xFFFF;
const BLACK: u16 = 0x0000;

const red: u16 = 0b1111100000000000;
const green: u16 = 0b0000011111100000;
const blue: u16 = 0b0000000000011111;
const yellow: u16 = 0b1111111111100000;
const purple: u16 = 0b1111100000011111;
const cyan: u16 = 0b0000011111111111;
const white: u16 = 0b1111111111111111;
const orange: u16 = 0b1111111000000000;

class Ball {
  x: u8;
  y: u8;
  vx: i8;
  vy: i8;

  constructor(x: u8, y: u8, vx: i8, vy: i8) {
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.vy = vy;
  }

  update(): void {
    this.x += this.vx;
    this.y += this.vy;

    if (this.y <= 0 || this.y + BALL_SIZE >= SCREEN_HEIGHT) {
      this.vy *= -1;
    }
  }

  checkPaddleCollision(paddle: Paddle): void {
    if (this.x <= paddle.x + PADDLE_WIDTH && this.x + BALL_SIZE >= paddle.x &&
      this.y + BALL_SIZE >= paddle.y && this.y <= paddle.y + PADDLE_HEIGHT) {
      this.vx *= -1;
    }
  }

  render(): void {
    FbColor(red);
    FbMove(this.x, this.y);
    FbFilledRectangle(BALL_SIZE, BALL_SIZE);
  }
}

class Paddle {
  x: u8;
  y: u8;
  color: u16;
  upButton: u32;
  downButton: u32;

  constructor(x: u8, y: u8, color: u16, upButton: u32, downButton: u32) {
    this.x = x;
    this.y = y;
    this.color = color;
    this.upButton = upButton;
    this.downButton = downButton;
  }

  update(): void {
    if (isButtonPressed(this.upButton) && this.y > 0) {
      this.y -= 1;
    } else if (isButtonPressed(this.downButton) && this.y + PADDLE_HEIGHT < SCREEN_HEIGHT) {
      this.y += 1;
    }
  }

  render(): void {
    FbColor(this.color);
    FbMove(this.x, this.y);
    FbFilledRectangle(PADDLE_WIDTH, PADDLE_HEIGHT);
  }
}

let paddle1 = new Paddle(5, SCREEN_HEIGHT / 2 - PADDLE_HEIGHT / 2, white, BUTTON_UP, BUTTON_DOWN);
let paddle2 = new Paddle(SCREEN_WIDTH - 10, SCREEN_HEIGHT / 2 - PADDLE_HEIGHT / 2, white, BUTTON_Y, BUTTON_X);
let ball = new Ball(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, 1, 1);

export function update(): void {
  paddle1.update();
  paddle2.update();
  ball.update();
  ball.checkPaddleCollision(paddle1);
  ball.checkPaddleCollision(paddle2);
}

export function render(): void {
  FbClear();
  paddle1.render();
  paddle2.render();
  ball.render();
}
