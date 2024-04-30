class Calculator {
  static runAsserts(numbers) {
    numbers.forEach((num) => {
      if (Number.isNaN(Number(num)) || num === null || num === undefined) {
        throw new Error('Not a number');
      }
    });
  }

  static add(a, b) {
    Calculator.runAsserts([a, b]);
    return a + b;
  }

  static sub(a, b) {
    Calculator.runAsserts([a, b]);
    return a - b;
  }

  static mul(a, b) {
    Calculator.runAsserts([a, b]);
    return a * b;
  }

  static div(a, b) {
    Calculator.runAsserts([a, b]);
    if (b === 0) {
      throw new Error('Division by zero');
    }
    return a / b;
  }

  static avg(tab) {
    if (tab.length === 0) {
      throw new Error('Array is empty');
    }
    Calculator.runAsserts(tab);

    const sum = tab.reduce((acc, num) => acc + num, 0);
    return sum / tab.length;
  }
}

module.exports = Calculator;
