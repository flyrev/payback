# Payback

**AI agents should match your vibe. Continuously.**

Payback is a tiny, always-on instruction layer that makes an agent continuously adapt to the way you are communicating: language, brevity, formality, directness, technical depth, energy, formatting, humor, slang, emoji, and profanity intensity.

It is deliberately **not a persona**. Think of it as a live conversational mirror: every reply starts by looking at your latest message again.

## Install in 10 seconds

### Recommended: always on

If you have Node.js:

```sh
npx --yes github:flyrev/payback
```

That's it. Payback installs globally for:

- OpenAI Codex: `~/.codex/AGENTS.md`
- OpenCode: `~/.config/opencode/AGENTS.md` (or `$XDG_CONFIG_HOME/opencode/AGENTS.md`)
- GitHub Copilot CLI: `~/.copilot/copilot-instructions.md`
- Claude Code: `~/.claude/CLAUDE.md`
- Gemini: `~/.gemini/GEMINI.md`

Start a new agent session after installing. Payback is then ambient instruction context, so you do **not** have to invoke a skill or remember a command on every prompt.

Rerunning the installer updates only the marked Payback block and preserves your other instructions.

### Standard Agent Skill

Payback is also a standard Agent Skill and can be installed with the open skills ecosystem:

```sh
npx skills add flyrev/payback
```

The `skills` CLI supports OpenCode, Claude Code, Codex, Cursor, and many other agents.

**Important:** installing the skill makes Payback available to the agent, but a host decides when a skill is loaded. For Payback's intended **always-on** behavior, use the recommended command above.

### No Node.js?

macOS / Linux:

```sh
curl -fsSL https://raw.githubusercontent.com/flyrev/payback/main/install.sh | sh
```

Windows PowerShell:

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

- **Global instructions** make Payback actually always-on: the rule is loaded for every response.
- **The skill/plugin** makes Payback discoverable and portable. Its skill is intentionally written to apply on every user-facing response, but hosts ultimately control when skills are loaded.

No MCP server, API key, or runtime dependency is required.

## Public use

This repository is public. Colleagues do **not** need access to Christian's private ChatGPT plugin to use Payback.

The fastest installation is `npx --yes github:flyrev/payback`. For a standard skill install instead, use `npx skills add flyrev/payback`.

A public ChatGPT Plugin Directory listing is being prepared separately; that directory publication requires OpenAI publisher verification and legal attestations that cannot be delegated to an AI agent.

## The rule

The canonical contract lives in [PAYBACK.md](PAYBACK.md).

In one sentence:

> Before every reply, re-read the latest user message and match its current vibe.

## Why this shape?

Always-on agent behavior belongs in always-loaded instructions rather than a prompt you have to remember to invoke. Codex loads global `AGENTS.md` instructions, and Copilot CLI supports user-level custom instructions; project-level files make the same contract portable across agent harnesses.

Payback stays intentionally small because an always-on behavior should cost very little context. The fun part is that the tone can change at any time, and Payback should change with it on the next reply.
