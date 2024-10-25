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

const GRID_WIDTH: u8 = 32;
const GRID_HEIGHT: u8 = 40;
const CELL_SIZE: u8 = 4;
const GRID_SIZE: u16 = GRID_WIDTH * GRID_HEIGHT;
const BYTE_WIDTH: u8 = 4;

// We pack the cells into bits to save memory (8 cells per byte)
let grid: StaticArray<u8> = new StaticArray<u8>(BYTE_WIDTH * GRID_HEIGHT);
let nextGrid: StaticArray<u8> = new StaticArray<u8>(BYTE_WIDTH * GRID_HEIGHT);

const WHITE: u16 = 0xFFFF;
const BLACK: u16 = 0x0000;

function getCell(x: u8, y: u8, grid: StaticArray<u8>): bool {
  let byteIndex: u16 = y * BYTE_WIDTH + (x >> 3);
  let bitIndex: u8 = x % 8;
  return (grid[byteIndex] & (1 << bitIndex)) != 0;
}

function setCell(x: u8, y: u8, value: bool, grid: StaticArray<u8>): void {
  let byteIndex: u16 = y * BYTE_WIDTH + (x >> 3);
  let bitIndex: u8 = x % 8;
  if (value) {
    grid[byteIndex] |= (1 << bitIndex);
  } else {
    grid[byteIndex] &= ~(1 << bitIndex);
  }
}

function initializeGrid(): void {
  for (let y: u8 = 0; y < GRID_HEIGHT; y++) {
    for (let x: u8 = 0; x < GRID_WIDTH; x++) {
      setCell(x, y, Math_random() > 0.5, grid);
      setCell(x, y, false, nextGrid);
    }
  }
}

function countLiveNeighbors(x: u8, y: u8): u8 {
  let count: u8 = 0;

  for (let dy: i8 = -1; dy <= 1; dy++) {
    for (let dx: i8 = -1; dx <= 1; dx++) {
      if (dx == 0 && dy == 0) continue;

      let nx: i8 = x + dx;
      let ny: i8 = y + dy;

      if (nx >= 0 && nx < (GRID_WIDTH as i8) && ny >= 0 && ny < (GRID_HEIGHT as i8)) {
        if (getCell(nx as u8, ny as u8, grid)) count++;
      }
    }
  }

  return count;
}

function updateGrid(): void {
  for (let y: u8 = 0; y < GRID_HEIGHT; y++) {
    for (let x: u8 = 0; x < GRID_WIDTH; x++) {
      let liveNeighbors = countLiveNeighbors(x, y);
      let cell = getCell(x, y, grid);

      if (cell && (liveNeighbors < 2 || liveNeighbors > 3)) {
        setCell(x, y, false, nextGrid);
      } else if (!cell && liveNeighbors == 3) {
        setCell(x, y, true, nextGrid);
      } else {
        setCell(x, y, cell, nextGrid);
      }
    }
  }
}

function swapGrids(): void {
  for (let i: u16 = 0; i < BYTE_WIDTH * GRID_HEIGHT; i++) {
    grid[i] = nextGrid[i];
  }
}

function renderGrid(): void {
  FbClear();
  for (let y: u8 = 0; y < GRID_HEIGHT; y++) {
    for (let x: u8 = 0; x < GRID_WIDTH; x++) {
      if (getCell(x, y, grid)) {
        FbColor(WHITE);
      } else {
        FbColor(BLACK);
      }
      FbMove(x * CELL_SIZE, y * CELL_SIZE);
      FbFilledRectangle(CELL_SIZE, CELL_SIZE);
    }
  }
}

export function update(): void {
  updateGrid();
  swapGrids();
}

export function render(): void {
  renderGrid();
}

initializeGrid();
