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
SH:=ffmpeg-split.sh \
    tesseract.sh \
    pdf2png.sh \
    montage_2x2.sh \
    ffmpeg-concatenate.sh

$(VIDEO_OUT): $(VIDEO_OUT_NO_AUDIO)
	ffmpeg -i $< -i $(VIDEO_IN) -map 0:v -map 1:a -c copy -y $@

$(VIDEO_OUT_NO_AUDIO): ffmpeg-concatenate.sh montage2x2_completed.txt
	./ffmpeg-concatenate.sh montage_2x2/ $@ 60

montage2x2_completed.txt: montage_2x2.sh render_pad_completed.txt composite_completed.txt pdf2png_completed.txt
	./montage_2x2.sh montage_2x2/ $@

render_pad_completed.txt: render_txt_completed.txt render_pad.sh
	./render_pad.sh render_txt/ render_pad/ 800 800 $@

render_txt_completed.txt: tesseract_completed.txt render_txt.sh
	./render_txt.sh tesseract/ render_txt/ 900 $@

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
	rm --force -- $(VIDEO_OUT) $(COMPLETED) jpg/*.jpg tesseract/*.pdf tesseract/*.txt no-images/*.png no-lines/*.png page-seg-input/*.png render_txt/*.png render_pad/*.png composited/*.png montage_2x2/*.png

.PHONY: shellcheck
shellcheck:
	shellcheck $(SH)
