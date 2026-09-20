#import "@preview/cetz:0.5.2"
#import "@preview/cetz-venn:0.2.0"
#import "@preview/mousse-notes:1.1.0": thm-env, smallcaps-strong

#let definition = thm-env("Definition", fmt: smallcaps-strong)
#let example-plain = thm-env("Example", fmt: it => strong(it), numbered: false)

#let bg = rgb("#1a1917")
#let fg = rgb("#e8e0d4")
#let comment = rgb("#8b9a7d")

#let recolor-stroke(s) = {
  if s == none {
    none
  } else if s == black {
    fg
  } else if type(s) == color {
    if s == black { fg } else { s }
  } else if type(s) == length {
    stroke(paint: fg, thickness: s)
  } else if type(s) == dictionary {
    let out = (:)
    for (k, v) in s {
      out.insert(k, recolor-stroke(v))
    }
    out
  } else {
    let p = s.paint
    stroke(
      paint: if p == black or p == none { fg } else { p },
      thickness: s.thickness,
      cap: s.cap,
      join: s.join,
      dash: s.dash,
      miter-limit: s.miter-limit,
    )
  }
}

#let uses-black(s) = {
  if s == none {
    false
  } else if s == black {
    true
  } else if type(s) == color {
    s == black
  } else if type(s) == dictionary {
    s.values().any(uses-black)
  } else if type(s) == stroke {
    s.paint == black or s.paint == none
  } else {
    false
  }
}

#let venn2-fig(length: 1cm, ..args) = align(center, cetz.canvas(length: length, {
  import cetz.draw: *
  cetz-venn.venn2(name: "venn", fill: bg, stroke: fg, ..args)
  content("venn.a", [$A$])
  content("venn.b", [$B$])
  content("venn.not-ab", [$U$])
}))

#let math-venn(math, diagram) = align(center, block(
  width: 80%,
  grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
    align: center + horizon,
    math,
    diagram,
  ),
))

#let venn3-fig(length: 1cm, ..args) = align(center, cetz.canvas(length: length, {
  import cetz.draw: *
  cetz-venn.venn3(name: "venn", fill: bg, stroke: fg, ..args)
  content("venn.a", [$A$])
  content("venn.b", [$B$])
  content("venn.c", [$C$])
  content("venn.not-abc", [$U$])
}))

