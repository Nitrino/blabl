FROM elixir:1.8.1

LABEL "repository"="https://github.com/Nitrino/blabl"
LABEL "homepage"="https://github.com/Nitrino/blabl"
LABEL "maintainer"="Petr Stepchenko <nitrinodev@gmail.com>"

LABEL "com.github.actions.name"="Elixir mix"
LABEL "com.github.actions.description"="An action for running Elixir mix commands"
LABEL "com.github.actions.icon"="droplet"
LABEL "com.github.actions.color"="purple"

# Set MIX_HOME outside of the user home directory.
ARG MIX_HOME=/.mix
ENV MIX_HOME=$MIX_HOME

# Set MIX_ENV to "dev" by default.
ARG MIX_ENV=test
ENV MIX_ENV=$MIX_ENV

# Install rebar and hex locally in MIX_HOME.
RUN mix local.rebar --force
RUN mix local.hex --force

# Copy our entrypoint script.
COPY entrypoint.sh /entrypoint.sh

# Set the entrypoint script as our entrypoint.
ENTRYPOINT ["/entrypoint.sh"]
