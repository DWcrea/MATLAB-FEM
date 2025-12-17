classdef STRLine
    properties
        Id;
        Node1;
        Node2;
    end
    methods
        function obj = STRLine(id,node1,node2)
            obj.Id = id;
            obj.Node1 = node1;
            obj.Node2 = node2;
        end
        function ToString(obj)
                fprintf('Line #%i (N%i -> N%i)\n',obj.Id,obj.Node1.Id,obj.Node2.Id)
        end
    end
end