#let venn4(..args, name: none) = {
  import cetz.draw: *

  group(name: name, ctx => {
    let named = args.named()
    let fill = named.at("fill", default: white)
    let stroke = named.at("stroke", default: auto)
    let padding = named.at("padding", default: 2em)
    let distance = named.at("distance", default: 0.62)
    let radius = named.at("radius", default: 1)
    let anchor-outset = named.at("anchor-outset", default: 0.35)

    let pad = cetz.util.as-padding-dict(padding)
    for (k, v) in pad {
      pad.insert(k, cetz.util.resolve-number(ctx, v))
    }
    distance = cetz.util.resolve-number(ctx, distance)
    radius = cetz.util.resolve-number(ctx, radius)
    anchor-outset = cetz.util.resolve-number(ctx, anchor-outset)

    let pos-a = (-distance, distance)
    let pos-b = (distance, distance)
    let pos-c = (-distance, -distance)
    let pos-d = (distance, -distance)

    let a = circle(pos-a, radius: radius, fill: none, stroke: none)
    let b = circle(pos-b, radius: radius, fill: none, stroke: none)
    let c = circle(pos-c, radius: radius, fill: none, stroke: none)
    let d = circle(pos-d, radius: radius, fill: none, stroke: none)

    let f(key) = named.at(key + "-fill", default: fill)
    let s(key, default: none) = named.at(key + "-stroke", default: default)

    on-layer(-2, rect(
      (-distance - radius - pad.left, -distance - radius - pad.bottom),
      (distance + radius + pad.right, distance + radius + pad.top),
      fill: f("not-abcd"),
      stroke: s("not-abcd", default: stroke),
      name: "frame",
    ))

    on-layer(0, boolean(a, { b; c; d }, op: "difference", name: "a", ignore-hidden: false, fill: f("a"), stroke: s("a", default: stroke)))
    on-layer(0, boolean(b, { a; c; d }, op: "difference", name: "b", ignore-hidden: false, fill: f("b"), stroke: s("b", default: stroke)))
    on-layer(0, boolean(c, { a; b; d }, op: "difference", name: "c", ignore-hidden: false, fill: f("c"), stroke: s("c", default: stroke)))
    on-layer(0, boolean(d, { a; b; c }, op: "difference", name: "d", ignore-hidden: false, fill: f("d"), stroke: s("d", default: stroke)))

    on-layer(-1, boolean(boolean(a, b, op: "intersection"), { c; d }, op: "difference", name: "ab", ignore-hidden: false, fill: f("ab"), stroke: s("ab")))
    on-layer(-1, boolean(boolean(a, c, op: "intersection"), { b; d }, op: "difference", name: "ac", ignore-hidden: false, fill: f("ac"), stroke: s("ac")))
    on-layer(-1, boolean(boolean(a, d, op: "intersection"), { b; c }, op: "difference", name: "ad", ignore-hidden: false, fill: f("ad"), stroke: s("ad")))
    on-layer(-1, boolean(boolean(b, c, op: "intersection"), { a; d }, op: "difference", name: "bc", ignore-hidden: false, fill: f("bc"), stroke: s("bc")))
    on-layer(-1, boolean(boolean(b, d, op: "intersection"), { a; c }, op: "difference", name: "bd", ignore-hidden: false, fill: f("bd"), stroke: s("bd")))
    on-layer(-1, boolean(boolean(c, d, op: "intersection"), { a; b }, op: "difference", name: "cd", ignore-hidden: false, fill: f("cd"), stroke: s("cd")))

    on-layer(-1, boolean(boolean(boolean(a, b, op: "intersection"), c, op: "intersection"), d, op: "difference", name: "abc", ignore-hidden: false, fill: f("abc"), stroke: s("abc")))
    on-layer(-1, boolean(boolean(boolean(a, b, op: "intersection"), d, op: "intersection"), c, op: "difference", name: "abd", ignore-hidden: false, fill: f("abd"), stroke: s("abd")))
    on-layer(-1, boolean(boolean(boolean(a, c, op: "intersection"), d, op: "intersection"), b, op: "difference", name: "acd", ignore-hidden: false, fill: f("acd"), stroke: s("acd")))
    on-layer(-1, boolean(boolean(boolean(b, c, op: "intersection"), d, op: "intersection"), a, op: "difference", name: "bcd", ignore-hidden: false, fill: f("bcd"), stroke: s("bcd")))

    on-layer(-1, boolean(
      boolean(boolean(a, b, op: "intersection"), c, op: "intersection"),
      d,
      op: "intersection",
      name: "abcd",
      ignore-hidden: false,
      fill: f("abcd"),
      stroke: s("abcd"),
    ))

    anchor("a", ((0, 0), distance + anchor-outset, pos-a))
    anchor("b", ((0, 0), distance + anchor-outset, pos-b))
    anchor("c", ((0, 0), distance + anchor-outset, pos-c))
    anchor("d", ((0, 0), distance + anchor-outset, pos-d))
    anchor("ab", ("a", 50%, "b"))
    anchor("ac", ("a", 50%, "c"))
    anchor("ad", ("a", 50%, "d"))
    anchor("bc", ("b", 50%, "c"))
    anchor("bd", ("b", 50%, "d"))
    anchor("cd", ("c", 50%, "d"))
    anchor("abc", ("a", 50%, "c"))
    anchor("abd", ("a", 50%, "b"))
    anchor("acd", ("c", 50%, "d"))
    anchor("bcd", ("b", 50%, "d"))
    anchor("abcd", (0, 0))
    anchor("not-abcd", (rel: (pad.left / 2, pad.bottom / 2), to: "frame.south-west"))
  })
}

#let venn4-fig(..args) = align(center, cetz.canvas({
  import cetz.draw: *
  venn4(name: "venn", fill: bg, stroke: fg, ..args)
  content("venn.a", [$A$])
  content("venn.b", [$B$])
  content("venn.c", [$C$])
  content("venn.d", [$D$])
  content("venn.not-abcd", [$U$])
}))

