function runPicker(p, fig, graphFn)
    drawPickerWindow(fig, graphFn);

    function winH = drawPickerWindow(fig, graphFn)
        clf(fig);
        winH = addSlider(p, fig, graphFn);

        % re-centre the slider when the image is re-sized
        addlistener(fig, "position", @() redrawSlider(fig, winH));

        % When the slider is moved, trigger a re-draw
        triggerGraph(winH, graphFn);
        addlistener(winH, "value", @() triggerGraph(winH, graphFn));
    end

    function winHandle = addSlider(p, fig, graphFn)
       winHandle = uicontrol(
           fig,
           "style",      "slider",
           "position",   [0, 10, 400 20],
           "value",      5,
           "sliderstep", [1/p.width, 0.2],
           "min",        1,
           "max",        p.width+1
       );
       UI_HCentreControl(fig, winHandle)
    end

    function triggerGraph(winH, graphFn)
        val = get(winH, "value");
        graphFn(round(val));
    end

    function redrawSlider(fig, winH)
        UI_HCentreControl(fig, winH)
    end
end
