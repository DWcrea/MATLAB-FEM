classdef STRLineLoadConcentrated < handle
    properties
        Id;
        Fx;
        Fy;
        Fz;
        Mx;
        My;
        Mz;
        AppliedTo = [];
        Relativelocation;
    end 
    methods
        function obj = STRLineLoadConcentrated(id,fx,fy,fz,mx,my,mz,relativelocation)
            obj.Id = id;
            obj.Fx = fx;
            obj.Fy = fy;
            obj.Fz = fz;
            obj.Mx = mx;
            obj.My = my;
            obj.Mz = mz;
            obj.Relativelocation = relativelocation;
        end
        
        function ToString(obj)
           fprintf('Line Load Concentrated #%i @(%4.2f)\n',obj.Id,obj.Relativelocation);
           fprintf('Fx = %5.2f\n',obj.Fx);
           fprintf('Fy = %5.2f\n',obj.Fy);
           fprintf('Fz = %5.2f\n',obj.Fz);
           fprintf('Mx = %5.2f\n',obj.Mx);
           fprintf('My = %5.2f\n',obj.My);
           fprintf('Mz = %5.2f\n',obj.Mz);
           fprintf('Applied To #%i\n',obj.AppliedTo);
        end
    end
end

