classdef STRLine < handle
    properties(Constant)
        Epsilon = 1e-6;
    end
    properties
        Id;
        Node1;
        Node2;
        Section;
        Material;
        Release;
        Vx;
        Vy;
        Vz;
        CG;
    end
    methods
        function obj = STRLine(id,node1,node2)
            obj.Id = id;
            obj.Node1 = node1;
            obj.Node2 = node2;
            obj.Refresh();
        end
        function Refresh(obj)
            obj.CG = [0.5*obj.Node2.X + 0.5*obj.Node1.X, 0.5*obj.Node2.Y + 0.5*obj.Node1.Y,0.5*obj.Node2.Z + 0.5*obj.Node1.Z];
            obj.Vx = [obj.Node2.X - obj.Node1.X, obj.Node2.Y - obj.Node1.Y,obj.Node2.Z - obj.Node1.Z];
            obj.Vx = obj.Vx / norm(obj.Vx);
            if(abs(obj.Vx(1))<STRLine.Epsilon) && ...
                   abs(obj.Vx(2))<STRLine.Epsilon &&...
                   abs(obj.Vx(3))>STRLine.Epsilon
                obj.Vy = [0, 1, 0];
                obj.Vz = cross(obj.Vx,obj.Vy);
                obj.Vz = obj.Vz / norm(obj.Vz);
            else
                vz = [0, 0, 1];
                obj.Vy = cross(vz,obj.Vx);
                obj.Vy = obj.Vy / norm(obj.Vy);
                obj.Vz = cross(obj.Vx,obj.Vy);
                obj.Vz = obj.Vz / norm(obj.Vz);
            end
        end
        function ToString(obj)
                fprintf('Line #%i (N%i -> N%i)\n',obj.Id,obj.Node1.Id,obj.Node2.Id)
                if(~isobject(obj.Material))
                    fprintf('Material: N/A\n');  
                else
                    fprintf('Material: %s\n',obj.Material.Name);
                end
                if(~isobject(obj.Section))
                    fprintf('Section: No Section\n');  
                else
                    fprintf('Section: %s\n',obj.Section.Name);
                end
                if(~isobject(obj.Release))
                    fprintf('Release: No Release\n');  
                else
                    fprintf('Release: %s\n',obj.Release.Name);
                end
        end
    end
end