#let venn(body) = {
  let content-to-expr(it) = {
    if type(it) == str {
      it
    } else if type(it) != content {
      str(it)
    } else if it.has("text") {
      it.text
    } else if it.func() == space or it.func() == linebreak or it.func() == parbreak {
      " "
    } else {
      let inner = if it.has("children") {
        it.children.map(content-to-expr).join(" ")
      } else if it.has("body") {
        content-to-expr(it.body)
      } else if it.has("child") {
        content-to-expr(it.child)
      } else if it.has("base") {
        content-to-expr(it.base)
      } else {
        ""
      }
      if repr(it.func()).contains("overline") {
        "overline(" + inner + ")"
      } else {
        inner
      }
    }
  }

  let norm-tok(t) = {
    let x = lower(t)
    if x == "empty" { "emptyset" }
    else if x == "universe" { "U" }
    else if x == "complement" { "overline" }
    else if x == "sect" { "inter" }
    else if x.len() == 1 and x in "abcd" { upper(x) }
    else if x == "u" { "U" }
    else { x }
  }

  let tokenize(s) = {
    let re = regex("^(?i)(?:emptyset|overline|complement|universe|without|triangle|empty|inter|union|sect|not|[abcdU()~'])")
    let rec(rest, tokens) = {
      let rest = rest.replace(regex("^\\s+"), "")
      if rest.len() == 0 {
        tokens
      } else {
        let m = rest.match(re)
        if m == none {
          panic("venn: unexpected '" + rest.slice(0, 1) + "'")
        }
        rec(rest.slice(m.end), tokens + (norm-tok(m.text),))
      }
    }
    rec(s, ())
  }

  let parse(tokens, i, min-bp) = {
    if i >= tokens.len() {
      panic("venn: unexpected end of expression")
    }
    let tok = tokens.at(i)
    let prefix = if tok == "(" {
      let (inner, j) = parse(tokens, i + 1, 0)
      if j >= tokens.len() or tokens.at(j) != ")" {
        panic("venn: missing ')'")
      }
      (inner, j + 1)
    } else if tok == "overline" or tok == "not" or tok == "~" {
      let (inner, j) = parse(tokens, i + 1, 50)
      ((kind: "complement", inner: inner), j)
    } else if tok == "emptyset" {
      ((kind: "empty"), i + 1)
    } else if tok == "U" {
      ((kind: "universe"), i + 1)
    } else if tok == "A" or tok == "B" or tok == "C" or tok == "D" {
      ((kind: "set", name: tok), i + 1)
    } else {
      panic("venn: unexpected '" + tok + "'")
    }

    let rest(left, i) = {
      if i >= tokens.len() {
        (left, i)
      } else {
        let op = tokens.at(i)
        let bp = if op == "union" { 10 } else if op == "without" or op == "triangle" { 20 } else if op == "inter" { 30 } else if op == "'" { 40 } else { none }
        if bp == none or bp < min-bp {
          (left, i)
        } else if op == "'" {
          rest((kind: "complement", inner: left), i + 1)
        } else {
          let (right, j) = parse(tokens, i + 1, bp + 1)
          rest((kind: op, left: left, right: right), j)
        }
      }
    }

    rest(prefix.at(0), prefix.at(1))
  }

  let eval-ast(ast, mem) = {
    let k = ast.kind
    if k == "set" { mem.at(ast.name) }
    else if k == "universe" { true }
    else if k == "empty" { false }
    else if k == "complement" { not eval-ast(ast.inner, mem) }
    else if k == "union" { eval-ast(ast.left, mem) or eval-ast(ast.right, mem) }
    else if k == "inter" { eval-ast(ast.left, mem) and eval-ast(ast.right, mem) }
    else if k == "without" { eval-ast(ast.left, mem) and not eval-ast(ast.right, mem) }
    else if k == "triangle" {
      let l = eval-ast(ast.left, mem)
      let r = eval-ast(ast.right, mem)
      (l and not r) or (not l and r)
    } else {
      false
    }
  }

  let collect(ast) = {
    let k = ast.kind
    if k == "set" { (ast.name,) }
    else if k == "complement" { collect(ast.inner) }
    else if k in ("union", "inter", "without", "triangle") {
      collect(ast.left) + collect(ast.right)
    } else { () }
  }

  let region-name(mask, n) = {
    if mask == 0 {
      ("not-ab", "not-abc", "not-abcd").at(n - 2)
    } else {
      let parts = ()
      if calc.rem(mask, 2) == 1 { parts.push("a") }
      if calc.rem(calc.quo(mask, 2), 2) == 1 { parts.push("b") }
      if n >= 3 and calc.rem(calc.quo(mask, 4), 2) == 1 { parts.push("c") }
      if n >= 4 and calc.rem(calc.quo(mask, 8), 2) == 1 { parts.push("d") }
      parts.join()
    }
  }

  let expr = content-to-expr(body)
    .replace("∩", " inter ")
    .replace("∪", " union ")
    .replace("∖", " without ")
    .replace("△", " triangle ")
    .replace("∆", " triangle ")
    .replace("Δ", " triangle ")
    .replace("∅", " emptyset ")
    .replace("¬", " not ")
    .replace("′", "'")
    .replace(regex("\\s+"), " ")
    .trim()

  if expr.len() == 0 {
    panic("venn: empty expression")
  }

  let tokens = tokenize(expr)
  let (ast, i) = parse(tokens, 0, 0)
  if i < tokens.len() {
    panic("venn: unexpected '" + tokens.at(i) + "'")
  }

  let names = collect(ast)
  let n = if "D" in names { 4 } else if "C" in names { 3 } else { 2 }
  let fills = (:)
  for mask in range((4, 8, 16).at(n - 2)) {
    if eval-ast(ast, (
      A: calc.rem(calc.quo(mask, 1), 2) == 1,
      B: calc.rem(calc.quo(mask, 2), 2) == 1,
      C: calc.rem(calc.quo(mask, 4), 2) == 1,
      D: calc.rem(calc.quo(mask, 8), 2) == 1,
    )) {
      fills.insert(region-name(mask, n) + "-fill", gray)
    }
  }

  {
    set figure(numbering: none)
    figure(
      if n == 2 { venn2-fig(..fills) }
      else if n == 3 { venn3-fig(..fills) }
      else { venn4-fig(..fills) },
      caption: eval(expr, mode: "math"),
    )
  }
}

