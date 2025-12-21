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

material1 = controller.AddSTRMaterial('Steel',210);
material2 = controller.AddSTRMaterial('concrete',21);

release1 = controller.AddSTRRelease("Pinned",1e15,1e15,1e15,1e15,1e15,1e15,1e15,1e15,1e15,1e15,1e15,1e15);
release2 = controller.AddSTRReleasePinnedRigid("Pin-Rigid");
release3 = controller.AddSTRReleaseRigidPinned("Rigid-Pin");
release4 = controller.AddSTRReleasePinnedPinned("Pin-Pin");

controller.ApplyRelease(line1,release4);
controller.ApplyRelease(line2,release3);
controller.ApplyRelease(line3,release2);
controller.DeleteRelease(line1);

controller.ApplySupport(node1,support1)
section1 = controller.AddSTRSrctionRectangular('300*500',0.3,0.5);
controller.ApplySection(line1,section1);
controller.ApplyMaterial(line1,material1);
controller.ApplyMaterial(line2,material2);

controller.ToString();
%viewer.Render(controller);

