-- Create storage bucket for thumbnails
INSERT INTO storage.buckets (id, name, public) VALUES ('thumbnails', 'thumbnails', true);

-- Create storage policies for thumbnails
CREATE POLICY "Thumbnail images are publicly accessible" 
ON storage.objects 
FOR SELECT 
USING (bucket_id = 'thumbnails');

CREATE POLICY "Users can upload thumbnails" 
ON storage.objects 
FOR INSERT 
WITH CHECK (bucket_id = 'thumbnails' AND auth.uid() IS NOT NULL);

CREATE POLICY "Users can update thumbnails" 
ON storage.objects 
FOR UPDATE 
USING (bucket_id = 'thumbnails' AND auth.uid() IS NOT NULL);

-- Insert the three TikTok posts for the test user
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
  'e1f2a3b4-c5d6-7e8f-9012-345678901234',
  'bf4c09a0-3617-4892-9027-aa62e208ee64',
  'Our Latest Like',
  'Amazing nature content featuring giant lily pads - this is our latest viral hit!',
  'https://www.tiktok.com/@tiktok/video/7544066976969182495',
  'thumbnails/our-latest-like.png',
  2500000,
  145000,
  8500,
  12000,
  5500,
  85.00,
  2.1,
  178.50,
  NOW() - INTERVAL '2 days',
  45
),
(
  'f2e3d4c5-b6a7-8f90-1234-567890123456',
  'bf4c09a0-3617-4892-9027-aa62e208ee64',
  'A Little Sparked A Lot',
  'Inspirational content that really resonated with our audience!',
  'https://www.tiktok.com/@tiktok/video/7543724451540602143',
  'thumbnails/sparked-a-lot.png',
  1800000,
  92000,
  6200,
  8900,
  4100,
  72.00,
  1.8,
  129.60,
  NOW() - INTERVAL '5 days',
  38
),
(
  '12345678-9abc-def0-1234-567890abcdef',
  'bf4c09a0-3617-4892-9027-aa62e208ee64',
  'Best Math Hack',
  'Educational content showing amazing math tricks that went viral!',
  'https://www.tiktok.com/@tiktok/video/7543381582418169118',
  'thumbnails/math-hack.png',
  3200000,
  180000,
  12000,
  15500,
  7800,
  95.00,
  2.5,
  237.50,
  NOW() - INTERVAL '1 week',
  52
);

-- Insert quality assessments for these posts (using valid constraint values)
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
  'e1f2a3b4-c5d6-7e8f-9012-345678901234',
  8.7,
  'excellent',
  true,
  'A',
  true,
  NOW() - INTERVAL '1 day'
),
(
  'f2e3d4c5-b6a7-8f90-1234-567890123456',
  7.9,
  'good',
  true,
  'A',
  true,
  NOW() - INTERVAL '4 days'
),
(
  '12345678-9abc-def0-1234-567890abcdef',
  9.2,
  'excellent',
  true,
  'A',
  true,
  NOW() - INTERVAL '6 days'
);

-- Insert weekly earnings for these posts
INSERT INTO weekly_earnings (
  post_id,
  week_start,
  week_end,
  base_earnings,
  bonus_earnings,
  total_earnings
) VALUES 
(
  'e1f2a3b4-c5d6-7e8f-9012-345678901234',
  CURRENT_DATE - INTERVAL '7 days',
  CURRENT_DATE,
  85.00,
  93.50,
  178.50
),
(
  'f2e3d4c5-b6a7-8f90-1234-567890123456',
  CURRENT_DATE - INTERVAL '7 days',
  CURRENT_DATE,
  72.00,
  57.60,
  129.60
),
(
  '12345678-9abc-def0-1234-567890abcdef',
  CURRENT_DATE - INTERVAL '7 days',
  CURRENT_DATE,
  95.00,
  142.50,
  237.50
);