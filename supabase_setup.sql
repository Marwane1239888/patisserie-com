-- Patisserie shared workspace
-- Run this once in Supabase > SQL Editor for this project.

create table if not exists public.app_data (
  store_id text not null,
  bucket text not null check (bucket in ('products', 'orders', 'kv', 'coffees', 'sales')),
  id text not null,
  payload jsonb not null,
  updated_by uuid references auth.users(id) on delete set null,
  updated_at timestamptz not null default now(),
  primary key (store_id, bucket, id)
);

alter table public.app_data enable row level security;

-- No access for signed-out visitors. All signed-in app users get the same rights
-- to the shared patisserie workspace: read, create, edit and delete.
revoke all on table public.app_data from public, anon, authenticated;
grant select, insert, update, delete on table public.app_data to authenticated;

drop policy if exists app_data_read_signed_in on public.app_data;
drop policy if exists app_data_insert_signed_in on public.app_data;
drop policy if exists app_data_update_signed_in on public.app_data;
drop policy if exists app_data_delete_signed_in on public.app_data;

create policy app_data_read_signed_in
  on public.app_data for select to authenticated
  using ((select auth.uid()) is not null);

create policy app_data_insert_signed_in
  on public.app_data for insert to authenticated
  with check ((select auth.uid()) is not null);

create policy app_data_update_signed_in
  on public.app_data for update to authenticated
  using ((select auth.uid()) is not null)
  with check ((select auth.uid()) is not null);

create policy app_data_delete_signed_in
  on public.app_data for delete to authenticated
  using ((select auth.uid()) is not null);

-- Enable Realtime delivery for this table so changes appear on other devices.
do $$
begin
  if not exists (
    select 1
    from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'app_data'
  ) then
    alter publication supabase_realtime add table public.app_data;
  end if;
end $$;
