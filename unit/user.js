const dayjs = require('dayjs');

class User {
  constructor(email, lastName, firstName, birthDate) {
    this.email = email;
    this.lastName = lastName;
    this.firstName = firstName;
    this.birthDate = birthDate;
  }

  static MIN_AGE = 13;

  #isEmailValid() {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(this.email);
  }

  #isAgeValid() {
    const birthDate = dayjs(this.birthDate);
    const today = dayjs(new Date());
    return today.diff(birthDate, 'year') >= User.MIN_AGE;
  }

  isValid() {
    return (
      this.#isEmailValid() &&
      this.#isAgeValid() &&
      !!this.lastName &&
      !!this.firstName
    );
  }
}

module.exports = User;
