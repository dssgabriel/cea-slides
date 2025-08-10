#let raw-data = read("../assets/cea-logo.svg", encoding: none)

#let logo(background, text) = {
  bytes(
    raw-data.slice(0, 383) + bytes(background.to-hex()) + raw-data.slice(390, 404) + bytes(text.to-hex()) + raw-data.slice(411),
  )
}

#let svg-header(width, height) = {
  let start = bytes(
    "<?xml version=\"1.0\" encoding=\"utf-8\"?> <svg version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" x=\"0\" y=\"0\" viewBox=\"0 0 ",
  )
  let middle-0 = bytes("pt ")
  let middle-1 = bytes("pt\" width=\"")
  let middle-2 = bytes("pt\" height=\"")
  let end = bytes("pt\" xml:space=\"preserve\">")

  bytes(
    start + bytes(str(width.abs.pt())) + middle-0 + bytes(str(height.abs.pt())) + middle-1 + bytes(str(width.abs.pt())) + middle-2 + bytes(str(height.abs.pt())) + end,
  )
}

#let svg-style(color) = {
  let start = bytes("<style type=\"text/css\"> .st0{fill:")
  let middle = bytes("; stroke:none;} .st1{fill: none; stroke:")
  let end = bytes("; stroke-width: 0.03;} </style>")

  bytes(start + bytes(color.to-hex()) + middle + bytes(color.to-hex()) + end)
}

#let svg-cube-def = bytes("
<defs><g id=\"cube\" transform=\"matrix(0.5, 0, 0.2994, 0.5988, 0, 0)\">
  <path class=\"st1\" d=\"m 0,0.9 -1,-0.77 0,-0.9 1,-0.77 1,0.77 0,0.9 -1,0.77 z\"/>
  <path class=\"st1\" d=\"m 0,0 0,0.9\"/>
  <path class=\"st1\" d=\"m 0,0 1,-0.77\"/>
  <path class=\"st1\" d=\"m 0,0 -1,-0.77\"/>
  <path class=\"st0\" d=\"m 0,0 0,0.9 -1,-0.77 0,-0.9 1,0.77 z\"/>
</g></defs>")

#let svg-new-cube(x, y) = {
  let start = bytes("<use href=\"#cube\" x=\"")
  let middle = bytes("\" y=\"")
  let end = bytes("\" />")

  bytes(start + bytes(str(x)) + middle + bytes(str(y)) + end)
}

#let svg-cube-group(positions) = {
  let start = bytes("<g transform=\"scale(18, 18) matrix(2, 0, -1, 1.67, 0, 0)\">")
  let end = bytes("</g>")

  bytes(start + positions.map(pos => {
    svg-new-cube(..pos)
  }).sum(default: bytes("")) + end)
}

#let svg-footer = bytes("</svg>")

#let cubes(width, height, color, positions) = {
  bytes(svg-header(width, height) + svg-style(color) + svg-cube-def + svg-cube-group(positions) + svg-footer)
}
