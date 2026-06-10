#!/bin/bash
# AutoPilot Sites — Deployment Script
# Usage: ./deploy.sh [production|staging]
#
# Builds the Astro site to dist/ and outputs instructions for deployment.
# Works with any static host: Netlify, Vercel, Cloudflare Pages, etc.

set -e

echo "🚀 AutoPilot Sites — Build & Deploy"
echo "==================================="

# Navigate to project root
cd "$(dirname "$0")"

echo "📦 Installing dependencies..."
npm install --silent

echo "🏗️  Building site..."
npm run build

echo ""
echo "✅ Build complete! Site output: $(pwd)/dist/"
echo ""
echo "📁 Files generated:"
ls -lh dist/ | head -20
echo ""
echo "📤 Ready to deploy from dist/ to your static host."
echo ""
echo "   Popular deployment targets:"
echo "   - Netlify:         npx netlify deploy --prod --dir=dist"
echo "   - Vercel:          npx vercel --prod dist/"
echo "   - Cloudflare Pages: npx wrangler pages deploy dist/"
echo "   - Any S3 bucket:   aws s3 sync dist/ s3://your-bucket/ --delete"
echo ""
echo "🌐 Preview locally:   npx http-server dist/ --port 3000 --host 0.0.0.0"