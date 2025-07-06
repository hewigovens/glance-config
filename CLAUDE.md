# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Glance dashboard configuration repository that runs a self-hosted dashboard using Docker. Glance is a web dashboard that displays various widgets including markets, weather, server stats, RSS feeds, and custom APIs.

## Required Dependencies

- `dotenvx` - for environment variable management (`pnpm install -g dotenvx`)
- `just` - command runner (`brew install just`)
- Docker and Docker Compose

## Common Commands

All commands should be run with `dotenvx` to load environment variables:

```bash
# Start/restart the dashboard
dotenvx run -- just run

# Update to latest version and restart
dotenvx run -- just update

# Check and update GLANCE_VERSION to latest release if needed
dotenvx run -- just update-version

# List available commands
just --list
```

## Architecture

The application consists of:

1. **Docker Configuration** (`docker-compose.yml`)
   - Single service running `glanceapp/glance` container
   - Mounts `./config` and `./assets` directories
   - Exposes port 8080
   - Uses environment variables for API keys

2. **Configuration Structure**
   - `config/glance.yml` - Main configuration file with server settings, theme, and page includes
   - `config/home.yml` - Dashboard page configuration with widgets and layout
   - `assets/user.css` - Custom CSS styling

3. **Environment Variables** (`.env`)
   - `GLANCE_VERSION` - Version of Glance to run
   - `GITHUB_TOKEN` - For GitHub notifications widget
   - `TAILSCALE_API_KEY` - For Tailscale devices widget
   - `CMC_API_KEY` - For CoinMarketCap fear & greed index

## Widget Configuration

The dashboard uses a column-based layout with three main sections:
- **small** column - Clock, weather, server stats, custom APIs, bookmarks
- **full** column - News feeds (Hacker News, crypto RSS), YouTube videos, embedded charts
- **small** column - Fear & greed index, gas predictions, GitHub notifications, releases

Custom widgets use templating with Go template syntax for rendering API responses.

## Key Files

- `config/glance.yml:15` - Page includes reference
- `config/home.yml:1-217` - Complete dashboard layout and widget configuration
- `justfile:6-11` - Docker commands for running and updating
- `docker-compose.yml:4` - Image version configuration