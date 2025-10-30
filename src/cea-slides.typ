#import "@preview/touying:0.6.1": *

#import "colors.typ": *
#import "graphics.typ": *

#let footer = config-page(footer: self => {
  set text(size: 10pt, fill: self.colors.text)

  let short-title = if self.info.short-title != auto {
    self.info.short-title
  } else {
    self.info.title
  }

  align(bottom, block(width: 100%, height: 40pt, inset: 8pt, fill: self.colors.white, grid(
    align: (center + horizon, left + horizon, left + horizon, center + horizon, left + horizon),
    columns: (4%, 1fr, auto, 4%),
    column-gutter: 1em,
    image(logo(self.colors.primary, self.colors.white), height: 24pt),
    block(width: 100%)[#short-title --- #self.info.authors.at(0).name],
    self.info.conference + [ --- ] + utils.display-info-date(self),
    block(width: 100%, height: 100%, text(weight: "bold", fill: self.colors.primary, context utils.slide-counter.display("1/1", both: true))),
  )))
}, footer-descent: 0%, margin: (bottom: 20pt + 5%))

#let header = config-page(
  header: self => {
    set text(weight: "bold", fill: self.colors.primary, size: 28pt)
    let title = if self.store.title != none {
      utils.call-or-display(self, self.store.title)
    } else {
      utils.display-current-heading(level: 2, numbered: false)
    }

    let cube-postions = (
      (23, 0.5), (24, 0.5),            (26, 0.5), (27, 0.5), (28, 0.5), (29, 0.5), (30, 0.5), (31, 0.5), (32, 0.5),
                                       (27, 1.5), (28, 1.5),            (30, 1.5), (31, 1.5), (32, 1.5), (33, 1.5),
                                                                                   (31, 2.5), (32, 2.5), (33, 2.5),
    )

    align(top, block(width: 100%, height: 70pt, fill: self.colors.white, {
      place(
        top + right,
        layout(size => { image(cubes(size.width, size.height, self.colors.primary, cube-postions)) }),
      )
      block(height: 100%, width: 100%, inset: 1em, title)
    }))
  },
  header-ascent: 0%,
  margin: (top: 50pt + 5%),
)

#let title-slide(config: (:)) = touying-slide-wrapper(self => {
  let affs = self.info.authors.map(author => author.affiliations).flatten().dedup()
  let tmp  = ((name: underline(self.info.authors.at(0).name), email: self.info.authors.at(0).email, affiliations: self.info.authors.at(0).affiliations), ) + self.info.authors.slice(1)
  let auths = tmp.map(author =>
    author.name + super(typographic: false,
      author.affiliations.map(aff =>
        str(affs.position(a => a == aff) + 1)
      ).join[,]
    )
  )

  let fmt-affs = affs.enumerate().map(
    ((i, aff)) => super(str(i + 1)) + [ ] + aff
  ).join[\ ]
  let fmt-auths = auths.join([, ], last: [ & ])

  let body = {
    set text(fill: self.colors.text)
    stack(
      dir: ttb,
      spacing: 5%,
      image(logo(self.colors.primary, self.colors.white), height: 40%),
      v(10%),
      text(size: 36pt, weight: "bold", self.info.title),
      text(size: 24pt, self.info.subtitle),
      v(1fr),
      text(size: 16pt, fmt-auths),
      text(size: 12pt, fmt-affs),
      text(size: 12pt, {
        box(width: 1fr, repeat(" "))
        self.info.conference + [ --- ] + utils.display-info-date(self)
      }),
    )
  }

  let cube-postions = (
    (21, 0.5), (22, 0.5), (23, 0.5), (24, 0.5), (25, 0.5), (26, 0.5), (27, 0.5), (28, 0.5), (29, 0.5), (30, 0.5), (31, 0.5),
    (22, 1.5), (23, 1.5), (24, 1.5), (25, 1.5), (26, 1.5), (27, 1.5), (28, 1.5), (29, 1.5), (30, 1.5), (31, 1.5), (32, 1.5),
    (22, 2.5), (23, 2.5), (24, 2.5), (25, 2.5), (26, 2.5), (27, 2.5), (28, 2.5), (29, 2.5), (30, 2.5), (31, 2.5), (32, 2.5),
    (23, 3.5), (24, 3.5),                       (27, 3.5), (28, 3.5), (29, 3.5), (30, 3.5), (31, 3.5), (32, 3.5), (33, 3.5),
                                                (27, 4.5), (28, 4.5), (29, 4.5), (30, 4.5), (31, 4.5), (32, 4.5), (33, 4.5),
                                                (28, 5.5), (29, 5.5), (30, 5.5), (31, 5.5), (32, 5.5), (33, 5.5), (34, 5.5),
                                                (28, 6.5), (29, 6.5), (30, 6.5), (31, 6.5), (32, 6.5), (33, 6.5), (34, 6.5),
                                                (29, 7.5), (30, 7.5),            (32, 7.5), (33, 7.5), (34, 7.5), (35, 7.5),
                                                                                            (33, 8.5), (34, 8.5), (35, 8.5),
  )

  let background = config-page(fill: self.colors.white, background: place(
    top + right,
    layout(size => { image(cubes(size.width, size.height, self.colors.primary, cube-postions)) }),
  ))

  self = utils.merge-dicts(self, background, config)
  touying-slide(self: self, body)
})

