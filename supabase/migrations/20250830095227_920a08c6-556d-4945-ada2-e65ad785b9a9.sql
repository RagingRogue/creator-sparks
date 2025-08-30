-- Create three new posts for dance challenge, morning coffee run, and city life adventure
INSERT INTO posts (
  id,
  user_id,
  title,
  description,
  video_url,
  thumbnail_url,
  views_count,
  likes_count,
  comments_count,
  shares_count,
  saves_count,
  base_pay,
  bonus_multiplier,
  total_earnings,
  posted_at,
  duration
) VALUES 
(
  'a1b2c3d4-e5f6-7890-1234-567890abcdef',
  'b2c3d4e5-f6a7-8901-2345-678901bcdefg'::uuid,
  'Epic Dance Challenge Goes Viral',
  'Watch this amazing dance routine that took TikTok by storm! Perfect choreography and energy.',
  'https://example.com/video/dance-challenge.mp4',
  '/thumbnails/dance-challenge.jpg',
  2500000,
  185000,
  12400,
  8500,
  15600,
  850.00,
  0.20,
  1020.00,
  now() - interval '5 days',
  45
),
(
  'b2c3d4e5-f6a7-8901-2345-678901bcdefg',
  'b2c3d4e5-f6a7-8901-2345-678901bcdefg'::uuid,
  'Morning Coffee Run Routine',
  'Join me for my daily morning coffee ritual and see how it transforms my entire day!',
  'https://example.com/video/coffee-run.mp4',
  '/thumbnails/morning-coffee-run.jpg',
  1800000,
  95000,
  5200,
  3100,
  7800,
  420.00,
  0.10,
  462.00,
  now() - interval '8 days',
  32
),
(
  'c3d4e5f6-a7b8-9012-3456-789012cdefgh',
  'b2c3d4e5-f6a7-8901-2345-678901bcdefg'::uuid,
  'City Life Adventure Vlog',
  'Exploring the hidden gems of the city! From rooftops to underground spots, this adventure has it all.',
  'https://example.com/video/city-adventure.mp4',
  '/thumbnails/city-life-adventure.jpg',
  3200000,
  220000,
  18600,
  11200,
  22400,
  1250.00,
  0.20,
  1500.00,
  now() - interval '3 days',
  68
);

-- Create quality assessments for the new posts
INSERT INTO quality_assessments (
  post_id,
  engagement_score,
  video_quality_score,
  originality_score,
  overall_grade,
  is_final,
  assessed_at
) VALUES 
(
  'a1b2c3d4-e5f6-7890-1234-567890abcdef',
  0.87,
  'excellent',
  true,
  'A',
  true,
  now() - interval '4 days'
),
(
  'b2c3d4e5-f6a7-8901-2345-678901bcdefg',
  0.74,
  'good',
  true,
  'B',
  true,
  now() - interval '7 days'
),
(
  'c3d4e5f6-a7b8-9012-3456-789012cdefgh',
  0.92,
  'excellent',
  true,
  'A',
  true,
  now() - interval '2 days'
);

-- Create weekly earnings records for these posts
INSERT INTO weekly_earnings (
  post_id,
  week_start,
  week_end,
  base_earnings,
  bonus_earnings,
  total_earnings
) VALUES 
(
  'a1b2c3d4-e5f6-7890-1234-567890abcdef',
  current_date - interval '7 days',
  current_date,
  850.00,
  170.00,
  1020.00
),
(
  'b2c3d4e5-f6a7-8901-2345-678901bcdefg',
  current_date - interval '14 days',
  current_date - interval '7 days',
  420.00,
  42.00,
  462.00
),
(
  'c3d4e5f6-a7b8-9012-3456-789012cdefgh',
  current_date - interval '7 days',
  current_date,
  1250.00,
  250.00,
  1500.00
);