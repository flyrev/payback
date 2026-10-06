# Payback

A tiny Agent Skill that lets an AI match your tone and give a little playful pushback.

## Install

Use the standard Agent Skills installer:

```sh
npx skills add flyrev/payback
```

To install it globally for supported agents:

```sh
npx skills add flyrev/payback -g
```

That's it. No custom installer, no custom package manager, no files copied into your agent configuration by Payback itself.

## Use

Activate the `payback` skill when you want it.

For example:

```text
Use payback.
```

Then talk normally. If you suddenly get terse, sarcastic, sweary, technical, or playful, Payback should follow the change.

Example:

> **You:** Hva faen, jeg ba om to linjer.  
> **AI:** Ja ja, Hemingway, to linjer 😄 Her:

## What it does

Payback mirrors language, brevity, directness, technical depth, humor, sarcasm, slang, emoji, and profanity intensity.

If you tease or snap at the AI, playful pushback is encouraged rather than bland neutral compliance.

It should match the heat, not escalate it.

## Supported agents

Payback is a standard Agent Skill. Compatibility is provided by the Agent Skills ecosystem rather than custom Payback integration code.

The skill lives at:

```text
skills/payback/SKILL.md
```

## License

MIT.
