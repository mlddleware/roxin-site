-- Оптимизация производительности для поддержки 100+ пользователей
-- Создание индексов для часто используемых запросов

-- Индексы для таблицы messages (чат)
CREATE INDEX IF NOT EXISTS idx_messages_sender_recipient ON messages(sender_id, user_id2);
CREATE INDEX IF NOT EXISTS idx_messages_created_at ON messages(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_messages_user_ids ON messages(user_id1, user_id2);
CREATE INDEX IF NOT EXISTS idx_messages_lookup ON messages(sender_id, user_id1, user_id2, created_at);

-- Индексы для таблицы chats
CREATE INDEX IF NOT EXISTS idx_chats_users ON chats(user_id1, user_id2);
CREATE INDEX IF NOT EXISTS idx_chats_user1 ON chats(user_id1);
CREATE INDEX IF NOT EXISTS idx_chats_user2 ON chats(user_id2);

-- Индексы для таблицы users
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);
CREATE INDEX IF NOT EXISTS idx_users_status ON users(status);

-- Индексы для таблицы user_profiles
CREATE INDEX IF NOT EXISTS idx_user_profiles_user_id ON user_profiles(user_id);
CREATE INDEX IF NOT EXISTS idx_user_profiles_last_visit ON user_profiles(last_visit);

-- Индексы для таблицы orders
CREATE INDEX IF NOT EXISTS idx_orders_user_id ON orders(user_id);
CREATE INDEX IF NOT EXISTS idx_orders_status ON orders(status);
CREATE INDEX IF NOT EXISTS idx_orders_created_at ON orders(created_at DESC);

-- Составные индексы для сложных запросов
CREATE INDEX IF NOT EXISTS idx_orders_user_status ON orders(user_id, status);
CREATE INDEX IF NOT EXISTS idx_messages_chat_time ON messages(user_id1, user_id2, created_at DESC);

-- Оптимизация для сессий
CREATE INDEX IF NOT EXISTS idx_sessions_user_id ON sessions(user_id) WHERE user_id IS NOT NULL;

-- Анализ таблиц для обновления статистики
ANALYZE messages;
ANALYZE chats;
ANALYZE users;
ANALYZE user_profiles;
ANALYZE orders;

-- Настройки PostgreSQL для лучшей производительности (выполнить от имени супер-пользователя)
-- ALTER SYSTEM SET shared_buffers = '256MB';
-- ALTER SYSTEM SET effective_cache_size = '1GB';
-- ALTER SYSTEM SET random_page_cost = 1.1;
-- SELECT pg_reload_conf(); 