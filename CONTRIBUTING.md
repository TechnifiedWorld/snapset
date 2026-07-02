# Contributing to SnapSet

Thank you for contributing to SnapSet.

SnapSet is a lightweight Windows 11 command-line launcher built in batch script. It provides fast, direct access to settings, system tools, and control panels using `ms-settings:` URIs and selected legacy Windows entry points.

This document explains how to contribute changes consistently and safely.

---

## Development workflow

SnapSet uses a **persistent integration branch** workflow.

- `main` is the stable release branch
- `dev` is the active integration branch
- Do not commit directly to `main`
- All changes should be made on `dev`, then merged into `main` through a Pull Request

### Branch flow

```text
dev -> Pull Request -> main
```

If you are making a change locally:

1. Switch to `dev`
2. Pull the latest changes from `main`
3. Make and test your changes
4. Commit to `dev`
5. Push to GitHub
6. Open a Pull Request into `main`

---

## Requirements

Before contributing, make sure you have:

- Windows 11
- A local clone of the repository
- Basic familiarity with Command Prompt, Git, and GitHub
- Tested the affected command or documentation change manually

---

## Project structure

```text
snapset-cli/
├── docs/                  # Logo and social preview assets
├── scripts/
│   └── snapset.bat       # Main launcher script
├── README.md             # User-facing documentation
├── CHANGELOG.md          # Version history
├── CONTRIBUTING.md       # Contribution guide
└── LICENSE               # MIT license
```

---

## Coding style

When editing `scripts/snapset.bat`, follow these rules:

- Keep the existing short and long alias pattern
- Keep command names concise, readable, and consistent
- Add a `rem` comment above each command or command group explaining what it opens
- Use `if /i` for case-insensitive matching
- Use `start ""` for all `ms-settings:` URIs and legacy launch targets
- Keep related commands grouped by category
- Preserve `setlocal`, `endlocal`, and the shared `:end` exit flow
- Keep help output grouped by category and aligned with the actual command list

---

## New command checklist

Before opening a Pull Request for a new command, confirm all of the following:

- [ ] The `ms-settings:` URI or legacy tool opens the correct page on Windows 11
- [ ] Both short and long aliases are added and follow the existing naming pattern
- [ ] A `rem` comment explains what the command opens and any known caveats
- [ ] The command is added to the built-in help output in the correct category
- [ ] The command is added to the correct command table in `README.md`
- [ ] The `README.md` Tips section is updated if the command benefits from guidance
- [ ] The `README.md` Known Limitations section is updated if the command has caveats
- [ ] The `README.md` Compatibility section is updated if build-specific behaviour applies
- [ ] `CHANGELOG.md` is updated under `[Unreleased]` or the next release section
- [ ] The command has been tested manually before submission

---

## Help and CLI flags

If your change affects script usage or discoverability, also check the following:

- [ ] `snapset` with no arguments still opens the help screen
- [ ] `snapset --help` and `snapset -h` still work correctly
- [ ] `snapset --version` and `snapset -v` still print the expected version
- [ ] Help output remains readable in plain Command Prompt
- [ ] ANSI colour output, if changed, still falls back cleanly when terminal support is not detected

---

## Verifying a `ms-settings:` URI

Before adding a new URI to SnapSet, test it directly.

### Option A, Run dialog

Press `Win + R`, then run:

```text
ms-settings:your-uri-here
```

### Option B, Command Prompt

```cmd
start "" ms-settings:your-uri-here
```

If the correct page opens, the URI is valid on your Windows build.

If Settings opens to the wrong page, redirects to Home, or does nothing useful, do not add the command without documenting the limitation clearly in `README.md` and `CHANGELOG.md`.

---

## Testing expectations

Every functional change should be tested manually before submission.

Minimum checks:

- Run `snapset` and verify the help screen appears
- Run `snapset --help`
- Run `snapset --version`
- Test every new command you added
- Re-test any existing command you modified
- Confirm invalid input still exits with an error

For documentation-only changes, verify that examples match the real command names and script behaviour.

---

## Documentation rules

Whenever a command is added, removed, renamed, or changed, update the related documentation in the same change set.

This usually includes:

- `README.md`
- `CHANGELOG.md`
- `scripts/snapset.bat` help output

Do not merge command changes without updating the docs that describe them.

---

## Commit messages

SnapSet uses [Conventional Commits](https://www.conventionalcommits.org).

Use these prefixes:

- `feat:` for a new command or feature
- `fix:` for a bug fix
- `docs:` for documentation-only changes
- `refactor:` for internal restructuring with no user-facing behaviour change
- `chore:` for maintenance, assets, or housekeeping

### Examples

```text
feat: add startup and optional features commands
fix: route datausage to advanced network settings
docs: update README setup instructions
refactor: group help output by category
chore: update social preview image
```

---

## Pull Requests

When opening a Pull Request:

1. Target `main`
2. Compare from `dev`
3. Review the diff carefully
4. Make sure only intended files changed
5. Use a clear PR title that matches the main commit theme
6. Include a short description for functional changes
7. Confirm the change was tested locally

For SnapSet, Pull Requests are the required review step before release, even for solo development.

---

## Release notes and changelog

SnapSet follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

- Add user-facing changes to `CHANGELOG.md`
- Use `Added`, `Changed`, and `Fixed` sections where appropriate
- Keep unreleased work under `[Unreleased]` until the release is cut
- Move unreleased entries into a dated version section when publishing the release

Examples:

- New commands go under `Added`
- Behaviour adjustments go under `Changed`
- Bug fixes and corrections go under `Fixed`

---

## Scope guidance

SnapSet is focused on fast access to useful Windows 11 settings and admin-relevant entry points.

Good additions usually include:

- Network and connectivity pages
- System settings
- Privacy and security settings
- Device settings
- App management pages
- Useful legacy admin tools

Lower-priority or out-of-scope additions may include:

- Highly specialised hardware-only pages
- Consumer-only features with limited admin value
- URIs that require dynamic runtime parameters
- Pages that are unreliable across common Windows 11 builds

---

## Questions to ask before adding a command

Before adding a new command, ask:

1. Is this page useful enough to justify a dedicated shortcut?
2. Is the alias short, memorable, and consistent?
3. Does the target open reliably on supported Windows 11 builds?
4. Does this overlap with an existing command?
5. Does the README need a tip or limitation note for this command?

If the answer to any of these is unclear, document the concern in the PR.

---

## License

By contributing to this repository, you agree that your contributions will be licensed under the [MIT License](LICENSE).