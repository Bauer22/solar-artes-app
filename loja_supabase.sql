-- ============================================================
-- SOLAR ARTES — Supabase Schema
-- Execute no SQL Editor do Supabase
-- ============================================================

create table if not exists produtos (
  id          text primary key default gen_random_uuid()::text,
  nome        text not null,
  custo       numeric(10,2) default 0,
  venda       numeric(10,2) default 0,
  estoque     int default 10,
  estoque_min int default 3,
  descricao   text default '',
  emoji       text default '🌿',
  tag         text,
  ativo       boolean default true,
  criado_em   timestamptz default now()
);

create table if not exists clientes (
  id        text primary key default gen_random_uuid()::text,
  nome      text not null,
  tel       text default '',
  obs       text default '',
  criado_em timestamptz default now()
);

create table if not exists pedidos (
  id          text primary key default gen_random_uuid()::text,
  cliente_id  text references clientes(id),
  itens_json  jsonb not null default '[]',
  total       numeric(10,2) default 0,
  pagamento   text default 'whatsapp',
  status      text default 'pendente',
  obs         text default '',
  criado_em   timestamptz default now()
);

create table if not exists vendas (
  id          text primary key default gen_random_uuid()::text,
  data        date not null default current_date,
  cliente_id  text references clientes(id),
  itens_json  jsonb not null default '[]',
  total       numeric(10,2) default 0,
  lucro       numeric(10,2) default 0,
  pagamento   text default 'dinheiro',
  vencimento  date,
  entrada     numeric(10,2) default 0,
  pago        boolean default false,
  obs         text default '',
  criado_em   timestamptz default now()
);

create table if not exists agenda (
  id        text primary key default gen_random_uuid()::text,
  tipo      text default 'tarefa',
  titulo    text not null,
  descricao text default '',
  data      date,
  hora      text default '09:00',
  venda_id  text references vendas(id),
  concluida boolean default false,
  criado_em timestamptz default now()
);

-- Seed produtos
insert into produtos (nome, custo, venda, descricao, emoji, tag) values
  ('Body Aurora 200ml',    18.68, 45, 'Hidratante artesanal com essência floral e ingredientes naturais.', '🌸', 'Mais vendido'),
  ('Body Moon Mist 200ml', 25.00, 65, 'Névoa corporal exclusiva que hidrata e ilumina a pele naturalmente.', '🌙', 'Novidade'),
  ('Body Fly',             25.28, 60, 'Creme leve que absorve rapidamente, deixando a pele sedosa.', '🦋', null),
  ('Body Liria',           26.56, 60, 'Hidratante floral com extrato de lírio para pele macia.', '🌷', null),
  ('Body Sky',             22.44, 65, 'Creme corporal inspirado na leveza do céu, hidratação duradoura.', '☁️', 'Premium'),
  ('Body 002',             22.45, 65, 'Fórmula exclusiva 002 com blend de óleos essenciais premium.', '✨', 'Exclusivo')
on conflict do nothing;

-- RLS (Row Level Security)
alter table produtos enable row level security;
create policy "produtos_publico" on produtos for select using (ativo = true);
create policy "produtos_admin"   on produtos for all   using (auth.role() = 'authenticated');

alter table pedidos enable row level security;
create policy "pedidos_insert"   on pedidos for insert with check (true);
create policy "pedidos_admin"    on pedidos for select using (auth.role() = 'authenticated');

alter table vendas enable row level security;
create policy "vendas_admin" on vendas for all using (auth.role() = 'authenticated');

alter table agenda enable row level security;
create policy "agenda_admin" on agenda for all using (auth.role() = 'authenticated');

alter table clientes enable row level security;
create policy "clientes_admin" on clientes for all using (auth.role() = 'authenticated');
