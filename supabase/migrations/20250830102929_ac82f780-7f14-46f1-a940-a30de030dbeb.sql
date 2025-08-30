-- Insert fraud detector role for existing user
INSERT INTO public.user_roles (user_id, role) 
VALUES ('8fb77f8e-cc82-46ee-8774-1a1dd83b91f3', 'fraud_detector')
ON CONFLICT (user_id, role) DO NOTHING;