-- Chạy trong Supabase > SQL Editor
create table if not exists public.posts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) default auth.uid(),
  author text not null,
  content text not null check (char_length(content) between 1 and 1000),
  created_at timestamptz default now()
);
alter table public.posts enable row level security;
create policy "doc_bai" on public.posts for select to authenticated using (true);
create policy "dang_bai" on public.posts for insert to authenticated with check (auth.uid() = user_id);
create policy "xoa_bai_cua_minh" on public.posts for delete to authenticated using (auth.uid() = user_id);
alter publication supabase_realtime add table public.posts;
