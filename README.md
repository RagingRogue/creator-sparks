# Creator Sparks

Creator Sparks is a collection of tools for content creators. The project includes a web application built with Vite, React, TypeScript, and Supabase, along with utility scripts for analyzing content integrity.

## Live Demo

Visit: [https://creatorsparktiktok.online]

**Demo login**

- Email: `test@gmail.com`
- Password: `test123456`

## Getting Started

Install dependencies:

```sh
npm install
```

Start the development server:

```sh
npm run dev
```

## Available Scripts

- `npm run dev` – start the Vite development server.
- `npm run build` – create a production build.
- `npm run lint` – run ESLint checks.

## Technologies

- Vite
- TypeScript
- React
- shadcn-ui
- Tailwind CSS
- Supabase

## Additional Tools

The repository also contains a Python-based fraud detection utility:

```sh
python fraud_detection_app.py
```

The repository also contains a Python-based originality detection utility

cd originality_service
python -m venv .venv

Windows: .venv\Scripts\activate

macOS/Linux: source .venv/bin/activate

pip install -r requirements.txt

Start API (FastAPI + Uvicorn)

uvicorn app:app --reload --port 8000

Ensure the required environment variables for Supabase are configured before running this script.
