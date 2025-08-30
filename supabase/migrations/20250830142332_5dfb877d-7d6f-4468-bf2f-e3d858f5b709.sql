-- Test the trigger by inserting a new test post
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
  'Trigger Test Video',
  'Testing automatic originality detection trigger',
  'https://example.com/trigger-test.mp4',
  25,
  500,
  25,
  5,
  2,
  1,
  3.00,
  1.0,
  3.00,
  NOW()
) RETURNING id, title;