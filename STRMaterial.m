classdef STRMaterial
    properties
        Id;
        Name;
        E;
        G;
        nu;
    end 
    methods
        function obj = STRMaterial(id,name,e)
            obj.Id = id;
            obj.Name = name;
            obj.E = e;
        end
        function ToString(obj)
            fprintf('Material (%s) #%i\n',obj.Name,obj.Id);
        end
    end
end

