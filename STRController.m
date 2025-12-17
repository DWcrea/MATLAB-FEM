classdef STRController < handle
    properties
        Epsilon = 1e-6;
        STRNodeID = 0;
        STRLineID = 0;
        STRSupportID = 0;
        STRSectionID = 0;
        STRNodes;
        STRLines;
        STRSupports;
        STRSections;
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
        %% Section region
        function section = AddSTRSection(obj,name,ax,ix,iy,iz)
            obj.STRSectionID = obj.STRSectionID + 1;
            id = obj.STRSectionID;
            section = STRSection(id,name,ax,ix,iy,iz);
            obj.STRSections = [obj.STRSections,section];
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
            fprintf('Model has %d nodes and %d lines\n', numNodes, numLines);
            fprintf('--------------------\nNode:\n');
            
            for i = 1:numNodes
                targetNode = obj.STRNodes(i);
                targetNode.ToString();
            end
            fprintf('--------------------\nLine:\n');
            for i = 1:numLines
                targetLine = obj.STRLines(i);
                targetLine.ToString();
            end
            fprintf('--------------------\nSupport:\n');
            for i = 1:numSupports
                targetSupport = obj.STRSupports(i);
                targetSupport.ToString();
            end
            fprintf('--------------------\nSection:\n');
            for i = 1:numSections
                targetSection = obj.STRSections(i);
                targetSection.ToString();
            end
        end
    end          
end
