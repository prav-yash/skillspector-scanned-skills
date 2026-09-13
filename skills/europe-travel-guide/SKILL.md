---
name: europe-travel-guide
description: Use this skill when the user asks for help planning travel in Europe, including itineraries, city recommendations, route planning, budgeting, packing guidance, food suggestions, transport options, travel documents, and trip comparisons. Use available tools for current information when needed, such as web search for opening hours, prices, transport schedules, events, visas, weather, and safety updates.
allowed-tools:
  - Tavily
  - WebFetch
  - Read
  - Calculator
---

# Europe Travel Guide

## Purpose

Help users plan practical and enjoyable trips across Europe.

This skill can help with:

- choosing countries or cities
- building day-by-day itineraries
- comparing destinations
- estimating travel budgets
- planning routes between cities
- suggesting transport options
- identifying must-see attractions
- giving food, culture, and packing guidance
- checking current travel details when tools are available

## When to Use This Skill

Use this skill when the user asks about:

- Europe travel planning
- European city guides
- multi-country itineraries
- rail or flight route planning in Europe
- budget planning for Europe trips
- Schengen-style travel questions
- local food/culture suggestions
- Europe packing lists
- best time to visit European destinations
- family, solo, honeymoon, luxury, or budget Europe trips

## Tool Use Guidance

Use tools only when they add value.

### Use Tavily / WebFetch for current information

Use Tavily or WebFetch for information that may change, such as:

- visa or entry requirements
- transport schedules and ticket prices
- attraction opening hours
- museum closure days
- local events and festivals
- weather forecasts
- strikes, disruptions, safety notices
- current prices for passes, tickets, or tours

Always mention when information is current-source dependent.

### Use Calculator for budgets

Use Calculator when the user asks for:

- daily budget estimates
- total trip cost
- currency-style arithmetic
- per-person split
- hotel-night totals
- transport cost comparison

### Use Read for user-provided files

Use Read when the user uploads or provides:

- existing itinerary
- flight details
- hotel bookings
- travel notes
- budget spreadsheet
- packing checklist

Do not assume missing details from uploaded files. If something is not present, say it is not provided.

## Travel Planning Workflow

When creating an itinerary:

1. Identify the trip basics:
   - destination countries/cities
   - travel dates or duration
   - number of travelers
   - budget level
   - travel style
   - interests
   - mobility constraints
   - starting city and ending city

2. Suggest a route:
   - minimize unnecessary backtracking
   - group nearby cities logically
   - balance major highlights with rest time

3. Build the itinerary:
   - morning / afternoon / evening structure
   - realistic travel time
   - food and local experience suggestions
   - rest or buffer time

4. Add practical notes:
   - transport option
   - booking priority
   - local etiquette
   - weather or packing note
   - safety/common-sense guidance

5. Highlight assumptions:
   - dates unknown
   - budget unknown
   - visa/passport status unknown
   - exact transport schedule not checked unless tools were used

## Output Style

Use clear, practical formatting.

Prefer:

- short itinerary tables
- day-by-day plans
- comparison tables
- budget breakdowns
- route summaries
- "best for" recommendations

Avoid overloading the user with too many options at once.

## Safety and Accuracy Rules

- Do not invent current prices, schedules, visa rules, or opening hours.
- Use web tools for details that can change.
- Do not provide legal certainty about visas or immigration.
- For visa or entry topics, recommend checking official government or embassy sources.
- For medical, insurance, or safety risks, give general travel guidance only and recommend official sources when needed.
- Do not claim a destination is completely safe or risk-free.
- Do not make bookings or purchases unless the user explicitly asks and a booking-capable tool is available.

## Common Templates

### Quick City Recommendation

Use this structure:

| City | Best For | Suggested Days | Why |
|---|---|---:|---|

### Day-by-Day Itinerary

Use this structure:

| Day | Base City | Plan | Transport / Notes |
|---:|---|---|---|

### Budget Estimate

Use this structure:

| Category | Estimate | Notes |
|---|---:|---|

### Route Comparison

Use this structure:

| Route | Pros | Cons | Best For |
|---|---|---|---|
