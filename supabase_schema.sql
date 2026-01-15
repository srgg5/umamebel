-- Create Products table
create table public.products (
  id uuid default gen_random_uuid() primary key,
  article text not null,
  name text not null,
  price numeric,
  category text not null,
  note text,
  image_url text,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Create Orders table
create table public.orders (
  id uuid default gen_random_uuid() primary key,
  customer_name text not null,
  phone text not null,
  email text,
  status text default 'new',
  total_amount numeric,
  items jsonb,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Enable RLS (Row Level Security)
alter table public.products enable row level security;
alter table public.orders enable row level security;

-- Create Policies (simplistic for now, allowing public read, anon insert for orders)
create policy "Public products are viewable by everyone" on public.products for select using (true);
create policy "Admin can insert products" on public.products for insert with check (true);
create policy "Admin can update products" on public.products for update using (true);
create policy "Admin can delete products" on public.products for delete using (true);

create policy "Anyone can create orders" on public.orders for insert with check (true);
-- Create the products bucket
insert into storage.buckets (id, name, public) 
values ('products', 'products', true);

-- Policy to allow public access to images
create policy "Public Access"
on storage.objects for select
using ( bucket_id = 'products' );

-- Policy to allow authenticated uploads
create policy "Auth Uploads"
on storage.objects for insert
with check ( bucket_id = 'products' and auth.role() = 'authenticated' );

-- Policy to allow authenticated updates
create policy "Auth Updates"
on storage.objects for update
with check ( bucket_id = 'products' and auth.role() = 'authenticated' );

-- Policy to allow authenticated deletes
create policy "Auth Deletes"
on storage.objects for delete
using ( bucket_id = 'products' and auth.role() = 'authenticated' );

