module.exports = {
  plugins: {
    tailwindcss: {
      content: [
        './public/*.html',
        './app/helpers/**/*.rb',
        './app/frontend/*.{ts,tsx}',
        './app/frontend/**/*.{ts,tsx}',
        './app/views/**/*.{erb,haml,html,slim}'
      ],
      plugins: [
        require('@tailwindcss/typography'),
        require('@tailwindcss/forms'),
        require('@tailwindcss/aspect-ratio'),
        require('@tailwindcss/container-queries'),
        require('daisyui')
      ]
    },
    autoprefixer: {},
  },
}