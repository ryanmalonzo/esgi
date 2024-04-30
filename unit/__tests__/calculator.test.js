const Calculator = require('../calculator');

const DATASET = [
  [null, null],
  [null, 2],
  [null, undefined],
  [2, null],
  ['pokémon', 2],
  [2, 'pokémon'],
];

describe('add', () => {
  test('returns the sum of two numbers', () => {
    expect(Calculator.add(10, 2)).toEqual(12);
  });

  test.each(DATASET)('throws when not a number', (a, b) => {
    expect(() => Calculator.add(a, b)).toThrow('Not a number');
  });
});

describe('sub', () => {
  test('returns the difference between two numbers', () => {
    expect(Calculator.sub(10, 2)).toEqual(8);
  });

  test.each(DATASET)('throws when not a number', (a, b) => {
    expect(() => Calculator.sub(a, b)).toThrow('Not a number');
  });
});

describe('mul', () => {
  test('returns the product of two numbers', () => {
    expect(Calculator.mul(10, 2)).toEqual(20);
  });

  test.each(DATASET)('throws when not a number', (a, b) => {
    expect(() => Calculator.mul(a, b)).toThrow('Not a number');
  });
});

describe('div', () => {
  test('returns the division of two numbers', () => {
    expect(Calculator.div(10, 2)).toEqual(5);
  });

  test('throws when dividing by zero', () => {
    expect(() => Calculator.div(10, 0)).toThrow('Division by zero');
  });

  test.each(DATASET)('throws when not a number', (a, b) => {
    expect(() => Calculator.div(a, b)).toThrow('Not a number');
  });
});

describe('avg', () => {
  test('returns the average of an array of numbers', () => {
    expect(Calculator.avg([10, 10, 0, 0])).toEqual(5);
  });

  test('throws when array empty', () => {
    expect(() => Calculator.avg([])).toThrow('Array is empty');
  });

  test('throws when not a number', () => {
    expect(() => Calculator.avg([10, 'pokémon', 0, 5])).toThrow('Not a number');
    expect(() => Calculator.avg([null, 10, 0, 5])).toThrow('Not a number');
    expect(() => Calculator.avg([10, 0, 5, undefined])).toThrow('Not a number');
  });
});
