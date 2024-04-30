const User = require('../user');

describe('isValid', () => {
  test.each([
    ['ryan.malonzo', false],
    ['ryanmalonzo@', false],
    ['@yahoo.fr', false],
    ['ryan.malonzo@outlook', false],
    ['ryan@@@malonzo.fr', false],
    ['ryan.malonzo@outlook.com', true],
  ])('isEmailValid', (email, expectedValue) => {
    const user = new User(email, 'Malonzo', 'Ryan', new Date('June 4, 2001'));

    expect(user.isValid()).toEqual(expectedValue);
  });

  test.each([
    [new Date('June 4, 2023'), false],
    [new Date('2024-12-17T03:24:00'), false],
    [new Date(2012, 5, 4), false],
    [new Date(2001, 5, 4), true],
    [new Date('June 4, 2001'), true],
    [new Date('1995-12-17T03:24:00'), true],
  ])('isAgeValid', (age, expectedValue) => {
    const user = new User('ryan.malonzo@outlook.com', 'Malonzo', 'Ryan', age);

    expect(user.isValid()).toEqual(expectedValue);
  });

  test.each([
    [
      new User('ryan.malonzo@outlook.', null, 'Ryan', new Date('June 4, 2001')),
      false,
    ],
    [
      new User(
        'ryan.malonzo@outlook.com',
        'Malonzo',
        null,
        new Date('June 4, 2021'),
      ),
      false,
    ],
    [new User('ryan.com', null, null, new Date('June 4, 2021')), false],
    [
      new User(
        'ryan.malonzo@outlook.com',
        'Malonzo',
        'Ryan',
        new Date('June 4, 2001'),
      ),
      true,
    ],
  ])('isValid', (user, expectedValue) => {
    expect(user.isValid()).toEqual(expectedValue);
  });
});
