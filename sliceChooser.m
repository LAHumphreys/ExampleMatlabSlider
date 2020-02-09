classdef SliceChooser
    properties
        numOptions = 300;
        graphFn;
    end

    methods (Access = public)
        function p = SliceChooser(numOptions, graphFn)
            p.numOptions = numOptions;
            p.graphFn = graphFn;
        end

        function runPicker(p, fig)
            setupPickerWindow(p, fig, p.graphFn);
        end
    end

    methods (Access = private)
        function setupPickerWindow(p, fig, graphFn)
            clf(fig);
            sliderHandle = addSlider(p, fig, graphFn);

            % re-draw the UI components when canvass is resized
            addlistener(fig, "position", @() redrawPicker(p, fig, sliderHandle));

            % When the slider is moved, trigger a re-draw
            addlistener(sliderHandle, "value", @() requestNewGraph(p, sliderHandle, graphFn));

            % Draw the UI controls
            redrawPicker(p, fig, sliderHandle)

            % All set-up, ask for the initial graph to be drawn
            requestNewGraph(p, sliderHandle, graphFn);
        end

        function winHandle = addSlider(p, fig, graphFn)
           winHandle = uicontrol(
               fig,
               "style",      "slider",
               "position",   [0, 10, 400 20],
               "value",      5,
               "sliderstep", [1/p.numOptions, 0.2],
               "min",        1,
               "max",        p.numOptions+1
           );
           redrawPicker(p, fig, winHandle);
        end

        function requestNewGraph(p, winH, graphFn)
            val = get(winH, "value");
            graphFn(round(val));
        end

        function redrawPicker(p, fig, sliderHandle)
            UI_HCentreControl(fig, sliderHandle)
        end
    end
end
