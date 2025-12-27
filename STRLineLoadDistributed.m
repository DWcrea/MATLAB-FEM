classdef STRLineLoadDistributed < handle
    properties
        Id;
        LoadCaseId;
        FxStart;
        FyStart;
        FzStart;
        MxStart;
        MyStart;
        MzStart;
        RelativelocationStart;
        FxEnd;
        FyEnd;
        FzEnd;
        MxEnd;
        MyEnd;
        MzEnd;
        RelativelocationEnd;
        AppliedTo = [];
    end 
    methods
        function obj = STRLineLoadDistributed(id,loadCaseId,fxS,fyS,fzS,mxS,myS,mzS,relativelocationS,...
                fxE,fyE,fzE,mxE,myE,mzE,relativelocationE)
            obj.Id = id;
            obj.LoadCaseId = loadCaseId;
            obj.FxStart = fxS;
            obj.FyStart = fyS;
            obj.FzStart = fzS;
            obj.MxStart = mxS;
            obj.MyStart = myS;
            obj.MzStart = mzS;
            obj.RelativelocationStart = relativelocationS;
            obj.FxEnd = fxE;
            obj.FyEnd = fyE;
            obj.FzEnd = fzE;
            obj.MxEnd = mxE;
            obj.MyEnd = myE;
            obj.MzEnd = mzE;
            obj.RelativelocationEnd = relativelocationE;
        end
        
        function ToString(obj)
           fprintf('Line Load Distributed #%i LC#%i @S(%4.2f) --> @E(%4.2f)\n',obj.Id,obj.LoadCaseId.Id,obj.RelativelocationStart,obj.RelativelocationEnd);
           fprintf('Fx = %5.2f --> %5.2f\n',obj.FxStart,obj.FxEnd);
           fprintf('Fy = %5.2f --> %5.2f\n',obj.FyStart,obj.FyEnd);
           fprintf('Fz = %5.2f --> %5.2f\n',obj.FyStart,obj.FyEnd);
           fprintf('Mx = %5.2f --> %5.2f\n',obj.MxStart,obj.MxEnd);
           fprintf('My = %5.2f --> %5.2f\n',obj.MyStart,obj.MyEnd);
           fprintf('Mz = %5.2f --> %5.2f\n',obj.MzStart,obj.MzEnd);
           fprintf('Applied To #%i\n',obj.AppliedTo);
        end
    end
end

