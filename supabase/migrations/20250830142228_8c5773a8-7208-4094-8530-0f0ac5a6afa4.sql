-- Fix the function and manually test it with a simpler approach
CREATE OR REPLACE FUNCTION public.trigger_originality_analysis()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = 'public', 'extensions'
AS $$
BEGIN
  -- Make HTTP request to analyze-originality edge function
  PERFORM extensions.http_post(
    url := 'https://teyceebtjinstsgvmyye.supabase.co/functions/v1/analyze-originality',
    headers := jsonb_build_object(
      'Content-Type', 'application/json',
      'Authorization', 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRleWNlZWJ0amluc3RzZ3ZteXllIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY1NDM0MTEsImV4cCI6MjA3MjExOTQxMX0.ZpoDwAfGR0tzbBuyAYs8JVfAa4Z63eqDrikT7SNZlhA'
    ),
    body := jsonb_build_object('postId', NEW.id::text)
  );
  
  RETURN NEW;
END;
$$;

-- Test by inserting a simple test post to see if trigger works
INSERT INTO public.posts (
  user_id,
  title,
  description,
  video_url,
  duration,
  views_count,
  likes_count,
  comments_count,
  shares_count,
  saves_count,
  base_pay,
  bonus_multiplier,
  total_earnings,
  posted_at
) VALUES (
  'bf4c09a0-3617-4892-9027-aa62e208ee64',
  'Test Trigger Post',
  'Testing if the automatic originality detection works',
  'https://example.com/test-video.mp4',
  30,
  1000,
  50,
  10,
  5,
  2,
  5.00,
  1.0,
  5.00,
  NOW()
);