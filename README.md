# security-quiz

[![build](https://github.com/Openbox7681/security-quiz/actions/workflows/docker.yml/badge.svg)](https://github.com/Openbox7681/security-quiz/actions/workflows/docker.yml)

A static **CompTIA Security+ (SY0-701)** quiz web app, served via nginx + Docker.

繁體中文說明請見 **[README.zh-TW.md](README.zh-TW.md)**.

![Overview](docs/screenshots/overview.svg)

> The image above is a mockup — see [docs/screenshots/](docs/screenshots/) to swap in real screenshots.

## Features

- **File-based question bank** — questions live in `src/questions*.json`. Add a new file and register it in `QUESTION_SOURCES` in `src/index.html`.
- **Pick exam size at start** — 20 / 50 / 100 / all; questions are randomly sampled (Fisher–Yates).
- **Reorder & reroll** — drag-and-drop to reorder, sort by id, shuffle, or reroll a fresh random set.
- **Import / export** the question bank as JSON.
- **Bilingual explanations** — English sentence + 中文註記 in every `exp` field.
- **Live scoring** with answer locking; the session persists in `localStorage` (refresh keeps the same exam).

## Run locally

```bash
docker compose up -d
# open http://localhost:8080
```

> The app uses `fetch()` to load the JSON banks, so it must be served over HTTP (Docker), **not** opened via `file://`.

## Run the published image

Every push to `main` builds and publishes an image to GitHub Container Registry:

```bash
docker run -d -p 8080:80 ghcr.io/openbox7681/security-quiz:latest
# open http://localhost:8080
```

## Question bank

**311 questions total** — 8 original + 303 SY0-701 exam-bank items (ids `1001`–`1305`), each with bilingual explanations.

### Question schema

```json
{
  "id": 1213,
  "tags": ["SY0-701", "Cryptography"],
  "q": "Which of the following would be the most appropriate way to protect data in transit?",
  "options": { "A": "SHA-256", "B": "SSL 3.0", "C": "TLS 1.3", "D": "AES-256" },
  "correct": "C",
  "exp": "TLS 1.3 provides strong encryption for data in transit. 保護傳輸中資料應用 TLS 1.3。"
}
```

Multi-answer questions carry the `複選` tag and store `correct` as multiple letters (e.g. `"BF"`).

### Adding more questions

1. Create `src/questions-sy0701-6.json` (or any name) following the schema above, using fresh ids.
2. Add the filename to `QUESTION_SOURCES` in [`src/index.html`](src/index.html).
3. Commit and push — CI validates the JSON (parse + duplicate-id check) and republishes the image.

## CI

`.github/workflows/docker.yml`:

- **validate** — parses every `questions*.json`, checks required fields, and fails on duplicate ids or a `correct` letter missing from `options`; also syntax-checks the inline JS in `index.html`.
- **docker** — on push to `main`, builds the image and pushes it to `ghcr.io/openbox7681/security-quiz`.
