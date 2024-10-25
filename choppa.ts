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

@external("Fb", "writeString")
declare function FbWriteString(str: string): void;

@external("Utils", "u8ToString")
declare function u8ToString(value: u8): string;

@external("Fb", "writeCharacter")
declare function FbWriteCharacter(char: u8): void;

const SCREEN_WIDTH: u8 = 128;
const SCREEN_HEIGHT: u8 = 160;

const BUTTON_STATE_ADDR: usize = 0x0000;

const BUTTON_LEFT: u32 = 0x4;
const BUTTON_RIGHT: u32 = 0x8;
const BUTTON_UP: u32 = 0x1;
const BUTTON_X: u32 = 0x40;

function isButtonPressed(buttonMask: u32): bool {
  return (load<u32>(BUTTON_STATE_ADDR) & buttonMask) != 0;
}

const CHOPPER_WIDTH: u8 = 20;
const CHOPPER_HEIGHT: u8 = 10;
const BULLET_WIDTH: u8 = 4;
const BULLET_HEIGHT: u8 = 2;
const BULLET_SPEED: i8 = 2;
const GRAVITY: i8 = 1;
const LIFT: i8 = -2;

const ENEMY_SIZE: u8 = 10;
const MIN_ENEMY_SPEED: i8 = -1;
const MAX_ENEMY_SPEED: i8 = -3;
const MAX_BULLETS: i32 = 5;
const MAX_ENEMIES: i32 = 5;

const WHITE: u16 = 0xFFFF;
const RED: u16 = 0b1111100000000000;
const BLACK: u16 = 0x0000;

class Chopper {
  x: u8;
  y: u8;
  vy: i8;
  color: u16;

  constructor(x: u8, y: u8, color: u16) {
    this.x = x;
    this.y = y;
    this.vy = 0;
    this.color = color;
  }

  update(): void {
    if (isButtonPressed(BUTTON_LEFT) && this.x > 0) {
      this.x -= 1;
    } else if (isButtonPressed(BUTTON_RIGHT) && this.x + CHOPPER_WIDTH < SCREEN_WIDTH) {
      this.x += 1;
    }

    if (isButtonPressed(BUTTON_UP)) {
      this.vy = LIFT;
    } else {
      this.vy = GRAVITY;
    }

    this.y += this.vy;

    if (this.y < 0) this.y = 0;
    if (this.y + CHOPPER_HEIGHT > SCREEN_HEIGHT) this.y = SCREEN_HEIGHT - CHOPPER_HEIGHT;
  }

  render(): void {
    FbColor(this.color);
    FbMove(this.x, this.y);
    FbFilledRectangle(CHOPPER_WIDTH, CHOPPER_HEIGHT);
  }
}

class Bullet {
  x: u8;
  y: u8;
  active: bool;

  constructor(x: u8, y: u8) {
    this.x = x;
    this.y = y;
    this.active = true;
  }

  update(): void {
    if (this.active) {
      this.x += BULLET_SPEED;
      if (this.x > SCREEN_WIDTH) {
        this.active = false;
      }
    }
  }

  render(): void {
    if (this.active) {
      FbColor(WHITE);
      FbMove(this.x, this.y);
      FbFilledRectangle(BULLET_WIDTH, BULLET_HEIGHT);
    }
  }

  reset(x: u8, y: u8): void {
    this.x = x;
    this.y = y;
    this.active = true;
  }
}

class Enemy {
  x: u8;
  y: u8;
  speed: i8;
  active: bool;

  constructor() {
    this.reset();
  }

  update(): void {
    if (this.active) {
      this.x += this.speed;
      if (this.x < 0) {
        this.reset();
      }
    }
  }

  reset(): void {
    this.x = SCREEN_WIDTH - ENEMY_SIZE;
    this.y = Math_random() * (SCREEN_HEIGHT - ENEMY_SIZE) as u8;
    this.speed = Math_random() * (MAX_ENEMY_SPEED - MIN_ENEMY_SPEED) as i8 + MIN_ENEMY_SPEED;
    this.active = true;
  }

  render(): void {
    if (this.active) {
      FbColor(RED);
      FbMove(this.x, this.y);
      FbFilledRectangle(ENEMY_SIZE, ENEMY_SIZE);
    }
  }

  isHit(bullet: Bullet): bool {
    if (this.active && bullet.active && bullet.x + BULLET_WIDTH >= this.x && bullet.x <= this.x + ENEMY_SIZE &&
      bullet.y + BULLET_HEIGHT >= this.y && bullet.y <= this.y + ENEMY_SIZE) {
      this.active = false;
      bullet.active = false;
      return true;
    }
    return false;
  }
}

let chopper = new Chopper(SCREEN_WIDTH / 2 - CHOPPER_WIDTH / 2, SCREEN_HEIGHT / 2, WHITE);
let bullets = new StaticArray<Bullet>(MAX_BULLETS);
let enemies = new StaticArray<Enemy>(MAX_ENEMIES);
let score: u8 = 0;
let nextBullet: i32 = 0;

for (let i: i32 = 0; i < MAX_BULLETS; i++) {
  bullets[i] = new Bullet(0, 0);
}
for (let i: i32 = 0; i < MAX_ENEMIES; i++) {
  enemies[i] = new Enemy();
}

export function update(): void {
  chopper.update();

  if (isButtonPressed(BUTTON_X) && !bullets[nextBullet].active) {
    bullets[nextBullet].reset(chopper.x + CHOPPER_WIDTH, chopper.y + CHOPPER_HEIGHT / 2 - BULLET_HEIGHT / 2);
    nextBullet = (nextBullet + 1) % MAX_BULLETS;
  }

  for (let i: i32 = 0; i < MAX_BULLETS; i++) {
    bullets[i].update();
  }

  for (let i: i32 = 0; i < MAX_ENEMIES; i++) {
    enemies[i].update();
    for (let j: i32 = 0; j < MAX_BULLETS; j++) {
      if (enemies[i].isHit(bullets[j])) {
        score++;
        enemies[i].reset();
        break;
      }
    }
  }
}

export function render(): void {
  FbClear();
  chopper.render();

  for (let i: i32 = 0; i < MAX_BULLETS; i++) {
    bullets[i].render();
  }

  for (let i: i32 = 0; i < MAX_ENEMIES; i++) {
    enemies[i].render();
  }

  FbColor(WHITE);
  renderScore(score);
}

function renderDigitAsChar(digit: u8): u8 {
  return digit + 48;
}

function renderScore(score: u8): void {
  let tens: u8 = score / 10;
  let ones: u8 = score % 10;

  FbMove(5, 5);

  if (tens > 0) {
    FbWriteCharacter(renderDigitAsChar(tens));
  }

  FbWriteCharacter(renderDigitAsChar(ones));
}
