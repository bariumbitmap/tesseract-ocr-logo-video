WEBM:=warner_home_video.mp4
#JPG=$(wildcard jpg/*.jpg)
#TESSERACT_PDF=$(patsubst jpg/%.jpg,tesseract/%_debug.pdf,$(JPG))
#TESSERACT_TXT=$(patsubst jpg/%.jpg,tesseract/%.txt,$(JPG))

.PHONY: run
run: 
	./split-video.sh "$(WEBM)" jpg/
	./tesseract.sh jpg/ tesseract/
	./pdf2png.sh tesseract/


.PHONY: clean
clean:
	rm --force -- jpg/*.jpg tesseract/*.pdf tesseract/*.txt no-images/*.png no-lines/*.png page-seg-input/*.png
