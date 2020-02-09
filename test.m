function test()
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %               Main Function              %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fig = figure(3);
    picker = SliceChooser(DataWidth(), DataHeight(), @(val) drawSlice(val));
    runPicker(picker, fig);

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

end
