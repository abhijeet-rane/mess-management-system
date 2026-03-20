-- ============================================================================
-- ADD SUBSCRIPTION DATE COLUMNS MIGRATION
-- ============================================================================
-- This script adds the missing subscription_start_date and subscription_end_date
-- columns to the users table that are required for the balance days feature.
--
-- Run this script in your Supabase SQL Editor
-- ============================================================================

-- Step 1: Add subscription columns if they don't exist
-- ============================================================================

DO $$ 
BEGIN
  -- Add subscription_start_date column
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_schema = 'public' 
    AND table_name = 'users' 
    AND column_name = 'subscription_start_date'
  ) THEN
    ALTER TABLE public.users ADD COLUMN subscription_start_date timestamp with time zone;
    RAISE NOTICE '✅ Added subscription_start_date column to users table';
  ELSE
    RAISE NOTICE 'ℹ️  subscription_start_date column already exists';
  END IF;

  -- Add subscription_end_date column
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_schema = 'public' 
    AND table_name = 'users' 
    AND column_name = 'subscription_end_date'
  ) THEN
    ALTER TABLE public.users ADD COLUMN subscription_end_date timestamp with time zone;
    RAISE NOTICE '✅ Added subscription_end_date column to users table';
  ELSE
    RAISE NOTICE 'ℹ️  subscription_end_date column already exists';
  END IF;
END $$;


-- Step 2: Create index for better query performance
-- ============================================================================

CREATE INDEX IF NOT EXISTS idx_users_subscription_dates 
  ON public.users(subscription_start_date, subscription_end_date)
  WHERE subscription_start_date IS NOT NULL;

DO $$ 
BEGIN
  RAISE NOTICE '✅ Created performance index on subscription dates';
END $$;


-- Step 3: Verify the setup
-- ============================================================================

DO $$
DECLARE
  column_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO column_count
  FROM information_schema.columns 
  WHERE table_schema = 'public' 
    AND table_name = 'users' 
    AND column_name IN ('subscription_start_date', 'subscription_end_date');
  
  IF column_count = 2 THEN
    RAISE NOTICE '✅ All subscription columns exist';
  ELSE
    RAISE WARNING '⚠️  Missing some columns. Expected 2, found %', column_count;
  END IF;
END $$;


-- ============================================================================
-- MIGRATION COMPLETE!
-- ============================================================================

DO $$ 
BEGIN
  RAISE NOTICE '';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  RAISE NOTICE '✅ SUBSCRIPTION COLUMNS MIGRATION COMPLETED!';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  RAISE NOTICE '';
  RAISE NOTICE 'Summary:';
  RAISE NOTICE '  • subscription_start_date column added';
  RAISE NOTICE '  • subscription_end_date column added';
  RAISE NOTICE '  • Performance index created';
  RAISE NOTICE '';
  RAISE NOTICE '⚠️  IMPORTANT NEXT STEPS:';
  RAISE NOTICE '  1. These columns are currently NULL for all users';
  RAISE NOTICE '  2. You need to build a UI for owners to set these dates';
  RAISE NOTICE '  3. Until then, the balance days feature will show 0';
  RAISE NOTICE '';
  RAISE NOTICE 'To manually test, you can run:';
  RAISE NOTICE '  UPDATE public.users';
  RAISE NOTICE '  SET subscription_start_date = ''2026-03-01'',';
  RAISE NOTICE '      subscription_end_date = ''2026-03-31''';
  RAISE NOTICE '  WHERE id = ''<user-id>'';';
  RAISE NOTICE '';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
END $$;


-- ============================================================================
-- OPTIONAL: Sample data for testing
-- ============================================================================
-- Uncomment and modify the user_id to test with a specific student:
-- 
-- UPDATE public.users
-- SET 
--   subscription_start_date = '2026-03-01 00:00:00+00',
--   subscription_end_date = '2026-03-31 23:59:59+00'
-- WHERE role = 'STUDENT' 
--   AND id = '<replace-with-actual-user-id>';
