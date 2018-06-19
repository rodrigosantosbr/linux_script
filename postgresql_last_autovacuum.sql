-- Exibe data e hora dos ultimos autovacuums das tabelas
select
    pg_class.relname as tabela,
    pg_namespace.nspname as namespace,
    pg_size_pretty(pg_total_relation_size(pg_namespace.nspname::text || '.' || pg_class.relname::text)),
    pg_stat_all_tables.last_autovacuum as ultimo_autovacuum,
    pg_relation_size(pg_namespace.nspname::text || '.' || pg_class.relname::text)
from
    pg_class
        join pg_namespace
            on pg_class.relnamespace = pg_namespace.oid
        join pg_stat_all_tables
            on (pg_class.relname = pg_stat_all_tables.relname AND pg_namespace.nspname = pg_stat_all_tables.schemaname)
where
    pg_namespace.nspname not in ('pg_toast')
order by
    tabela asc
;
