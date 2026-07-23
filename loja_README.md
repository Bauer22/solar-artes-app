# ☀ Solar Artes — Loja Online

Site de vendas dos cosméticos artesanais Solar Artes.

## Stack
- **Frontend:** HTML/CSS/JS puro
- **Banco de dados:** Supabase (PostgreSQL)
- **Hospedagem:** Vercel
- **Pedidos:** WhatsApp

## Configuração

### 1. Supabase
1. Acesse https://supabase.com → New project
2. SQL Editor → execute `supabase_schema.sql`
3. Settings → API → copie URL e anon key

### 2. Configurar index.html
```js
const CFG = {
  supabaseUrl: 'https://xxxx.supabase.co',
  supabaseKey: 'sua-chave-anon',
  whatsapp: '5554999887766',
  pixChave: 'sua@chave.pix',
};
```

### 3. Vercel
1. Importe o repositório no Vercel
2. Deploy automático

## Funcionalidades
- ✅ Catálogo de produtos do Supabase
- ✅ Carrinho de compras
- ✅ Pedido formatado via WhatsApp
- ✅ Chave Pix com cópia
- ✅ Design inspirado em feitobrasil.com
- ✅ 100% responsivo
- ✅ Fallback offline
