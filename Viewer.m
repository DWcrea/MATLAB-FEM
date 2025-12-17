classdef Viewer
    properties
        Figure;
        nodesize = 0.1 ;
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
        end

        function RenderSTRNode(obj,node)
            plot3(gca,node.X,node.Y,node.Z,'--rs');
            hold on
        end
        function RenderSTRLine(obj,line)
            x = [line.Node1.X,line.Node2.X];
            y = [line.Node1.Y,line.Node2.Y];
            z = [line.Node1.Z,line.Node2.Z];
            plot3(gca,x,y,z,'-b');
            hold on
        end
    end
end