#let end-slide(config: (:), thanks: "Thank you for your attention", questions: "Questions?") = touying-slide-wrapper(self => {
  let main-author = self.info.authors.at(0)
  let body = {
    set text(fill: self.colors.text)
    stack(
      dir: ttb,
      spacing: 5%,
      image(logo(self.colors.primary, self.colors.white), height: 40%),
      v(10%),
      text(size: 36pt, weight: "bold", thanks),
      text(size: 24pt, weight: "bold", questions),
      v(1fr),
      text(size: 16pt, {[
        #text(weight: "bold")[#main-author.affiliations.at(0)] \
        #main-author.name \
        #link("mailto:" + main-author.email)
      ]}),
      text(size: 12pt, {
        box(width: 1fr, repeat(" "))
        self.info.conference + [ --- ] + utils.display-info-date(self)
      }),
    )
  }

  let cube-postions = (
    (21, 0.5), (22, 0.5), (23, 0.5), (24, 0.5), (25, 0.5), (26, 0.5), (27, 0.5), (28, 0.5), (29, 0.5), (30, 0.5), (31, 0.5),
    (22, 1.5), (23, 1.5), (24, 1.5), (25, 1.5), (26, 1.5), (27, 1.5), (28, 1.5), (29, 1.5), (30, 1.5), (31, 1.5), (32, 1.5),
    (22, 2.5), (23, 2.5), (24, 2.5), (25, 2.5), (26, 2.5), (27, 2.5), (28, 2.5), (29, 2.5), (30, 2.5), (31, 2.5), (32, 2.5),
    (23, 3.5), (24, 3.5),                       (27, 3.5), (28, 3.5), (29, 3.5), (30, 3.5), (31, 3.5), (32, 3.5), (33, 3.5),
                                                (27, 4.5), (28, 4.5), (29, 4.5), (30, 4.5), (31, 4.5), (32, 4.5), (33, 4.5),
                                                (28, 5.5), (29, 5.5), (30, 5.5), (31, 5.5), (32, 5.5), (33, 5.5), (34, 5.5),
                                                (28, 6.5), (29, 6.5), (30, 6.5), (31, 6.5), (32, 6.5), (33, 6.5), (34, 6.5),
                                                (29, 7.5), (30, 7.5),            (32, 7.5), (33, 7.5), (34, 7.5), (35, 7.5),
                                                                                            (33, 8.5), (34, 8.5), (35, 8.5),
  )

  let background = config-page(fill: self.colors.white, background: place(
    top + right,
    layout(size => { image(cubes(size.width, size.height, self.colors.primary, cube-postions)) }),
  ))

  self = utils.merge-dicts(self, background, config)
  touying-slide(self: self, body)
})

#let outline-slide(title: auto, config: (:)) = touying-slide-wrapper(
  self => {
    if title == auto {
      self.store.title = "Contents"
    } else {
      self.store.title = title
    }

    let outline = {
      show outline.entry: it => {
        let prefix = text(size: 20pt, weight: "bold", fill: self.colors.primary, str(counter(heading).at(it.element.location()).at(0))) + text(size: 8pt, fill: self.colors.primary, sym.square.filled)
        let inner = text(size: 20pt, weight: "bold", fill: self.colors.text, it.element.body)
        set block(spacing: 2em)

        link(it.element.location(), it.indented(prefix, inner))
      }

      align(top, block(outline(title: "", target: heading.where(level: 1))))
    }

    self = utils.merge-dicts(self, footer, header, config)
    touying-slide(self: self, outline)
  },
)

