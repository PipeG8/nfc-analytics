SELECT 
    constraint_name,
    table_name,
    column_name,
    ordinal_position
FROM information_schema.key_column_usage
WHERE table_schema = 'public' 
  AND table_name = 'nfc_sales_facts_sql'
ORDER BY constraint_name, ordinal_position;