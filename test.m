# Dear Octave, this is a script - not a function
1;

WIDTH=30;
HEIGHT=20;

function slice = newSlice(x,y)
    slice = zeros(y, x);
end

function result = makeImage(p)
    global WIDTH;
    global HEIGHT;
    image = newSlice(WIDTH,HEIGHT);
    for i = p:HEIGHT
        image(i,:) += 1;
    end
    result = image;
end

image = makeImage(5);
imagesc(image)
