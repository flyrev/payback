# Payback

**AI agents should respond _med samme mynt_.**

Payback is a tiny, always-on instruction contract that makes an agent adapt to the way you are communicating: language, brevity, formality, directness, technical depth, formatting, humor, slang, emoji, and profanity intensity.

It is deliberately **not a persona**. It mirrors your communication mode without escalating hostility or overriding safety, accuracy, or higher-priority instructions.

## Install globally

### macOS / Linux

```sh
curl -fsSL https://raw.githubusercontent.com/flyrev/payback/main/install.sh | sh
```

This installs Payback into user-level instruction files for:

- OpenAI Codex: `~/.codex/AGENTS.md`
- GitHub Copilot CLI: `~/.copilot/copilot-instructions.md`
- Claude-style user instructions: `~/.claude/CLAUDE.md`
- Gemini-style user instructions: `~/.gemini/GEMINI.md`

The installer is idempotent. Run it again to update Payback without duplicating the block or deleting your other instructions.

### Windows PowerShell

```powershell
irm https://raw.githubusercontent.com/flyrev/payback/main/install.ps1 | iex
```

## Install into one project

This is useful when you want the behavior to travel with a repository.

### macOS / Linux

```sh
curl -fsSL https://raw.githubusercontent.com/flyrev/payback/main/install.sh | sh -s -- --project .
```

### Windows PowerShell

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/flyrev/payback/main/install.ps1))) -Project .
```

Project installation adds or updates a marked Payback block in:

- `AGENTS.md`
- `CLAUDE.md`
- `GEMINI.md`
- `.github/copilot-instructions.md`

Existing instructions outside the Payback block are preserved.

## Agent Skill / plugin package

Payback is also packaged as an **Agent Plugins 1.0** skills-only plugin:

- `plugin.json` — portable plugin manifest
- `skills/payback/SKILL.md` — reusable Agent Skill
- `.codex-plugin/plugin.json` — compatibility manifest for local/older Codex plugin clients

This is intentionally separate from the global installer:

- **Global instructions** make Payback always-on.
- **The skill/plugin** makes Payback discoverable, portable, and explicitly invokable by compatible agent hosts.

No MCP server, API key, or runtime dependency is required.

## Public use

This repository is public. Colleagues do **not** need access to Christian's private ChatGPT plugin to use Payback.

The fastest installation is still the global installer above. The Agent Plugin source is also public and can be installed by compatible hosts directly from this repository/package.

A public ChatGPT Plugin Directory listing is being prepared separately; that directory publication requires OpenAI publisher verification and legal attestations that cannot be delegated to an AI agent.

## The rule

The canonical contract lives in [PAYBACK.md](PAYBACK.md).

In one sentence:

> Respond *med samme mynt*: match the user's communication mode, but do not escalate beyond it or violate higher-priority constraints.

## Why this shape?

Always-on agent behavior belongs in always-loaded instructions rather than a prompt you have to remember to invoke. Codex loads global `AGENTS.md` instructions, and Copilot CLI supports user-level custom instructions; project-level files make the same contract portable across agent harnesses.

Payback stays intentionally small because an always-on behavior should cost very little context.
