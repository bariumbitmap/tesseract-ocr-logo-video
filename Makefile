VIDEO_IN:=warner_home_video.mp4
VIDEO_OUT:=ocr_warner_home_video.mp4
VIDEO_OUT_NO_AUDIO:=ocr_warner_home_video_no_audio.mp4
COMPLETED:=ffmpeg-split_completed.txt \
tesseract_completed.txt \
render_txt_completed.txt \
render_pad_completed.txt \
pdf2png_completed.txt \
composite_completed.txt \
montage2x2_completed.txt
PNG_DIRS:=no-images no-lines page-seg-input render_txt render_pad composited montage_2x2
PNG_GLOB:=$(patsubst %,%/*.png,$(PNG_DIRS))
SH:=ffmpeg-split.sh \
    tesseract.sh \
    pdf2png.sh \
    composite.sh \
    render_txt.sh \
    render_pad.sh \
    montage_2x2.sh \
    ffmpeg-concatenate.sh

$(VIDEO_OUT): $(VIDEO_OUT_NO_AUDIO)
	ffmpeg -i $< -i $(VIDEO_IN) -map 0:v -map 1:a -c copy -y $@

$(VIDEO_OUT_NO_AUDIO): ffmpeg-concatenate.sh montage2x2_completed.txt
	./ffmpeg-concatenate.sh montage_2x2/ $@

montage2x2_completed.txt: montage_2x2.sh render_pad_completed.txt composite_completed.txt pdf2png_completed.txt
	./montage_2x2.sh montage_2x2/ $@

render_pad_completed.txt: render_txt_completed.txt render_pad.sh
	./render_pad.sh render_txt/ render_pad/ $@

render_txt_completed.txt: tesseract_completed.txt render_txt.sh
	./render_txt.sh tesseract/ render_txt/ $@

composite_completed.txt: composite.sh pdf2png_completed.txt
	./composite.sh composited/ $@

pdf2png_completed.txt : pdf2png.sh tesseract_completed.txt
	./pdf2png.sh tesseract/ $@

tesseract_completed.txt : tesseract.sh ffmpeg-split_completed.txt
	./tesseract.sh jpg/ tesseract/ $@

ffmpeg-split_completed.txt : ffmpeg-split.sh $(VIDEO_IN)
	./ffmpeg-split.sh $(VIDEO_IN) jpg/ $@

.PHONY: clean
clean:
	rm --force -- $(VIDEO_OUT) $(VIDEO_OUT_NO_AUDIO) $(COMPLETED) jpg/*.jpg tesseract/*.pdf tesseract/*.txt $(PNG_GLOB)

.PHONY: shellcheck
shellcheck:
	shellcheck $(SH)
