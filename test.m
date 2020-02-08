# Dear Octave, this is a script - not a function
1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                  Constants               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function width = DataWidth()
   width = 300;
end

function height = DataHeight()
   height = 200;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               UI Utilities               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [width, height] = FigureSize(fig)
    pos = get(fig, "position");
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Slice Picker               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function winH = drawPickerWindow(fig, graphFn)
    clf(fig);
    winH = addSlider(fig, graphFn);

    % re-centre the slider when the image is re-sized
    addlistener(fig, "position", @() redrawSlider(fig, winH));

    % When the slider is moved, trigger a re-draw
    triggerGraph(winH, graphFn);
    addlistener(winH, "value", @() triggerGraph(winH, graphFn));
end

function winHandle = addSlider(fig, graphFn)
   winHandle = uicontrol(
       fig,
       "style",      "slider",
       "position",   [0, 10, 400 20],
       "value",      5,
       "sliderstep", [1/DataWidth(), 0.2],
       "min",        1,
       "max",        DataWidth()+1
   );
   HCentreControl(fig, winHandle)
end

function triggerGraph(winH, graphFn)
    val = get(winH, "value");
    graphFn(round(val));
end

function redrawSlider(fig, winH)
    HCentreControl(fig, winH)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Data Generation            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function slice = newSlice(x,y)
    slice = zeros(y, x);
end

function result = makeImage(p)
    image = newSlice(DataWidth(), DataHeight());
    for i = p:DataWidth()
        image(:,i) += 1;
    end
    result = image;
end

function drawSlice(idx)
    image = makeImage(idx);
    imagesc(image);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Main Function              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


fig = figure(3);
picker = drawPickerWindow(fig, @(val) drawSlice(val));



