# Fraud Detection System Integration

## Overview
This document explains how to integrate and use the fraud detection system with your TikTok Creator Dashboard.

## Components

### 1. Flask Fraud Detection Service (`fraud_detection_app.py`)
A Python Flask application that runs fraud detection algorithms on your posts data.

#### Setup Instructions:
1. **Install dependencies:**
   ```bash
   pip install flask supabase python-dotenv
   ```

2. **Get Service Role Key:**
   - Go to Supabase Dashboard > Settings > API
   - Copy the `service_role` key (not the `anon` key)
   - Replace `YOUR_SERVICE_ROLE_KEY_HERE` in the code

3. **Configure Authentication:**
   - The fraud detector user is already created with email: `fraud-detector@gmail.com`
   - User ID: `8fb77f8e-cc82-46ee-8774-1a1dd83b91f3`
   - Role: `fraud_detector` (already assigned)
   - Set the password to `fraud1234` or update the code with correct password

4. **Run the service:**
   ```bash
   python fraud_detection_app.py
   ```

### 2. Detection Algorithms

#### Suspicious Engagement Detection
- Flags posts with >15% engagement rate and >100 total engagements
- Indicates potential bot activity

#### Rapid Earnings Growth Detection  
- Flags posts earning >$50 per 1k views and >$100 total
- Indicates potential earnings manipulation

#### Suspicious Account Patterns
- Flags users with >50% of posts frozen (minimum 3 posts)
- Indicates problematic account behavior

#### Low Quality Content Detection
- Flags posts with grades D/F or <30% engagement score
- Indicates content quality issues

### 3. API Endpoints

#### Trigger Fraud Detection
```bash
POST http://localhost:5000/api/detect_fraud
```

#### Get All Fraud Alerts
```bash
GET http://localhost:5000/api/fraud_alerts
```

#### Resolve Fraud Alert
```bash
POST http://localhost:5000/api/fraud_alerts/{alert_id}/resolve
```

### 4. Dashboard Integration

The main dashboard now shows:
- **Fraud Alert Count**: In the overview stats
- **Post-level Alerts**: Individual posts display fraud alert badges
- **Visual Indicators**: Red badges for frozen posts and fraud alerts

#### PostCard Component Updates:
- Shows "FROZEN" badge for frozen posts
- Shows "X ALERTS" badge for posts with fraud alerts
- Uses Shield icon for fraud alerts
- Real-time fraud alert fetching via React Query

### 5. Scheduling Fraud Detection

#### Option A: Cron Job (Recommended)
```bash
# Add to crontab (runs every hour)
0 * * * * curl -X POST http://localhost:5000/api/detect_fraud
```

#### Option B: Webhook Integration
Set up Supabase webhooks to trigger fraud detection when new posts are created.

#### Option C: Manual Trigger
Run fraud detection manually from the Flask service or via API calls.

## Database Schema

### fraud_alerts Table
- `id`: UUID primary key
- `post_id`: Reference to posts table
- `alert_type`: Type of fraud detected
- `severity`: high, medium, low
- `description`: Human-readable alert description
- `detected_at`: When the alert was created
- `is_resolved`: Boolean flag for alert status
- `resolved_at`: When the alert was resolved

### Row Level Security
The fraud_alerts table has RLS policies that:
- Allow users to view alerts for their own posts
- Allow fraud_detector and admin roles to create/update alerts
- Prevent unauthorized access to fraud data

## Monitoring and Maintenance

1. **Check Flask service logs** for any errors
2. **Monitor API response times** for performance issues
3. **Review false positives** and adjust thresholds as needed
4. **Update detection algorithms** based on new fraud patterns
5. **Rotate service keys** periodically for security

## Troubleshooting

### Common Issues:
1. **Authentication Failed**: Check service role key and user credentials
2. **No Alerts Created**: Verify RLS policies and user permissions
3. **Service Not Running**: Check if Flask service is active on port 5000
4. **Database Errors**: Verify Supabase connection and table permissions

### Logs to Check:
- Flask application logs
- Supabase function logs
- Network request logs in browser developer tools

## Security Considerations

1. **Service Role Key**: Keep the service role key secure and rotate regularly
2. **Network Access**: Consider running Flask service on internal network only
3. **Rate Limiting**: Implement rate limiting on API endpoints
4. **Audit Trail**: Monitor who resolves fraud alerts
5. **Data Privacy**: Ensure fraud detection complies with privacy policies

## Future Enhancements

1. **Machine Learning**: Implement ML-based fraud detection
2. **Real-time Alerts**: Add push notifications for critical fraud
3. **Batch Processing**: Process large datasets more efficiently
4. **Advanced Analytics**: Add fraud trend analysis and reporting
5. **Integration**: Connect with external fraud detection services