-- Mon Carnet Routier : stockage privé par compte
-- À exécuter dans le SQL Editor du projet Supabase.

create table if not exists public.carnet_utilisateur (
  user_id uuid primary key references auth.users(id) on delete cascade,
  jours jsonb not null default '[]'::jsonb,
  tarif_repas text,
  tarif_nuitee text,
  updated_at timestamptz not null default now(),
  constraint carnet_jours_est_tableau check (jsonb_typeof(jours) = 'array')
);

alter table public.carnet_utilisateur enable row level security;

-- Chaque compte ne peut lire et modifier que sa propre ligne.
drop policy if exists "Lire son propre carnet" on public.carnet_utilisateur;
create policy "Lire son propre carnet"
  on public.carnet_utilisateur for select
  to authenticated
  using (auth.uid() = user_id);

drop policy if exists "Créer son propre carnet" on public.carnet_utilisateur;
create policy "Créer son propre carnet"
  on public.carnet_utilisateur for insert
  to authenticated
  with check (auth.uid() = user_id);

drop policy if exists "Modifier son propre carnet" on public.carnet_utilisateur;
create policy "Modifier son propre carnet"
  on public.carnet_utilisateur for update
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Supprimer son propre carnet" on public.carnet_utilisateur;
create policy "Supprimer son propre carnet"
  on public.carnet_utilisateur for delete
  to authenticated
  using (auth.uid() = user_id);

grant select, insert, update, delete on public.carnet_utilisateur to authenticated;
revoke all on public.carnet_utilisateur from anon;

-- Aucun secret de service ne doit être placé dans index.html.
