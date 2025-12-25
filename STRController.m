classdef STRController < handle
    properties
        Epsilon = 1e-6;
        STRNodeID = 0;
        STRLineID = 0;
        STRSupportID = 0;
        STRSectionID = 0;
        STRMaterialID = 0;
        STRReleaseID = 0;
        STRLoadcaseID = 0;
        STRNodalLoadID = 0;
        STRLineLoadConcentratedID = 0;
        STRLineLoadDistributedID = 0;
        STRNodes;
        STRLines;
        STRSupports;
        STRSections;
        STRMaterials;
        STRReleases;
        STRLoadcases;
        STRNodalLoads;
        STRLineLoadConcentrateds;
        STRLineLoadDistributeds;
    end
    methods
        % 构造函数
        function obj = STRController()
            % 暂时为空
        end
        function node = AddSTRNode(obj, x, y, z)
            for index = 1:length(obj.STRNodes)
                existingNode = obj.STRNodes(index);
                
                % 使用 Epsilon 进行数值比较 (防止 4.99999 != 5 的问题)
                % 检查 X, Y, Z 是否都在误差范围内
                if abs(existingNode.X - x) < obj.Epsilon && ...
                   abs(existingNode.Y - y) < obj.Epsilon && ...
                   abs(existingNode.Z - z) < obj.Epsilon
               
                    % 如果找到重复节点
                    disp('Node exists'); % (可选) 打印调试信息
                    node = existingNode; % 直接返回已存在的节点
                    return;              % 退出函数，不执行后续创建代码
                end
            end
            
            % 2. 如果没有重复，创建新节点
            obj.STRNodeID = obj.STRNodeID + 1;
            
            % 假设 STRNode 类已定义 (ID, x, y, z)
            node = STRNode(obj.STRNodeID, x, y, z);
            
            % 3. 将新节点存入列表
            % 注意：虽然 MATLAB 推荐预分配内存，但为了通过简单代码演示，
            % 这里使用了动态扩容 (concatenation)
            obj.STRNodes = [obj.STRNodes, node];
        end
        function line = AddSTRLine(obj,node1,node2)
            for i = 1:length(obj.STRLines)
                existingLine = obj.STRLines(i);
                if(existingLine.Node1.Id == node1.Id && ...
                    existingLine.Node2.Id == node2.Id)
                    line = existingLine;
                    return;
                end
                if(existingLine.Node2.Id == node1.Id && ...
                    existingLine.Node1.Id == node2.Id)
                    line = existingLine;
                    return;
                end
            end
            obj.STRLineID = obj.STRLineID + 1;
            id = obj.STRLineID;
            line = STRLine(id,node1,node2);
            obj.STRLines = [obj.STRLines,line];
        end
        %% Load rigion
        function ApplyLoad(~,load,appliedto)
            for i = 1:length(appliedto)
                id = appliedto(i);
                if(~any(load.AppliedTo==id))
                    load.AppliedTo = [load.AppliedTo,id];
                end
            end
            load.AppliedTo = sort(load.AppliedTo);
        end
        function DeleteLoad(~,load)
            load.AppliedTo = [];
        end
        %% Line Load Distributed rigion
        function lineloaddis = AddSTRLineLoadDistributed(obj,fxS,fyS,fzS,mxS,myS,mzS,relativelocationS,...
                fxE,fyE,fzE,mxE,myE,mzE,relativelocationE)
            obj.STRLineLoadDistributedID = obj.STRLineLoadDistributedID + 1;
            id = obj.STRLineLoadDistributedID;
            lineloaddis = STRLineLoadDistributed(id,fxS,fyS,fzS,mxS,myS,mzS,relativelocationS,...
                fxE,fyE,fzE,mxE,myE,mzE,relativelocationE);
            obj.STRLineLoadDistributeds = [obj.STRLineLoadDistributeds,lineloaddis];
        end
        %% Line Load Concentrated rigion
        function lineload = AddSTRLineLoadConcentrated(obj,fx,fy,fz,mx,my,mz,relativelocation)
            obj.STRLineLoadConcentratedID = obj.STRLineLoadConcentratedID + 1;
            id = obj.STRLineLoadConcentratedID;
            lineload = STRLineLoadConcentrated(id,fx,fy,fz,mx,my,mz,relativelocation);
            obj.STRLineLoadConcentrateds = [obj.STRLineLoadConcentrateds,lineload];
        end
        %% Nodal Load rigion
        function nodalload = AddSTRNodalLoad(obj,fx,fy,fz,mx,my,mz)
            obj.STRNodalLoadID = obj.STRNodalLoadID + 1;
            id = obj.STRNodalLoadID;
            nodalload = STRNodalLoad(id,fx,fy,fz,mx,my,mz);
            obj.STRNodalLoads = [obj.STRNodalLoads,nodalload];
        end
        %% Load case rigion
        function loadcase = AddSTRLoadcase(obj,name)
            obj.STRLoadcaseID = obj.STRLoadcaseID + 1;
            id = obj.STRLoadcaseID;
            loadcase = STRLoadcase(id,name);
            obj.STRLoadcases = [obj.STRLoadcases,loadcase];
        end
        %% Release rigion
        function release = AddSTRRelease(obj,name,kux1,kuy1,kuz1,krx1,kry1,krz1,kux2,kuy2,kuz2,krx2,kry2,krz2)
            obj.STRReleaseID = obj.STRReleaseID + 1;
            id = obj.STRReleaseID;
            release = STRRelease(id,name,kux1,kuy1,kuz1,krx1,kry1,krz1,kux2,kuy2,kuz2,krx2,kry2,krz2);
            obj.STRReleases = [obj.STRReleases,release];
        end
        function release = AddSTRReleaseRigidPinned(obj,name)
            obj.STRReleaseID = obj.STRReleaseID + 1;
            id = obj.STRReleaseID;
            release = STRRelease(id,name,STRRelease.KURigid,STRRelease.KURigid,STRRelease.KURigid,...
                STRRelease.KRRigid,STRRelease.KRRigid,STRRelease.KRRigid,...
                STRRelease.KURigid,STRRelease.KURigid,STRRelease.KURigid,...
                STRRelease.KRFree,STRRelease.KRFree,STRRelease.KRFree);
            obj.STRReleases = [obj.STRReleases,release];
        end
        function release = AddSTRReleasePinnedRigid(obj,name)
            obj.STRReleaseID = obj.STRReleaseID + 1;
            id = obj.STRReleaseID;
            release = STRRelease(id,name,STRRelease.KURigid,STRRelease.KURigid,STRRelease.KURigid,...
                STRRelease.KRFree,STRRelease.KRFree,STRRelease.KRFree,...
                STRRelease.KURigid,STRRelease.KURigid,STRRelease.KURigid,...
                STRRelease.KRRigid,STRRelease.KRRigid,STRRelease.KRRigid);
            obj.STRReleases = [obj.STRReleases,release];
        end
        function release = AddSTRReleasePinnedPinned(obj,name)
            obj.STRReleaseID = obj.STRReleaseID + 1;
            id = obj.STRReleaseID;
            release = STRRelease(id,name,STRRelease.KURigid,STRRelease.KURigid,STRRelease.KURigid,...
                STRRelease.KRFree,STRRelease.KRFree,STRRelease.KRFree,...
                STRRelease.KURigid,STRRelease.KURigid,STRRelease.KURigid,...
                STRRelease.KRFree,STRRelease.KRFree,STRRelease.KRFree);
            obj.STRReleases = [obj.STRReleases,release];
        end
        function ApplyRelease(~,line,release)
            line.Release = release;
        end
        function DeleteRelease(~,line)
            line.Release = [];
        end
        %% Material region
        function material = AddSTRMaterial(obj,name,e)
            obj.STRMaterialID = obj.STRMaterialID + 1;
            id = obj.STRMaterialID;
            material = STRMaterial(id,name,e);
            obj.STRMaterials = [obj.STRMaterials,material];
        end
        function ApplyMaterial(~,line,material)
            line.Material = material;
        end
        function DeleteMaterial(~,line)
            line.Material = [];
        end
        %% Section region
        function section = AddSTRSection(obj,name,ax,ix,iy,iz)
            obj.STRSectionID = obj.STRSectionID + 1;
            id = obj.STRSectionID;
            section = STRSection(id,name,ax,ix,iy,iz);
            obj.STRSections = [obj.STRSections,section];
        end
        function section = AddSTRSrctionRectangular(obj,name,width,height)
            ax = width * height;
            iy = 1/12 * width * height^3;
            iz = 1/12 * height * width^3;
            ix = iy + iz;
            obj.STRSectionID = obj.STRSectionID + 1;
            id = obj.STRSectionID;
            section = STRSection(id,name,ax,ix,iy,iz);
            obj.STRSections = [obj.STRSections,section];
        end
        function ApplySection(~,line,section)
            line.Section = section;
        end
        function DeleteSection(~,line)
            line.Section = [];
        end
        %% Support region
        function support = AddSTRSupport(obj, name, kux, kuy, kuz, krx, kry, krz)
            obj.STRSupportID = obj.STRSupportID + 1;
            id = obj.STRSupportID;
            support = STRSupport(id, name, kux, kuy, kuz, krx, kry, krz);
            obj.STRSupports = [obj.STRSupports,support];
        end
        function support = AddSTRSupportFixed(obj, name)
            support = obj.AddSTRSupport(name, ...
                        STRSupport.KURigid, STRSupport.KURigid, STRSupport.KURigid, ...
                        STRSupport.KRRigid, STRSupport.KRRigid, STRSupport.KRRigid);
        end
        function support = AddSTRSupportPinned(obj, name)
            support = obj.AddSTRSupport(name, ...
                STRSupport.KURigid, STRSupport.KURigid, STRSupport.KURigid, ...
                STRSupport.KRFree, STRSupport.KRFree, STRSupport.KRFree);
        end     
        function support = AddSTRSupportRoller(obj, name)
            support = obj.AddSTRSupport(name, ...
                STRSupport.KUFree, STRSupport.KUFree, STRSupport.KURigid, ...
                STRSupport.KRFree, STRSupport.KRFree, STRSupport.KRFree);
        end
        function ApplySupport(~,node,support)
            node.Support = support;
        end
        function DeleteSupport(~,node)
            node.Support = [];
        end
        %% Reporting region
        function ToString(obj)
            numNodes = length(obj.STRNodes);
            numLines = length(obj.STRLines);
            numSupports = length(obj.STRSupports);
            numSections = length(obj.STRSections);
            numMaterials = length(obj.STRMaterials);
            numReleases = length(obj.STRReleases);
            numLoadcases = length(obj.STRLoadcases);
            numNodalloads = length(obj.STRNodalLoads);
            numLineLoadConcentrateds = length(obj.STRLineLoadConcentrateds);
            numLineLoadDistributeds = length(obj.STRLineLoadDistributeds);
            fprintf('Model has %d nodes and %d lines\n', numNodes, numLines);
            fprintf('----------------------------------------------------\nNode:\n');
            
            for i = 1:numNodes
                targetNode = obj.STRNodes(i);
                targetNode.ToString();
            end
            fprintf('----------------------------------------------------\nLine:\n');
            for i = 1:numLines
                targetLine = obj.STRLines(i);
                targetLine.ToString();
                fprintf('\n');
            end
            fprintf('----------------------------------------------------\nSupport:\n');
            for i = 1:numSupports
                targetSupport = obj.STRSupports(i);
                targetSupport.ToString();
            end
            fprintf('----------------------------------------------------\nSection:\n');
            for i = 1:numSections
                targetSection = obj.STRSections(i);
                targetSection.ToString();
            end
            fprintf('----------------------------------------------------\nMaterial:\n');
            for i = 1:numMaterials
                targetMaterial = obj.STRMaterials(i);
                targetMaterial.ToString();
            end
            fprintf('----------------------------------------------------\nRelease:\n');
            for i = 1:numReleases
                targetRelease = obj.STRReleases(i);
                targetRelease.ToString();
            end
            fprintf('----------------------------------------------------\nLoad case:\n');
            for i = 1:numLoadcases
                targetLoadcase = obj.STRLoadcases(i);
                targetLoadcase.ToString();
            end
            fprintf('----------------------------------------------------\nNodal Load:\n');
            for i = 1:numNodalloads
                targetNodalLoad = obj.STRNodalLoads(i);
                targetNodalLoad.ToString();
                fprintf('\n');
            end
            fprintf('----------------------------------------------------\nLine Load Concentrated:\n');
            for i = 1:numLineLoadConcentrateds
                targetLoadConcentrated = obj.STRLineLoadConcentrateds(i);
                targetLoadConcentrated.ToString();
                fprintf('\n');
            end
            fprintf('----------------------------------------------------\nLine Load Distributed:\n');
            for i = 1:numLineLoadDistributeds
                targetLoadDistributed = obj.STRLineLoadDistributeds(i);
                targetLoadDistributed.ToString();
                fprintf('\n');
            end
        end
    end          
end
