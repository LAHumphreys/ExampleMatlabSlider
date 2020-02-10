classdef SliceChooser
    properties
        numOptions = 300;
        graphFn;
        onDoneFn;
    end

    methods (Access = public)
        function p = SliceChooser(numOptions, graphFn, onDoneFn)
            p.numOptions = numOptions;
            p.graphFn = graphFn;
            p.onDoneFn = onDoneFn;
        end

        function runPicker(p, fig)
            setupPickerWindow(p, fig, p.graphFn);
        end
    end

    methods (Access = private)
        function setupPickerWindow(p, fig, graphFn)
            clf(fig);
            sliderHandle = addSlider(p, fig);
            buttonHandle = addOnDoneButton(p, fig, sliderHandle);

            % re-draw the UI components when canvass is resized
            addlistener(fig, "position", @() redrawPicker(p, fig, sliderHandle, buttonHandle));

            % When the slider is moved, trigger a re-draw
            addlistener(sliderHandle, "value", @() requestNewGraph(p, sliderHandle, graphFn));

            % Draw the UI controls
            redrawPicker(p, fig, sliderHandle, buttonHandle)

            % All set-up, ask for the initial graph to be drawn
            requestNewGraph(p, sliderHandle, graphFn);
        end

        function sliderHandle = addSlider(p, fig)
           sliderHandle = uicontrol(
               fig,
               "style",      "slider",
               "position",   [0, 10, 400 20],
               "value",      5,
               "sliderstep", [1/p.numOptions, 0.2],
               "min",        1,
               "max",        p.numOptions+1
           );
        end

        function buttonHandle = addOnDoneButton(p, fig, sliderHandle)
           buttonAction = @() notifyDone(p, sliderHandle);
           buttonHandle = uicontrol(
               fig,
               "style",          "pushbutton",
               "position",       [0, 10, 100, 20],
               "string",         "Done!",
               "callback",       buttonAction
           );
        end

        function requestNewGraph(p, winH, graphFn)
            val = get(winH, "value");
            graphFn(round(val));
        end

        function notifyDone(p, sliderHandle)
            disp("DONE!");
            val = get(sliderHandle, "value");
            p.onDoneFn(round(val));
        end

        function redrawPicker(p, fig, sliderHandle, button)
            UI_HCentreControl(fig, sliderHandle);
            UI_HPlaceAfter(sliderHandle, button, 30);
        end
    end
end
