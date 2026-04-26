#!/bin/bash
# bookmark.sh - minimal bookmark appender

BOOKMARK_FILE="${BOOKMARK_FILE:-$HOME/bookmarks.md}"

# if bookmark file doesn't exist, create it with a header
[ -f "$BOOKMARK_FILE" ] || echo "# Bookmarks" > "$BOOKMARK_FILE"

bookmark_add() {
    local url="$1"
    local title="$2"

    [ -z "$title" ] && title=$(curl -sL --max-time 10 "$url" \
        | grep -oE '<title[^>]*>[^<]*</title>' \
        | head -1 \
        | sed -E 's/<[^>]+>//g; s/^[[:space:]]+//; s/[[:space:]]+$//')

    [ -z "$title" ] && title="$url"

    mkdir -p "$(dirname "$BOOKMARK_FILE")"
    local today=$(date +%Y-%m-%d)

    if ! grep -q "^## $today$" "$BOOKMARK_FILE" 2>/dev/null; then
        echo -e "\n## $today" >> "$BOOKMARK_FILE"
    fi
    echo "- [$title]($url)" >> "$BOOKMARK_FILE"
    echo "added: $title"
}

case "$1" in
    add)    bookmark_add "$2" "$3" ;;
    show)   bat "$BOOKMARK_FILE" ;;
    list)   less "$BOOKMARK_FILE" ;;
    edit)   vim "$BOOKMARK_FILE" ;;
    view)   glow "$BOOKMARK_FILE" ;;
    search) rg "$2" "$BOOKMARK_FILE" ;;
    *)      echo "usage: bookmark.sh {add|show|list|edit|search}" >&2 ;;
esac
