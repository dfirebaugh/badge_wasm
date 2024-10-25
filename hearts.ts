
@external("Fb", "clear")
declare function FbClear(): void;

@external("Fb", "color")
declare function FbColor(color: u16): void;

@external("Fb", "move")
declare function FbMove(x: u8, y: u8): void;

@external("Fb", "filledCircle")
declare function FbFilledCircle(x: i32, y: i32, r: i32): void;

@external("Fb", "filledRectangle")
declare function FbFilledRectangle(width: u8, height: u8): void;

const SCREEN_WIDTH: u8 = 128;
const SCREEN_HEIGHT: u8 = 160;

const BUTTON_STATE_ADDR: usize = 0x0000;

const BUTTON_UP: u32 = 0x1;

function isButtonPressed(buttonMask: u32): bool {
  return (load<u32>(BUTTON_STATE_ADDR) & buttonMask) != 0;
}

const HEART_WIDTH: u8 = 10;
const HEART_HEIGHT: u8 = 8;
const MAX_HEARTS: i32 = 10;

const RED: u16 = 0b1111100000000000;
const WHITE: u16 = 0b1111111111111111;

class Heart {
  x: u8;
  y: u8;
  vx: i8;
  vy: i8;
  color: u16;

  constructor(x: u8, y: u8, color: u16, vx: i8, vy: i8) {
    this.x = x;
    this.y = y;
    this.color = color;
    this.vx = vx;
    this.vy = vy;
  }

  update(): void {
    this.x += this.vx;
    this.y += this.vy;

    if (this.x <= 0 || this.x + HEART_WIDTH >= SCREEN_WIDTH) this.vx *= -1;
    if (this.y <= 0 || this.y + HEART_HEIGHT >= SCREEN_HEIGHT) this.vy *= -1;
  }

  render(): void {
    FbColor(this.color);
    FbMove(this.x, this.y);
    FbFilledCircle(this.x + 2, this.y + 2, 3);
    FbFilledCircle(this.x + 7, this.y + 2, 3);
    FbMove(this.x, this.y + 3);
    FbFilledRectangle(HEART_WIDTH, HEART_HEIGHT / 2);
  }
}

let hearts: Heart[] = [];

function addHeart(): void {
  if (hearts.length < MAX_HEARTS) {
    let x = Math.random() * (SCREEN_WIDTH - HEART_WIDTH) as u8;
    let y = Math.random() * (SCREEN_HEIGHT - HEART_HEIGHT) as u8;
    let vx = (Math.random() * 2 + 1) as i8 * (Math.random() < 0.5 ? -1 : 1);
    let vy = (Math.random() * 2 + 1) as i8 * (Math.random() < 0.5 ? -1 : 1);
    hearts.push(new Heart(x, y, RED, vx, vy));
  }
}

export function update(): void {
  if (isButtonPressed(BUTTON_UP)) {
    addHeart();
  }

  for (let i = 0; i < hearts.length; i++) {
    hearts[i].update();
  }
}

export function render(): void {
  FbClear();

  for (let i = 0; i < hearts.length; i++) {
    hearts[i].render();
  }
}
