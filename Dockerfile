# Static CompTIA Security+ quiz served by nginx.
# Bakes ./src into the image so it can run without a volume mount.
FROM nginx:alpine

ENV TZ=Asia/Taipei

COPY src/ /usr/share/nginx/html/

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost/ >/dev/null 2>&1 || exit 1
