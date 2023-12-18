/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./public/**/*.{html,js}"],
  theme: { 
    extend: {
        colors: {
            "magenta": "#B52DAF",
            "input": "#F1F5F9",
            "purple": "#6922C5",
            "gray": "#9CA3AF",
        },
        spacing: {
            "14px": "14px",
            "18px": "18px",
            "26px": "26px",
            "72px": "72px",
            "90px": "90px",
            "120px": "120px",
            "704px": "704px"
        },
    },
  },
  plugins: [],
}

