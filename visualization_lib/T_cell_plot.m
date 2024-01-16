function T_cell_plot(T)

    for k = 1:length(T)
        Tk = T{k};
        t(:,k)=Tk(1:3,4);    
    end 
    axislenx = (max(max(t(1,:)))-min(min(t(1,:))))*0.3;
    axisleny = (max(max(t(2,:)))-min(min(t(2,:))))*0.3;
    axislenz = (max(max(t(3,:)))-min(min(t(3,:))))*0.3;
    axislen = min([axislenx axisleny axislenz]);
    figure(19788)
    Tk = eye(4);
    %draw_axis_from_T( Tk,'w',axislen,0.01,1)
    
    sub=floor(length(T)/10);
    for k = 1:sub:length(T)
        Tk = T{k};

        %draw_axis_from_T( T,'',0.1,0.01,0)
        draw_axis_from_T( Tk,'',axislen,1,0)
        hold on
        grid on
%         drawnow
%         pause(0.3)
    end 
    
    
    plot3(t(1,:),t(2,:),t(3,:))
    hold on
    axis equal
