workflow "Tests & Linters & Check Formatting" {
  on = "push"
  resolves = ["Test", "nitrino/blabl@master", "nitrino/blabl@master-1"]
}

action "Get Dependencies" {
  uses = "nitrino/blabl@master"
  args = "deps.get"
}

action "Test" {
  uses = "nitrino/blabl@master"
  needs = ["Get Dependencies"]
  args = "test"
  env = {
    MIX_ENV = "test"
  }
}

action "nitrino/blabl@master" {
  uses = "nitrino/blabl@master"
  needs = ["Get Dependencies"]
  args = "credo --strict"
}

action "nitrino/blabl@master-1" {
  uses = "nitrino/blabl@master"
  needs = ["Get Dependencies"]
  args = "sobelow --config"
}