#let new-section-slide(self: none, body) = touying-slide-wrapper(self => {
  set align(bottom)
  let body = stack(
    dir: ttb,
    grid(
      align: (right + bottom, right + bottom, left + horizon),
      columns: (0.22fr, auto, 0.7fr),
      column-gutter: (1pt, 3em),
      text(weight: "bold", size: 128pt, fill: self.colors.primary, utils.display-current-heading-number(level: 1, numbering: "1")),
      text(weight: "bold", size: 48pt, fill: self.colors.primary, sym.square.filled),
      text(weight: "bold", size: 64pt, utils.display-current-heading(level: 1, numbered: false)),
    ),
    v(75pt + 5em)
  )

  let cube-postions = (
    (0, 0.5), (1, 0.5), (2, 0.5), (3, 0.5), (4, 0.5), (5, 0.5), (6, 0.5), (7, 0.5), (8, 0.5), (9, 0.5), (10, 0.5), (11, 0.5), (12, 0.5), (13, 0.5), (14, 0.5), (15, 0.5), (16, 0.5), (17, 0.5), (18, 0.5), (19, 0.5), (20, 0.5), (21, 0.5), (22, 0.5), (23, 0.5), (24, 0.5), (25, 0.5), (26, 0.5), (27, 0.5), (28, 0.5), (29, 0.5), (30, 0.5), (31, 0.5),
    (1, 1.5), (2, 1.5), (3, 1.5), (4, 1.5), (5, 1.5), (6, 1.5), (7, 1.5), (8, 1.5), (9, 1.5), (10, 1.5), (11, 1.5), (12, 1.5), (13, 1.5), (14, 1.5), (15, 1.5), (16, 1.5), (17, 1.5), (18, 1.5), (19, 1.5), (20, 1.5), (21, 1.5), (22, 1.5), (23, 1.5), (24, 1.5), (25, 1.5), (26, 1.5), (27, 1.5), (28, 1.5), (29, 1.5), (30, 1.5), (31, 1.5), (32, 1.5),
  )

  let background = config-page(fill: self.colors.white, background: {
    layout(size => { image(cubes(size.width, size.height, self.colors.primary, cube-postions)) })
  })

  self = utils.merge-dicts(self, footer, background)

  set text(fill: self.colors.text)
  touying-slide(self: self, body)
})

#let slide(title: auto, config: (:), ..bodies) = touying-slide-wrapper(self => {
  if title != auto {
    self.store.title = title
  }

  self = utils.merge-dicts(self, footer, header, config)

  set text(fill: self.colors.text, size: 14pt)
  touying-slide(self: self, ..bodies)
})

#let cea-theme(
  aspect-ratio: "16-9",
  text-font: "Poppins",
  math-font: "Libertinus Math",
  code-font: "Geist Mono",
  ..args,
  body
) = {
  let colors = config-colors(
    // Neutral colors
    text: color-palette.text,
    black: color-palette.black,
    white: color-palette.white,

    // Primary color
    primary: color-palette.primary,

    // Complementary colors
    complementary-dark: color-palette.complementary-dark,
    complementary-light: color-palette.complementary-light,

    // Secondary color
    secondary: color-palette.secondary,
  )

  let store = config-store(title: none)

  let page = config-page(paper: "presentation-" + aspect-ratio)

  let common = config-common(slide-fn: slide, new-section-slide-fn: new-section-slide, datetime-format: "[year]-[month]-[day]")

  show: touying-slides.with(page, common, colors, store, ..args)

  show math.equation: set text(font: math-font)

  show raw.where(block: false): set text(font: code-font, size: 12pt)
  show raw.where(block: false): box.with(
    fill: luma(240),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )
  show raw.where(block: true): set text(font: code-font, size: 12pt)
  show raw.where(block: true): block.with(
    fill: luma(240),
    inset: 10pt,
    radius: 4pt,
  )

  set heading(numbering: "1.")
  set text(lang: "en", font: text-font)
  set list(marker: x => {
    let markers = (text(fill: color-palette.primary, sym.square.filled), sym.square.filled)
    markers.at(calc.min(x, markers.len() - 1))
  })
  set enum(numbering: "1.")

  body
}
