-- Update the existing profile for test user
UPDATE public.profiles 
SET username = '@creativecreator', 
    display_name = 'TikTok Creator', 
    avatar_url = 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150', 
    bio = 'Content creator sharing daily life', 
    followers_count = 125400, 
    following_count = 890, 
    total_earnings = 1920.00
WHERE user_id = 'bf4c09a0-3617-4892-9027-aa62e208ee64';

-- Delete any existing posts for this user first to avoid conflicts
DELETE FROM public.weekly_earnings WHERE post_id IN (
  SELECT id FROM public.posts WHERE user_id = 'bf4c09a0-3617-4892-9027-aa62e208ee64'
);
DELETE FROM public.fraud_alerts WHERE post_id IN (
  SELECT id FROM public.posts WHERE user_id = 'bf4c09a0-3617-4892-9027-aa62e208ee64'
);
DELETE FROM public.quality_assessments WHERE post_id IN (
  SELECT id FROM public.posts WHERE user_id = 'bf4c09a0-3617-4892-9027-aa62e208ee64'
);
DELETE FROM public.posts WHERE user_id = 'bf4c09a0-3617-4892-9027-aa62e208ee64';

-- Insert 3 posts for the test user
INSERT INTO public.posts (id, user_id, title, description, video_url, thumbnail_url, duration, views_count, likes_count, comments_count, shares_count, saves_count, base_pay, bonus_multiplier, total_earnings, is_frozen, freeze_reason, posted_at) 
VALUES 
  -- Post 1: 20 days ago, A grade, no fraud
  ('11111111-1111-1111-1111-111111111111', 'bf4c09a0-3617-4892-9027-aa62e208ee64', 'Morning Coffee Routine ☕', 'Starting my day right with the perfect cup of coffee', '/demo-video-1.jpg', '/demo-video-1.jpg', 45, 892000, 45200, 1200, 8900, 3400, 500.00, 0.20, 600.00, false, null, NOW() - INTERVAL '20 days'),
  
  -- Post 2: 40 days ago, B grade, no fraud
  ('22222222-2222-2222-2222-222222222222', 'bf4c09a0-3617-4892-9027-aa62e208ee64', 'City Life Adventures 🏙️', 'Exploring the bustling streets of downtown', '/demo-video-2.jpg', '/demo-video-2.jpg', 38, 456000, 28900, 890, 5600, 2100, 800.00, 0.10, 880.00, false, null, NOW() - INTERVAL '40 days'),
  
  -- Post 3: 10 days ago, B grade, fraud detected
  ('33333333-3333-3333-3333-333333333333', 'bf4c09a0-3617-4892-9027-aa62e208ee64', 'Dance Challenge 💃', 'New trending dance moves you need to try', '/demo-video-3.jpg', '/demo-video-3.jpg', 52, 234000, 18700, 650, 3200, 1500, 400.00, 0.10, 440.00, true, 'Fraudulent activity detected - contact support to appeal', NOW() - INTERVAL '10 days');

-- Insert quality assessments for each post
INSERT INTO public.quality_assessments (post_id, engagement_score, originality_score, video_quality_score, overall_grade, is_final) 
VALUES 
  -- Post 1: Under 30 days, daily updates (not final)
  ('11111111-1111-1111-1111-111111111111', 0.30, true, 'good', 'A', false),
  
  -- Post 2: Over 30 days, final fixed score
  ('22222222-2222-2222-2222-222222222222', 0.20, true, 'good', 'B', true),
  
  -- Post 3: Under 30 days, fraud detected (suspected botting affects originality)
  ('33333333-3333-3333-3333-333333333333', 0.40, false, 'good', 'B', false);

-- Insert fraud alert for Post 3
INSERT INTO public.fraud_alerts (post_id, alert_type, severity, description) 
VALUES 
  ('33333333-3333-3333-3333-333333333333', 'botting', 'high', 'We have detected botting and suspicious activity. Automated engagement patterns identified.');

-- Insert weekly earnings data for all posts
INSERT INTO public.weekly_earnings (post_id, week_start, week_end, base_earnings, bonus_earnings, total_earnings) 
VALUES 
  -- Post 1 weekly earnings (last 3 weeks since posted 20 days ago)
  ('11111111-1111-1111-1111-111111111111', DATE_TRUNC('week', NOW() - INTERVAL '21 days'), DATE_TRUNC('week', NOW() - INTERVAL '21 days') + INTERVAL '6 days', 125.00, 25.00, 150.00),
  ('11111111-1111-1111-1111-111111111111', DATE_TRUNC('week', NOW() - INTERVAL '14 days'), DATE_TRUNC('week', NOW() - INTERVAL '14 days') + INTERVAL '6 days', 200.00, 40.00, 240.00),
  ('11111111-1111-1111-1111-111111111111', DATE_TRUNC('week', NOW() - INTERVAL '7 days'), DATE_TRUNC('week', NOW() - INTERVAL '7 days') + INTERVAL '6 days', 175.00, 35.00, 210.00),
  
  -- Post 2 weekly earnings (last 6 weeks since posted 40 days ago)
  ('22222222-2222-2222-2222-222222222222', DATE_TRUNC('week', NOW() - INTERVAL '42 days'), DATE_TRUNC('week', NOW() - INTERVAL '42 days') + INTERVAL '6 days', 200.00, 20.00, 220.00),
  ('22222222-2222-2222-2222-222222222222', DATE_TRUNC('week', NOW() - INTERVAL '35 days'), DATE_TRUNC('week', NOW() - INTERVAL '35 days') + INTERVAL '6 days', 180.00, 18.00, 198.00),
  ('22222222-2222-2222-2222-222222222222', DATE_TRUNC('week', NOW() - INTERVAL '28 days'), DATE_TRUNC('week', NOW() - INTERVAL '28 days') + INTERVAL '6 days', 160.00, 16.00, 176.00),
  ('22222222-2222-2222-2222-222222222222', DATE_TRUNC('week', NOW() - INTERVAL '21 days'), DATE_TRUNC('week', NOW() - INTERVAL '21 days') + INTERVAL '6 days', 140.00, 14.00, 154.00),
  ('22222222-2222-2222-2222-222222222222', DATE_TRUNC('week', NOW() - INTERVAL '14 days'), DATE_TRUNC('week', NOW() - INTERVAL '14 days') + INTERVAL '6 days', 120.00, 12.00, 132.00),
  ('22222222-2222-2222-2222-222222222222', DATE_TRUNC('week', NOW() - INTERVAL '7 days'), DATE_TRUNC('week', NOW() - INTERVAL '7 days') + INTERVAL '6 days', 0.00, 0.00, 0.00),
  
  -- Post 3 weekly earnings (last 2 weeks, then frozen due to fraud)
  ('33333333-3333-3333-3333-333333333333', DATE_TRUNC('week', NOW() - INTERVAL '14 days'), DATE_TRUNC('week', NOW() - INTERVAL '14 days') + INTERVAL '6 days', 0.00, 0.00, 0.00),
  ('33333333-3333-3333-3333-333333333333', DATE_TRUNC('week', NOW() - INTERVAL '7 days'), DATE_TRUNC('week', NOW() - INTERVAL '7 days') + INTERVAL '6 days', 200.00, 20.00, 220.00);