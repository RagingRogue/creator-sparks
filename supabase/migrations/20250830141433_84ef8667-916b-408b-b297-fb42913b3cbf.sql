-- Create function to trigger originality analysis for new posts
CREATE OR REPLACE FUNCTION public.trigger_originality_analysis()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  -- Make HTTP request to analyze-originality edge function
  -- This will run in the background after the post is inserted
  PERFORM net.http_post(
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

-- Create trigger to automatically analyze originality when new posts are created
CREATE TRIGGER analyze_post_originality
  AFTER INSERT ON public.posts
  FOR EACH ROW
  EXECUTE FUNCTION public.trigger_originality_analysis();

-- Enable pg_net extension for HTTP requests
CREATE EXTENSION IF NOT EXISTS pg_net;