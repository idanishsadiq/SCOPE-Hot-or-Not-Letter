-- SCOPE Application Arena production starter schema.
-- The static build uses room_code as the event-room identifier.
create extension if not exists pgcrypto;
create table if not exists public.rooms(
 id uuid primary key default gen_random_uuid(),
 room_code text unique not null,
 status text not null default 'lobby' check(status in('lobby','active','reveal','finished')),
 current_round integer not null default 0,
 started_at timestamptz,
 max_players integer not null default 50,
 created_at timestamptz not null default now()
);
create table if not exists public.players(
 id uuid primary key,
 room_code text not null references public.rooms(room_code) on delete cascade,
 nickname text not null,
 score integer not null default 0,
 correct_verdicts integer not null default 0,
 correct_tags integer not null default 0,
 total_correct_time bigint not null default 0,
 joined_at timestamptz not null default now(),
 unique(room_code,nickname)
);
create table if not exists public.votes(
 id uuid primary key default gen_random_uuid(),
 room_code text not null references public.rooms(room_code) on delete cascade,
 round_id text not null,
 player_id uuid not null references public.players(id) on delete cascade,
 option text not null,
 tag text,
 response_time_ms integer not null default 0,
 submitted_at timestamptz not null default now(),
 unique(room_code,round_id,player_id)
);
alter table public.rooms enable row level security;
alter table public.players enable row level security;
alter table public.votes enable row level security;
create policy "arena rooms read" on public.rooms for select using(true);
create policy "arena rooms insert" on public.rooms for insert with check(true);
create policy "arena rooms update" on public.rooms for update using(true) with check(true);
create policy "arena players read" on public.players for select using(true);
create policy "arena players insert" on public.players for insert with check(true);
create policy "arena players update" on public.players for update using(true) with check(true);
create policy "arena votes read" on public.votes for select using(true);
create policy "arena votes insert" on public.votes for insert with check(true);
alter publication supabase_realtime add table public.rooms;
alter publication supabase_realtime add table public.players;
alter publication supabase_realtime add table public.votes;
-- SECURITY NOTE: these starter policies are intentionally open for a workshop prototype.
-- Before a public event, tighten RLS to authenticated/anonymous identities and enforce player_id ownership.
