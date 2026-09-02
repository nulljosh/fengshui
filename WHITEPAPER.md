# Feng Shui Technical Whitepaper

**v1.0** | August 2026

Is the place you live any good? Eva Wong's *Good Fengshui*, condensed into a
reader and a 24-question assessment that work offline. Web plus a native SwiftUI
iOS app.

## Problem

Reference material like this is read in short, repeated visits: look up one
principle, close the app. That rules out anything with a login, a network round
trip, or a loading state. The whole book is small enough to ship as text, so it is.

## Content model

`content.md` is the single source of truth: one Markdown file, chapters delimited by
headings. The web reader and the iOS app both parse that same file, so a content
edit is one commit and both platforms move together. There is no CMS, no database,
and no content API.

## Web

`index.html` is a static chapter reader with a sidebar table of contents, the same
viewer pattern used by [uprighty](https://github.com/nulljosh/uprighty). It parses
`content.md` at load, builds the TOC from the heading structure, and renders inline.
No build step and no framework.

## iOS

`ios/FengShui` is a native SwiftUI app: a chapter list backed by `content.md`
bundled into the app, rendered inline. No backend, so it works fully offline and has
no failure mode beyond the app itself.

## Design decisions

- **One content file, two renderers.** The alternative, per-platform content, is
  the failure mode where the app and the site drift apart.
- **Ship the text, not a fetch.** Bundling the content removes the network from the
  read path entirely.
- **No accounts.** Nothing here is personal, so nothing needs to be stored.

## License

MIT 2026, Joshua Trommel
