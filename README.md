# SCOPE Application Arena 🎯

A polished, mobile-first live game for SCOPE application workshops. Designed around 8 fast rounds, 20-second decisions, reveal lessons, scoring, a host dashboard, podium and CSV export.

## Included

- Official SCOPE and KazMSA logo assets extracted from the supplied masterclass deck.
- Premium visual system: Space Grotesk + DM Sans, SCOPE blue/navy palette, responsive cards, timers, podium and reveal animations.
- Host mode: `/#host`
- Player mode: `/#play`
- 8 original rounds based on the supplied masterclass: CV specificity, dates, evidence, proof, motivation, specific LC/department reasoning, experience → motivation → goals, and final review.
- Demo mode works without any backend.
- Supabase realtime starter integration and SQL schema for multi-device play.
- CSV export of the top 10/final ranking.

## Run

This is a static site. No build step is required.

### Option A — Python

```bash
python3 -m http.server 5173
```

Open `http://localhost:5173`.

### Option B — VS Code Live Server

Open the folder and serve `index.html`.

## Test the game

1. Open `/#host`.
2. Open another browser tab and `/#play`.
3. Join with a nickname.
4. Start the game.
5. Answer each round and reveal it from the host.
6. Finish the 8 rounds and export the CSV.

The demo mode is intentionally browser-local, so it can be tested without accounts or a database.

## Real 50-phone mode

1. Create a Supabase project.
2. Run `supabase-schema.sql` in Supabase SQL Editor.
3. Put the project URL and anon key in `config.js`:

```js
window.SCOPE_CONFIG = {
  supabaseUrl: 'https://YOUR_PROJECT.supabase.co',
  supabaseAnonKey: 'YOUR_ANON_KEY'
};
```

4. Host `index.html` on GitHub Pages, Vercel, Netlify or another static host.
5. Open the host URL on the projector/laptop and the player URL on phones.

The app uses Supabase Realtime when configured. The UI and game loop still work in demo mode if the backend is unavailable.

## GitHub Pages

Push the entire folder to a repository. Because this is a static app, GitHub Pages can serve it directly. If the repository is named `scope-application-arena`, the site will be available at the repository's Pages URL after enabling Pages from the `main` branch.

## Production hardening

The included SQL policies are prototype-friendly and intentionally open. Before a real public event, tighten RLS, validate room membership, enforce one vote per player/round server-side, keep answer keys out of participant payloads, use server timestamps, and move authoritative scoring to a trusted server/Edge Function.

## Content basis

The game content follows the supplied SCOPE CV & Motivational Letter masterclass: official CV structure, positions with seasons, event/role specificity, evidence and certificates, 250-word motivation structure, and the distinction between general Stage 1 motivation and LC/department-specific Stage 2 motivation.
