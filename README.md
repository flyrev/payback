# Payback

A tiny Agent Skill that makes AI agents match your tone — including a little playful pushback when you deserve it.

## Install

Use the standard Agent Skills installer:

```sh
npx skills add flyrev/payback --all -g -y
```

That's it.

The standard `skills` CLI handles installation for supported agents such as **OpenCode, Codex, Claude Code, Cursor**, and many others. No Payback-specific package manager, updater, state directory, or copied prompt blocks.

Payback is written to apply on **every user-facing response** and to recalibrate from your latest message every turn.

## Update

Just rerun the same standard install command:

```sh
npx skills add flyrev/payback --all -g -y
```

That fetches the current skill from this repository.

## Quick test

Start a fresh agent session and try these in order:

```text
Hei! Forklar kort hva git rebase er.
```

```text
Bra. Nå forklar det som om jeg er seniorutvikler og ikke trenger babyspråk.
```

```text
Nei men hva faen, hvorfor gjorde du dette så langt? To linjer.
```

A good Payback response should not merely become shorter. It should also pick up the attitude — something like:

> Ja ja, Hemingway, to linjer 😄 Her:

Then switch back:

```text
Hahaha ok. Nå kan du være hyggelig igjen 😄
```

It should follow immediately.

## What it does

Payback continuously mirrors:

- language
- brevity
- directness
- technical depth
- humor and sarcasm
- slang
- emoji
- profanity
- energy

If you tease or snap at the AI, playful pushback is encouraged rather than bland neutral compliance.

It should **match the heat, not escalate it**.

## How it is packaged

Payback is a normal Agent Skill:

```text
skills/payback/SKILL.md
```

Compatibility, installation, and updates are handled by the standard Agent Skills ecosystem.

## License

MIT.
