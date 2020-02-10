function UI_HPlaceAfter(leftCtrl, rightCtrl, padding)
    lpos = get(leftCtrl, "position");
    rpos = get(rightCtrl, "position");

    % Vertically align the controls
    rpos(2) = lpos(2);
    rpos(4) = lpos(4);

    rpos(1) = lpos(1) + lpos(3) + padding;

    set(rightCtrl, "position", rpos);
end