#let pascal-triangle-fig(rows: 5) = align(center, cetz.canvas({
  import cetz.draw: *

  let dx = 2.3
  let dy = 2.0
  let accent = rgb("#d4a574")
  let muted = comment.transparentize(25%)

  let id(n, k) = "n" + str(n) + "k" + str(k)
  let xy(n, k) = ((k - n / 2) * dx, -n * dy)
  let highlighted(n, k) = (n == 1 and (k == 0 or k == 1)) or (n == 2 and k == 1)
  let highlight-edge(n, k, nn, kk) = {
    (n == 1 and k == 0 and nn == 2 and kk == 1) or (n == 1 and k == 1 and nn == 2 and kk == 1)
  }

  for n in range(rows) {
    for k in range(n + 1) {
      content(
        xy(n, k),
        text(fill: if highlighted(n, k) { accent } else { fg })[$vec(#[#n], #[#k])$],
        name: id(n, k),
      )
    }
  }

  on-layer(-1, {
    for n in range(rows - 1) {
      for k in range(n + 1) {
        for (nn, kk) in ((n + 1, k), (n + 1, k + 1)) {
          let hl = highlight-edge(n, k, nn, kk)
          line(
            id(n, k) + ".south",
            id(nn, kk) + ".north",
            stroke: (paint: if hl { accent } else { muted }, thickness: if hl { 1.1pt } else { 0.55pt }),
            mark: (end: (symbol: "stealth", fill: if hl { accent } else { muted }, scale: if hl { 0.7 } else { 0.5 })),
          )
        }
      }
    }
  })

  let (x1, y1) = xy(1, 0)
  let (_, yc) = xy(2, 1)
  content(((x1 + xy(1, 1).at(0)) / 2, (y1 + yc) / 2), text(fill: accent, size: 1.1em)[$+$])
}))

#let lecture-counter = counter("lecture")

#let lecture(date) = {
  lecture-counter.step()
  heading(level: 1, supplement: date)[
    Lecture #context lecture-counter.display()
  ]
}

#let lecture-headings(body) = {
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    set text(weight: "regular", hyphenate: false)
    set par(first-line-indent: 0em)
    counter(footnote).update(0)
    counter("moussethm-thmlike").update(0)
    counter("moussethm-example").update(0)
    counter(figure.where(kind: table)).update(0)
    block(
      inset: (left: -0.2em),
      height: 15% - 1em,
      {
        set text(size: 2em)
        emph(it.body)
      }
        + if it.outlined {
          emph[
            #v(0.9em, weak: true)
            #h(0.125em)#it.supplement
          ]
        },
    )
  }
  body
}

#let theme(body) = {
  set page(paper: "us-letter", fill: bg)
  set text(fill: fg)
  set table(stroke: fg)
  set table.hline(stroke: fg)
  show line: it => {
    if it.stroke.paint != black { it } else {
      let f = it.fields()
      f.insert("stroke", recolor-stroke(it.stroke))
      line(..f)
    }
  }
  show block: it => {
    if not uses-black(it.stroke) { it } else {
      let f = it.fields()
      let body = f.remove("body")
      f.insert("stroke", recolor-stroke(it.stroke))
      block(..f, body)
    }
  }
  set raw(theme: none)
  show raw: set block(fill: rgb("#252320"))
  show raw: it => {
    set text(fill: fg)
    it
  }
  body
}
