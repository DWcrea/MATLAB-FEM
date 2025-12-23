classdef STRLoadcase
    properties
        Id;
        Name; 
    end
    methods
        function obj = STRLoadcase(id,name)
            obj.Id = id;
            obj.Name = name;
        end
        function ToString(obj)
            fprintf('Load case (%s) #%i\n',obj.Name,obj.Id);
        end
    end
end