workflow "Credo & Sobelow & Check Formatting" {
  on = "push"
  resolves = [
    "Credo",
    "Formatter",
    "Sobelow",
    "Codecov upload",
  ]
}

action "Credo" {
  uses = "nitrino/blabl/.github@master"
  args = "credo --strict"
  needs = ["Get Dependencies"]
}

action "Get Dependencies" {
  uses = "nitrino/blabl/.github@master"
  args = "deps.get"
}

action "Formatter" {
  uses = "nitrino/blabl/.github@master"
  args = "format --check-formatted"
  needs = ["Get Dependencies"]
}

action "Sobelow" {
  uses = "nitrino/blabl/.github@master"
  needs = ["Get Dependencies"]
  args = "sobelow --config"
}

action "Codecov" {
  uses = "nitrino/blabl/.github@master"
  needs = ["Get Dependencies"]
  args = "coveralls.json"
}

action "Codecov upload" {
  uses = "nitrino/blabl/.github@master"
  needs = ["Codecov"]
  runs = "\"$*\""
  args = "curl -s https://codecov.io/bash"
}
