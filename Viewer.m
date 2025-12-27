classdef Viewer
    properties(Constant)
        Nodesize = 10;
        ArrowLength = 1;
        ArrowTipSize = 0.25;
        ArrowWidth = 0.1;
        LocalArrowThickness = 5;
        NodeFaceColor = 'r';
        LineThickness = 3;
        LineColor = 'b';
        XAixsColor = 'b';
        YAixsColor = 'g';
        ZAixsColor = 'r';
    end
    properties
        Figure;
       
    end
    methods
        function obj = Viewer()
            obj.Figure = figure;
        end
        function Render(obj,controller)
            for i = 1:length(controller.STRNodes)
                targetNode = controller.STRNodes(i);
                obj.RenderSTRNode(targetNode);
            end
            for i = 1:length(controller.STRLines)
                targetLine = controller.STRLines(i);
                obj.RenderSTRLine(targetLine);
            end
            axis equal
        end

        function RenderSTRNode(~,node)
            p = plot3(gca,node.X,node.Y,node.Z,'--rs');
            p.MarkerSize = Viewer.Nodesize;
            p.MarkerFaceColor = Viewer.NodeFaceColor;
            hold on
        end
        function RenderSTRLine(obj,line)
            x = [line.Node1.X,line.Node2.X];
            y = [line.Node1.Y,line.Node2.Y];
            z = [line.Node1.Z,line.Node2.Z];
            p = plot3(gca,x,y,z,'-b');
            p.LineWidth = Viewer.LineThickness;
            p.Color = Viewer.LineColor;
            hold on
            % Draw Loacl X
            obj.PlotArrow(line.CG,line.Vx,obj.XAixsColor,obj.LocalArrowThickness)
            % Draw Loacl Y
            obj.PlotArrow(line.CG,line.Vy,obj.YAixsColor,obj.LocalArrowThickness)
            % Draw Loacl Z
            obj.PlotArrow(line.CG,line.Vz,obj.ZAixsColor,obj.LocalArrowThickness)
        end
        function PlotArrow(~,origin,vx,color,thickness)
            arrowEnd = origin + Viewer.ArrowLength * vx;
            x = [origin(1),arrowEnd(1)];
            y = [origin(2),arrowEnd(2)];
            z = [origin(3),arrowEnd(3)];
            p = plot3(gca,x,y,z,'-b');
            p.LineWidth = thickness;
            p.Color = color;
            hold on
        end
    end
end