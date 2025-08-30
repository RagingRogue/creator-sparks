-- Insert the two TikTok posts for testing automatic fraud and originality detection
INSERT INTO public.posts (
  user_id,
  title,
  description,
  video_url,
  thumbnail_url,
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
) VALUES 
(
  'bf4c09a0-3617-4892-9027-aa62e208ee64',
  'Amazing Pet Tricks Compilation',
  'Watch these incredible pet tricks that will blow your mind! 🐕🐱 #pets #tricks #viral',
  'https://vt.tiktok.com/ZSAXjW5YC',
  '/thumbnails/amazing-pet-tricks.jpg',
  45,
  125000,
  8500,
  620,
  450,
  320,
  25.50,
  1.2,
  30.60,
  NOW() - INTERVAL '2 days'
),
(
  'bf4c09a0-3617-4892-9027-aa62e208ee64',
  'Quick Cooking Hack That Changed My Life',
  'This simple kitchen trick will save you so much time! Try it and thank me later 👨‍🍳 #cooking #lifehack #foodtips',
  'https://vt.tiktok.com/ZSAXjuu7C',
  '/thumbnails/cooking-hack.jpg',
  38,
  89000,
  6200,
  380,
  290,
  180,
  18.75,
  0.8,
  15.00,
  NOW() - INTERVAL '1 day'
);

-- Add some weekly earnings data for these posts
INSERT INTO public.weekly_earnings (
  post_id,
  week_start,
  week_end,
  base_earnings,
  bonus_earnings,
  total_earnings
)
SELECT 
  p.id,
  date_trunc('week', p.posted_at) as week_start,
  date_trunc('week', p.posted_at) + INTERVAL '6 days' as week_end,
  p.base_pay,
  (p.base_pay * p.bonus_multiplier) - p.base_pay as bonus_earnings,
  p.total_earnings
FROM public.posts p 
WHERE p.video_url IN ('https://vt.tiktok.com/ZSAXjW5YC', 'https://vt.tiktok.com/ZSAXjuu7C');