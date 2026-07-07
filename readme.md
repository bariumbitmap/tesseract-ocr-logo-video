Uses the debug output of the [Tesseract OCR engine](https://tesseractocr.org/)
to make a colorful video effect.

## Links

https://www.youtube.com/watch?v=MIegPi3e4-Q

https://vimeo.com/1207558124

https://www.reddit.com/r/logoeditingfandom/comments/1upf5jg/warner_home_video_but_its_tesseract_ocr_debug/

https://github.com/bariumbitmap/tesseract-ocr-logo-video


## Implementation

Makefile uses text files emitted on successful completion as sentinel files.
I chose this rather than `.SECONDARY_EXPANSION`
