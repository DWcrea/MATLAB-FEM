clc; clear;


controller = STRController();
%viewer = Viewer();
node1 = controller.AddSTRNode(0, 0, 0);
node2 = controller.AddSTRNode(0, 0, 5);
node3 = controller.AddSTRNode(10, 0, 5);
node4 = controller.AddSTRNode(10, 0, 0);


line1 = controller.AddSTRLine(node1,node2);
line2 = controller.AddSTRLine(node2,node3);
line3 = controller.AddSTRLine(node3,node4);

support1 = controller.AddSTRSupport('pinned',1e15,1e15,1e15,1e-4,1e-4,1e-4);
support2 = controller.AddSTRSupportFixed('Fixed');
support3 = controller.AddSTRSupportPinned('Pinned');
support4 = controller.AddSTRSupportRoller('Roller');

controller.ApplySupport(node1,support1)
setion1 = controller.AddSTRSection('hji',1,6,8,9);


controller.ToString();
%viewer.Render(controller);

