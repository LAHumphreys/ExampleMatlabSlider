function UI_HCentreControl(fig, ctrl)
    fpos = get(fig, "position");
    fheight = fpos(4);
    fwidth = fpos(3);

    cpos = get(ctrl, "position");
    cwidth = cpos(3);

    xpos = (fwidth / 2) - (cwidth/2);
    cpos(1) = xpos;
    set(ctrl, "position", cpos);
end
