#let cea-red      = rgb("#E50019")
#let cea-black    = rgb("#000000")
#let cea-white    = rgb("#FFFFFF")
#let cea-blue     = (
  "dark":  rgb("#3E4A83"),
  "light": rgb("#7E9CBB"),
)
#let cea-yellow   = rgb("#FFCD31")
#let cea-gray     = rgb("#1E1E1E")
#let cea-macaron  = rgb("#DA837B")
#let cea-archipel = rgb("#00939D")
#let cea-opera    = rgb("#BD987A")
#let cea-glycine  = rgb("#A72587")

#let color-palette = (
  red:   cea-red,
  black: cea-black,
  white: cea-white,

  // Secondary colors
  dblue:  cea-blue.dark,
  lblue:  cea-blue.light,
  yellow: cea-yellow,
  gray:   cea-gray,

  // Tertiary colors
  macaron:  cea-macaron,
  archipel: cea-archipel,
  opera:    cea-opera,
  glycine:  cea-glycine,

  // Shortcuts
  text: cea-gray,
  primary: cea-red,
  complementary-dark: cea-blue.dark,
  complementary-light: cea-blue.light,
  secondary: cea-yellow,
)
