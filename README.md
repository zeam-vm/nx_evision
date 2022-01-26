# NxEvision

A bridge between [Nx](https://github.com/elixir-nx/nx) and [evision](https://github.com/cocoa-xu/evision).

## Installation

In order to use `NxEvision`, you will need Elixir installed.
Then create an Elixir project (in this case, it is named `my_app`, but you can rename it, freely.) via the mix build tool:

```zsh
mix new my_app
```

Then you can add `NxEvision` as dependency in your `mix.exs`.
At the moment you will have to use a Git dependency while we work on our first release:

```elixir
def deps do
  [
    {:nx_evision, "~> 0.1.0-dev", github: "zeam-vm/nx_evision", branch: "main"},
    {:evision, "~> 0.1.0-dev", github: "cocoa-xu/evision", branch: "main"}
  ]
end
```

Then, you will need to install them and to copy the following configuration file:

```zsh
mix deps.get
cp -a deps/evision/config config/evision.exs
```

Finally, you will need to edit your `config.exs` to add the following fragment:

```elixir
import_config "evision.exs"
```

You can generate Documentation with [ExDoc](https://github.com/elixir-lang/ex_doc), as follows:

```zsh
mix docs
open doc/index.html
```

This document will be published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/nx_evision>.

## License

Copyright (c) 2021 Susumu Yamazaki

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
