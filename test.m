# Dear Octave, this is a script - not a function
1;

function width = DatWidth()
   width = 30;
end

function height = DataHeight()
   height = 20;
end

function [width, height] = FigureSize(fig)
    pos = get(fig, "position")
    height = pos(4);
    width = pos(3);
end

function HCentreControl(fig, ctrl)
   [fwidth, fheight] = FigureSize(fig);
   cpos = get(ctrl, "position");
   cwidth = cpos(3);

   xpos = (fwidth / 2) - (cwidth/2);
   cpos(1) = xpos;
   set(ctrl, "position", cpos);
end

function slice = newSlice(x,y)
    slice = zeros(y, x);
end

function result = makeImage(p)
    image = newSlice(DatWidth(), DataHeight());
    for i = p:DataHeight()
        image(i,:) += 1;
    end
    result = image;
end

function winHandle = addSlider(fig)
   winHandle = uicontrol(
       fig,
       "style",    "slider",
       "position", [0, 10, 400 20],
       "value",    5,
       "min",      1,
       "max",      10
   );
   HCentreControl(fig, winHandle)
end


image = makeImage(5);
image
fig = figure(3);
clf(fig)
winH = addSlider(fig);
imagesc(image);


