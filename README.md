# security-quiz

A static CompTIA Security+ (SY0-701) quiz web app, served via nginx + docker-compose.

## Features
- Question bank loaded from JSON files (`src/questions*.json`) — add more files and register them in `QUESTION_SOURCES` in `src/index.html`.
- Choose exam size at start: 20 / 50 / 100 / all — questions are randomly sampled.
- Freely reorder / sort questions (drag-and-drop) and reroll a new random set.
- Import/export the question bank as JSON.
- Bilingual explanations (English + 中文註記).
- Live scoring with answer locking; session persists in localStorage.

## Run
```bash
docker compose up -d
# open http://localhost:8080
```
> Note: the app uses `fetch()` to load the JSON banks, so it must be served over HTTP (docker), not opened via `file://`.

## Question bank
311 questions total: 8 original + 303 SY0-701 exam-bank items (ids 1001–1305), each with bilingual explanations.
