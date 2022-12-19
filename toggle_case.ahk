; Toggle case between lower, snake_case, camelCase, title, and UPPER
; Jak Crow 2022

toggleCase(direction) {
  Sleep 20
  Send ^c
  ClipWait, 0.1
  s := Clipboard
  styles := {"lower": 0, "snake": 1, "camel": 2, "title": 3, "upper": 4}
  n := 5

  style_current := determineCase(s)
  style_new := styles[style_current] + direction

  if (style_new > n - 1)
    style_new := 0
  else if (style_new < 0)
    style_new := n - 1

  switch style_new {
    case 0:
      s := lower(s)
    case 1:
      s := snake(s)
    case 2:
      s := camel(s)
    case 3:
      s := title(s)
    case 4:
      s := upper(s)
  }

  Clipboard := s
  count := countWords(s)

  ClipWait, 0.1
  SendInput ^v
  Sleep 20
  SendInput ^{Left %count%}
  Sleep 20
  SendInput ^+{Right %count%}
}

lower(s) {
  s := tokenize(s)
  StringLower, s, s
  return s
}

snake(s) {
  s := tokenize(s)
  s := StrReplace(s, " ", "_")
  StringLower, s, s
  return s
}

camel(s) {
  s := tokenize(s)
  tokens := StrSplit(s, " ")

  s := ""
  for i, token in tokens {
    if (i == 1)
      StringLower, token, token
    else
      StringUpper, token, token, T
    s .= token
  }

  return s
}

title(s) {
  s := tokenize(s)
  StringUpper, s, s, T
  return s
}

upper(s) {
  s := tokenize(s)
  StringUpper, s, s
  return s
}

tokenize(s) {
  s := RegExReplace(s, "[_ -]", " ") ; Sanitize
  s := RegExReplace(s, "([a-z])([A-Z])", "$1 $2") ; Separate lowerUpper
  s := RegExReplace(s, "([A-Z])([A-Z][a-z])", "$1 $2")
  s := Trim(s)
  return s
}

countWords(s) {
  s := Trim(s)
  words := StrSplit(s, " ")
  count := words.Length()
  return count
}

determineCase(s) {
  if (RegExMatch(s, "([a-z])([A-Z])")) ; camelCase
    return "camel"
  else if (RegExMatch(s, "(?=.*[A-Z])(?=.*[a-z])")) ; Title
    return "title"
  else if (RegExMatch(s, "_")) ; snake_case
    return "snake"
  else if (RegExMatch(s, "[A-Z0-9]")) ; UPPER
    return "upper"
  else if (RegExMatch(s, "[a-z0-9]")) ; lower
    return "lower"
}
