classdef STRNodalLoad < handle
    properties
        Id;
        LoadCaseId;
        Fx;
        Fy;
        Fz;
        Mx;
        My;
        Mz;
        AppliedTo = [];
    end 
    methods
        function obj = STRNodalLoad(id,loadCaseId,fx,fy,fz,mx,my,mz)
            obj.Id = id;
            obj.LoadCaseId = loadCaseId;
            obj.Fx = fx;
            obj.Fy = fy;
            obj.Fz = fz;
            obj.Mx = mx;
            obj.My = my;
            obj.Mz = mz;
        end
        
        function ToString(obj)
           fprintf('Nodal Load #%i LC#%i\n',obj.Id,obj.LoadCaseId.Id);
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

