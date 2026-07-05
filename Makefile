VIDEO_IN:=warner_home_video.mp4
VIDEO_OUT:=ocr_warner_home_video.mp4
COMPLETED:= \
ffmpeg-split_completed.txt \
tesseract_completed.txt \
pdf2png_completed.txt \
montage2x2_completed.txt
SH:=ffmpeg-split.sh tesseract.sh pdf2png.sh montage_2x2.sh ffmpeg-concatenate.sh

$(VIDEO_OUT): ffmpeg-concatenate.sh montage2x2_completed.txt
	./ffmpeg-concatenate.sh combined/ $@ 60

montage2x2_completed.txt: montage_2x2.sh pdf2png_completed.txt
	./montage_2x2.sh combined/ $@

pdf2png_completed.txt : pdf2png.sh tesseract_completed.txt
	./pdf2png.sh tesseract/ $@

tesseract_completed.txt : tesseract.sh ffmpeg-split_completed.txt
	./tesseract.sh jpg/ tesseract/ $@

ffmpeg-split_completed.txt : ffmpeg-split.sh $(VIDEO_IN)
	./ffmpeg-split.sh $(VIDEO_IN) jpg/ $@

.PHONY: clean
clean:
	rm --force -- $(VIDEO_OUT) $(COMPLETED) jpg/*.jpg tesseract/*.pdf tesseract/*.txt no-images/*.png no-lines/*.png page-seg-input/*.png combined/*.png
