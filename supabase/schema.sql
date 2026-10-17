-- Osaka shopping list: run this in the Supabase SQL Editor once.
-- Dashboard → SQL Editor → New query → paste → Run

create table if not exists public.shopping_items (
  id text primary key,
  name text not null,
  jp_name text not null default '',
  category text not null,
  branch text not null default '',
  price integer,
  memo text not null default '',
  completed boolean not null default false,
  created_at bigint not null,
  updated_at timestamptz not null default now()
);

alter table public.shopping_items replica identity full;

do $$
begin
  if not exists (
    select 1
    from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'shopping_items'
  ) then
    alter publication supabase_realtime add table public.shopping_items;
  end if;
end $$;

alter table public.shopping_items enable row level security;

grant select, insert, update, delete on table public.shopping_items to anon, authenticated;

drop policy if exists "anon select shopping_items" on public.shopping_items;
drop policy if exists "anon insert shopping_items" on public.shopping_items;
drop policy if exists "anon update shopping_items" on public.shopping_items;
drop policy if exists "anon delete shopping_items" on public.shopping_items;

create policy "anon select shopping_items"
  on public.shopping_items for select to anon, authenticated
  using (true);

create policy "anon insert shopping_items"
  on public.shopping_items for insert to anon, authenticated
  with check (true);

create policy "anon update shopping_items"
  on public.shopping_items for update to anon, authenticated
  using (true) with check (true);

create policy "anon delete shopping_items"
  on public.shopping_items for delete to anon, authenticated
  using (true);
