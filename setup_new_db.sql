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

-- Bulk Insert Products from Excel
INSERT INTO public.products (article, name, price, category, image_url) VALUES 
('Артикул', 'Название', 0, 'Массовая загрузка', NULL),
('99-0001000', 'Стул Хлоя', 0, 'Массовая загрузка', NULL),
('99-0001001', 'Стул Хлоя МДФ', 0, 'Массовая загрузка', NULL),
('99-0001002', 'Каркас Хлоя и Хлоя МДФ', 0, 'Массовая загрузка', NULL),
('99-0001004', 'Сиденье МДФ трапеция', 0, 'Массовая загрузка', NULL),
('99-0001005', 'Стул Марк низкий
тонкое сиденье', 0, 'Массовая загрузка', NULL),
('99-0001006', 'Каркас Марк низкий', 0, 'Массовая загрузка', NULL),
('99-0001007', 'Стул Скалли', 0, 'Массовая загрузка', NULL),
('99-0001008', 'Стул Скалли МДФ', 0, 'Массовая загрузка', NULL),
('99-0001009', 'Каркас Скалли', 0, 'Массовая загрузка', NULL),
('99-0001010', 'Сиденье МДФ круг 370', 0, 'Массовая загрузка', NULL),
('99-0001011', 'Стул Нерон', 0, 'Массовая загрузка', NULL),
('99-0001012', 'Стул Ромашка', 0, 'Массовая загрузка', NULL),
('99-0001013', 'Стул Ромашка МДФ', 0, 'Массовая загрузка', NULL),
('99-0001014', 'Каркас Ромашка', 0, 'Массовая загрузка', NULL),
('99-0001015', 'Сиденье МДФ круг 390', 0, 'Массовая загрузка', NULL),
('99-0001016', 'Стул Венский', 0, 'Массовая загрузка', NULL),
('99-0001017', 'Стул Венский МДФ', 0, 'Массовая загрузка', NULL),
('99-0001018', 'Каркас Венский и Венский МДФ', 0, 'Массовая загрузка', NULL),
('99-0001020', 'Сиденье МДФ круг 390', 0, 'Массовая загрузка', NULL),
('99-0001021', 'Стул Венский пластик (от 15 шт)', 0, 'Массовая загрузка', NULL),
('99-0001022', 'Каркас Венский пластик', 0, 'Массовая загрузка', NULL),
('99-0001023', 'Пластиковое сиденье для стула Венского', 0, 'Массовая загрузка', NULL),
('99-0001024', 'Стул «Венский- М»', 0, 'Массовая загрузка', NULL),
('99-0001025', 'Стул Ренессанс', 0, 'Массовая загрузка', NULL),
('99-0001026', 'Каркас Ренессанс', 0, 'Массовая загрузка', NULL),
('99-0001027', 'Стул Хлоя-Софт', 0, 'Массовая загрузка', NULL),
('99-0001028', 'Стул Хлоя-Софт-М', 0, 'Массовая загрузка', NULL),
('99-0001029', 'Каркас Хлоя-Софт', 0, 'Массовая загрузка', NULL),
('99-0001030', 'Стул Пекин', 0, 'Массовая загрузка', NULL),
('99-0001031', 'Стул Пекин CH (хром)', 0, 'Массовая загрузка', NULL),
('99-0001032', 'Стул ИЗО
"Экстра"', 0, 'Массовая загрузка', NULL),
('99-0001033', 'Стул MINI', 0, 'Массовая загрузка', NULL),
('99-0001034', 'Стул MINI Office', 0, 'Массовая загрузка', NULL),
('99-0001035', 'Табурет Ти-Арт мягкий', 0, 'Массовая загрузка', NULL),
('99-0001036', 'Табурет Ти-Арт фанера с HPL (от 20 шт)', 0, 'Массовая загрузка', NULL),
('99-0001037', 'Каркас Ти-Арт', 0, 'Массовая загрузка', NULL),
('99-0001038', 'Табурет круглый Экстра', 0, 'Массовая загрузка', NULL),
('99-0001039', 'Табурет круглый Экстра МДФ', 0, 'Массовая загрузка', NULL),
('99-0001040', 'Каркас Табурет Экстра', 0, 'Массовая загрузка', NULL),
('99-0001041', 'Сиденье МДФ круг 350', 0, 'Массовая загрузка', NULL),
('99-0001042', 'Табурет квадратный Эконом', 0, 'Массовая загрузка', NULL),
('99-0001043', 'Табурет Квадратный Эконом МДФ', 0, 'Массовая загрузка', NULL),
('99-0001044', 'Каркас Табурет Квадратный', 0, 'Массовая загрузка', NULL),
('99-0001045', 'Сиденье МДФ 330х330х16', 0, 'Массовая загрузка', NULL),
('99-0001046', 'Табурет круглый 
Стопируемый', 0, 'Массовая загрузка', NULL);
