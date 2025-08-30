-- Insert mock user profile (you'll need to replace with actual user ID after authentication)
INSERT INTO public.profiles (user_id, username, display_name, avatar_url, bio, followers_count, following_count, total_earnings) 
VALUES 
  ('11111111-1111-1111-1111-111111111111', 'creator_user', 'TikTok Creator', 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150', 'Content creator sharing daily life', 125400, 890, 1740.00);

-- Insert mock posts
INSERT INTO public.posts (id, user_id, title, description, video_url, thumbnail_url, duration, views_count, likes_count, comments_count, shares_count, saves_count, base_pay, bonus_multiplier, total_earnings, is_frozen, freeze_reason, posted_at) 
VALUES 
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 'Morning Coffee Routine ☕', 'Starting my day right with the perfect cup of coffee', '/demo-video-1.jpg', '/demo-video-1.jpg', 45, 892000, 45200, 1200, 8900, 3400, 500.00, 0.20, 600.00, false, null, NOW() - INTERVAL '20 days'),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '11111111-1111-1111-1111-111111111111', 'City Life Adventures 🏙️', 'Exploring the bustling streets of downtown', '/demo-video-2.jpg', '/demo-video-2.jpg', 38, 456000, 28900, 890, 5600, 2100, 800.00, 0.10, 880.00, false, null, NOW() - INTERVAL '40 days'),
  ('cccccccc-cccc-cccc-cccc-cccccccccccc', '11111111-1111-1111-1111-111111111111', 'Dance Challenge 💃', 'New trending dance moves you need to try', '/demo-video-3.jpg', '/demo-video-3.jpg', 52, 234000, 18700, 650, 3200, 1500, 400.00, 0.10, 440.00, true, 'Fraudulent activity detected - contact support to appeal', NOW() - INTERVAL '10 days');

-- Insert quality assessments
INSERT INTO public.quality_assessments (post_id, engagement_score, originality_score, video_quality_score, overall_grade, is_final) 
VALUES 
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 0.30, true, 'good', 'A', false), -- Post 1: under 30 days, daily updates
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 0.20, true, 'good', 'B', true),  -- Post 2: over 30 days, final score
  ('cccccccc-cccc-cccc-cccc-cccccccccccc', 0.40, false, 'good', 'B', false); -- Post 3: under 30 days, suspected botting

-- Insert fraud alert for post 3
INSERT INTO public.fraud_alerts (post_id, alert_type, severity, description) 
VALUES 
  ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'botting', 'high', 'Detected suspicious engagement patterns and potential bot activity. Account under review.');

-- Insert weekly earnings data for charts
INSERT INTO public.weekly_earnings (post_id, week_start, week_end, base_earnings, bonus_earnings, total_earnings) 
VALUES 
  -- Post 1 weekly earnings (last 4 weeks)
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', DATE_TRUNC('week', NOW() - INTERVAL '21 days'), DATE_TRUNC('week', NOW() - INTERVAL '21 days') + INTERVAL '6 days', 125.00, 25.00, 150.00),
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', DATE_TRUNC('week', NOW() - INTERVAL '14 days'), DATE_TRUNC('week', NOW() - INTERVAL '14 days') + INTERVAL '6 days', 150.00, 30.00, 180.00),
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', DATE_TRUNC('week', NOW() - INTERVAL '7 days'), DATE_TRUNC('week', NOW() - INTERVAL '7 days') + INTERVAL '6 days', 125.00, 25.00, 150.00),
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', DATE_TRUNC('week', NOW()), DATE_TRUNC('week', NOW()) + INTERVAL '6 days', 100.00, 20.00, 120.00),
  -- Post 2 weekly earnings (last 6 weeks)
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', DATE_TRUNC('week', NOW() - INTERVAL '42 days'), DATE_TRUNC('week', NOW() - INTERVAL '42 days') + INTERVAL '6 days', 200.00, 20.00, 220.00),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', DATE_TRUNC('week', NOW() - INTERVAL '35 days'), DATE_TRUNC('week', NOW() - INTERVAL '35 days') + INTERVAL '6 days', 180.00, 18.00, 198.00),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', DATE_TRUNC('week', NOW() - INTERVAL '28 days'), DATE_TRUNC('week', NOW() - INTERVAL '28 days') + INTERVAL '6 days', 160.00, 16.00, 176.00),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', DATE_TRUNC('week', NOW() - INTERVAL '21 days'), DATE_TRUNC('week', NOW() - INTERVAL '21 days') + INTERVAL '6 days', 140.00, 14.00, 154.00),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', DATE_TRUNC('week', NOW() - INTERVAL '14 days'), DATE_TRUNC('week', NOW() - INTERVAL '14 days') + INTERVAL '6 days', 120.00, 12.00, 132.00),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', DATE_TRUNC('week', NOW() - INTERVAL '7 days'), DATE_TRUNC('week', NOW() - INTERVAL '7 days') + INTERVAL '6 days', 0.00, 0.00, 0.00),
  -- Post 3 weekly earnings (last 2 weeks, then frozen)
  ('cccccccc-cccc-cccc-cccc-cccccccccccc', DATE_TRUNC('week', NOW() - INTERVAL '14 days'), DATE_TRUNC('week', NOW() - INTERVAL '14 days') + INTERVAL '6 days', 200.00, 20.00, 220.00),
  ('cccccccc-cccc-cccc-cccc-cccccccccccc', DATE_TRUNC('week', NOW() - INTERVAL '7 days'), DATE_TRUNC('week', NOW() - INTERVAL '7 days') + INTERVAL '6 days', 200.00, 20.00, 220.00);