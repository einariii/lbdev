# Lbdev

[![docs](https://github.com/mvkvc/lbdev/actions/workflows/docs.yaml/badge.svg?branch=main)](https://github.com/mvkvc/lbdev/actions/workflows/docs.yaml)
[![ci](https://github.com/mvkvc/lbdev/actions/workflows/ci.yaml/badge.svg?branch=main)](https://github.com/mvkvc/lbdev/actions/workflows/ci.yaml)

Credit to [fast.ai](https://www.fast.ai/) for the original idea in Python with [nbdev](https://github.com/fastai/nbdev). (Go check out their amazing deep learning [course](https://github.com/fastai/fastbook)!)

Use Livebooks to develop and build your Elixir application.

## Why?

Include code, tests, docs, runnable examples, smart cells, and more in the same place and have it all sync to your source files as you expect without breaking your existing tooling and workflows.

## Features

This is a work in progress, but the following features are planned in the approximate order of priority:

- [ ] Extract tagged code blocks in Livebooks to source files.
- [ ] Create new tags with custom paths to extract code to or change the default tag paths.
- [ ] Autogenerate and update a `index.livemd` file that lists every file in sorted order and is auto-linked to the bottom of every Livebook for easy navigation.
- [ ] Add `--sync` option to rebuild all the source files from Livebooks.
- [ ] The `--sync` option runs incrementally and only rebuilds source files from Livebooks that have changed or where the source file is missing.
- [ ] Two-way sync, including changes to source files being reflected in the associated Livebook so that team members are not forced to use Livebooks exclusively.
- [ ] Speed is an important consideration; the sync watcher should be fast enough not to hinder your workflow. Trying to keep this in Elixir only for now, but we may need to use Rust in the future.

## Installation

To add this to your project, add the following to your `mix.exs` file:

```elixir
def deps do
  [
    # ...
    {:lbdev, "~> 0.1.0", only: :dev, runtime: false}
  ]
end
```

## Configuration

The following configuration options are available as inputs in your `mix.exs`:

```elixir
  def project do
    [
      # ...
      lbdev: lbdev(),
    ]
  end

  defp lbdev do
    [
      notebooks: "notebooks", # Folder containing your Livebooks
      tags: [ # Tags are used at the start of a code block like with # BASE:TAG for example # export:lib
        base: "export", # Tag used to identify code blocks to extract
        lib: "lib", # Additional tag to identify code as application code
        test: "test" # Additional tag to identify code as test code
      ]
    ]
  end
```

## Usage

Run `mix lbdev` in another terminal to watch for changes and automatically sync to your source file. If you pull a project locally and want to recreate all the source files, run `mix lbdev --sync`.

It is recommended to create an alias in your `mix.exs` to start the server and run the sync watcher simultaneously:

```elixir
defp aliases do
  [
    # ...
    "lbdev.server": ["cmd livebook server & mix lbdev"]
  ]
end
```

## Dependencies

- Elixir: <https://github.com/elixir-lang/elixir>
- Livebook: <https://github.com/livebook-dev/livebook>
- FileSystem: <https://github.com/falood/file_system>
- Earmark: <https://github.com/pragdave/earmark>
