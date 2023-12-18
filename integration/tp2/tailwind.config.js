/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["**/*.html"],
  theme: {
    extend: {
      colors: {
        'dark-blue': '#1E293A',
        'light-blue': '#5D7A97',
        'light-green': '#00FFBF',
        'dark-green': '#00D5D5',
        'pink': '#FF2896',
        'orange': '#FF9B65',
      },
      backgroundImage: {
        "gradient-187":
          "linear-gradient(-187deg,var(--tw-gradient-from) 0%, var(--tw-gradient-to) 60%)",
      },
    },
  },
  plugins: [],
};
