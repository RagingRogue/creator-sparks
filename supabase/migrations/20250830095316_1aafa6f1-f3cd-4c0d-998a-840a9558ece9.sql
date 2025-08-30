-- Create three new posts for dance challenge, morning coffee run, and city life adventure
-- Note: Using the existing test user ID from previous migrations
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
  gen_random_uuid(),
  '00000000-0000-0000-0000-000000000000'::uuid,
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
  gen_random_uuid(),
  '00000000-0000-0000-0000-000000000000'::uuid,
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
  gen_random_uuid(),
  '00000000-0000-0000-0000-000000000000'::uuid,
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

-- Get the IDs of the newly created posts for quality assessments and earnings
-- Create quality assessments for the new posts
INSERT INTO quality_assessments (
  post_id,
  engagement_score,
  video_quality_score,
  originality_score,
  overall_grade,
  is_final,
  assessed_at
) 
SELECT 
  p.id,
  CASE 
    WHEN p.title LIKE '%Dance Challenge%' THEN 0.87
    WHEN p.title LIKE '%Coffee Run%' THEN 0.74
    WHEN p.title LIKE '%City Life%' THEN 0.92
  END as engagement_score,
  CASE 
    WHEN p.title LIKE '%Dance Challenge%' THEN 'excellent'
    WHEN p.title LIKE '%Coffee Run%' THEN 'good'
    WHEN p.title LIKE '%City Life%' THEN 'excellent'
  END as video_quality_score,
  true as originality_score,
  CASE 
    WHEN p.title LIKE '%Dance Challenge%' THEN 'A'
    WHEN p.title LIKE '%Coffee Run%' THEN 'B'
    WHEN p.title LIKE '%City Life%' THEN 'A'
  END as overall_grade,
  true as is_final,
  CASE 
    WHEN p.title LIKE '%Dance Challenge%' THEN now() - interval '4 days'
    WHEN p.title LIKE '%Coffee Run%' THEN now() - interval '7 days'
    WHEN p.title LIKE '%City Life%' THEN now() - interval '2 days'
  END as assessed_at
FROM posts p 
WHERE p.title IN ('Epic Dance Challenge Goes Viral', 'Morning Coffee Run Routine', 'City Life Adventure Vlog');

-- Create weekly earnings records for these posts
INSERT INTO weekly_earnings (
  post_id,
  week_start,
  week_end,
  base_earnings,
  bonus_earnings,
  total_earnings
)
SELECT 
  p.id,
  CASE 
    WHEN p.title LIKE '%Dance Challenge%' OR p.title LIKE '%City Life%' THEN current_date - interval '7 days'
    WHEN p.title LIKE '%Coffee Run%' THEN current_date - interval '14 days'
  END as week_start,
  CASE 
    WHEN p.title LIKE '%Dance Challenge%' OR p.title LIKE '%City Life%' THEN current_date
    WHEN p.title LIKE '%Coffee Run%' THEN current_date - interval '7 days'
  END as week_end,
  CASE 
    WHEN p.title LIKE '%Dance Challenge%' THEN 850.00
    WHEN p.title LIKE '%Coffee Run%' THEN 420.00
    WHEN p.title LIKE '%City Life%' THEN 1250.00
  END as base_earnings,
  CASE 
    WHEN p.title LIKE '%Dance Challenge%' THEN 170.00
    WHEN p.title LIKE '%Coffee Run%' THEN 42.00
    WHEN p.title LIKE '%City Life%' THEN 250.00
  END as bonus_earnings,
  CASE 
    WHEN p.title LIKE '%Dance Challenge%' THEN 1020.00
    WHEN p.title LIKE '%Coffee Run%' THEN 462.00
    WHEN p.title LIKE '%City Life%' THEN 1500.00
  END as total_earnings
FROM posts p 
WHERE p.title IN ('Epic Dance Challenge Goes Viral', 'Morning Coffee Run Routine', 'City Life Adventure Vlog');