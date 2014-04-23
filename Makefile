
ply-image: ply-image.c ply-frame-buffer.c Makefile
	gcc $(CFLAGS) `pkg-config --cflags libpng`  ply-image.c ply-frame-buffer.c -o ply-image  -lm `pkg-config --libs libpng`
	
clean:
	rm -f ply-image *~ gmon.out
	
install: ply-image
	mkdir -p $(DESTDIR)/usr/bin	
	mkdir -p $(DESTDIR)/usr/share/plymouth
	cp ply-image $(DESTDIR)/usr/bin
	
	
