package starling.display.sceneCharacter
{
   import flash.geom.Point;
   
   public class SceneCharacterActionType
   {
      
      public static const STAND_FRONT:String = "standFront";
      
      public static const STAND_BACK:String = "standBack";
      
      public static const WALK_FRONT:String = "walkFront";
      
      public static const WALK_BACK:String = "walkBack";
      
      public static const STAND_SIT:String = "standSit";
      
      public static const WALK_SIT:String = "walkSit";
      
      public static const STAND_RIDE:String = "standRide";
      
      public static const WALK_RIDE:String = "walkRide";
      
      public static const HEAD:String = "head";
      
      public static const BODY:String = "body";
      
      public static const BODY_BACK:String = "bodyBack";
      
      public static const MOUNT:String = "mount";
      
      public static const MOUNT_SADDLE:String = "mountSaddle";
      
      public static const ACTION_HEAD_STAND_FRONT:SceneCharacterActionItem = new SceneCharacterActionItem("standFront","head",[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1],true);
      
      public static const ACTION_BODY_STAND_FRONT:SceneCharacterActionItem = new SceneCharacterActionItem("standFront","body",[0],false);
      
      public static const ACTION_STAND_BACK_ACTION:SceneCharacterActionItem = new SceneCharacterActionItem("standBack","head",[2],false);
      
      public static const ACTION_BODY_STAND_BACK:SceneCharacterActionItem = new SceneCharacterActionItem("standBack","body",[7],false);
      
      public static const ACTION_HEAD_WALK_FRONT:SceneCharacterActionItem = getCopyActionItem(ACTION_HEAD_STAND_FRONT,"walkFront");
      
      public static const ACTION_BODY_WALK_FRONT:SceneCharacterActionItem = new SceneCharacterActionItem("walkFront","body",[1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6],true);
      
      public static const ACTION_HEAD_WALK_BACK:SceneCharacterActionItem = new SceneCharacterActionItem("walkBack","head",[2],true,18);
      
      public static const ACTION_BODY_WALK_BACK:SceneCharacterActionItem = new SceneCharacterActionItem("walkBack","body",[8,8,8,9,9,9,10,10,10,11,11,11,12,12,12,13,13,13],true);
      
      public static const ACTION_HEAD_SIT_STAND_1:SceneCharacterActionItem = getCopyActionItem(ACTION_HEAD_STAND_FRONT,"standSit");
      
      public static const ACTION_HEAD_SIT_STAND_2:SceneCharacterActionItem = new SceneCharacterActionItem("standSit","head",[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1],true);
      
      public static const ACTION_BODY_SIT_STAND_1:SceneCharacterActionItem = new SceneCharacterActionItem("standSit","body",[14],false);
      
      public static const ACTION_BODY_SIT_STAND_2:SceneCharacterActionItem = new SceneCharacterActionItem("standSit","body",[14],true,42);
      
      public static const ACTION_MOUNT_SIT_STAND_1:SceneCharacterActionItem = new SceneCharacterActionItem("standSit","mount",[0],false);
      
      public static const ACTION_MOUNT_SIT_STAND_2:SceneCharacterActionItem = new SceneCharacterActionItem("standSit","mount",[0,0,0,0,0,0,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,4,4,4,4,4,4,5,5,5,5,5,5,6,6,6,6,6,6],true);
      
      public static const ACTION_SADDLE_SIT_STAND_1:SceneCharacterActionItem = new SceneCharacterActionItem("standSit","mountSaddle",[7],false);
      
      public static const ACTION_SADDLE_SIT_STAND_2:SceneCharacterActionItem = new SceneCharacterActionItem("standSit","mountSaddle",[7],true,42);
      
      public static const ACTION_HEAD_SIT_WALK_1:SceneCharacterActionItem = getCopyActionItem(ACTION_HEAD_STAND_FRONT,"walkSit");
      
      public static const ACTION_HEAD_SIT_WALK_2:SceneCharacterActionItem = getCopyActionItem(ACTION_HEAD_STAND_FRONT,"walkSit",84);
      
      public static const ACTION_BODY_SIT_WALK_1:SceneCharacterActionItem = new SceneCharacterActionItem("walkSit","body",[14],true,18);
      
      public static const ACTION_BODY_SIT_WALK_2:SceneCharacterActionItem = new SceneCharacterActionItem("walkSit","body",[14],true,21);
      
      public static const ACTION_MOUNT_SIT_WALK_1:SceneCharacterActionItem = new SceneCharacterActionItem("walkSit","mount",[1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6],true);
      
      public static const ACTION_MOUNT_SIT_WALK_2:SceneCharacterActionItem = new SceneCharacterActionItem("walkSit","mount",[0,0,0,1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6],true);
      
      public static const ACTION_SADDLE_SIT_WALK_1:SceneCharacterActionItem = new SceneCharacterActionItem("walkSit","mountSaddle",[7],false);
      
      public static const ACTION_SADDLE_SIT_WALK_2:SceneCharacterActionItem = new SceneCharacterActionItem("walkSit","mountSaddle",[7],true,21);
      
      public static const ACTION_HEAD_RIDE_STAND_1:SceneCharacterActionItem = getCopyActionItem(ACTION_HEAD_STAND_FRONT,"standRide");
      
      public static const ACTION_HEAD_RIDE_STAND_2:SceneCharacterActionItem = getCopyActionItem(ACTION_HEAD_STAND_FRONT,"standRide",84);
      
      public static const ACTION_BODY_RIDE_STAND_FRONT_1:SceneCharacterActionItem = new SceneCharacterActionItem("standRide","body",[15],false);
      
      public static const ACTION_BODY_RIDE_STAND_FRONT_2:SceneCharacterActionItem = new SceneCharacterActionItem("standRide","body",[15],true,42);
      
      public static const ACTION_BODY_RIDE_STAND_BACK_1:SceneCharacterActionItem = new SceneCharacterActionItem("standRide","bodyBack",[16],false);
      
      public static const ACTION_BODY_RIDE_STAND_BACK_2:SceneCharacterActionItem = new SceneCharacterActionItem("standRide","bodyBack",[16],true,42);
      
      public static const ACTION_MOUNT_RIDE_STAND_1:SceneCharacterActionItem = new SceneCharacterActionItem("standRide","mount",[0],false);
      
      public static const ACTION_MOUNT_RIDE_STAND_2:SceneCharacterActionItem = new SceneCharacterActionItem("standRide","mount",[0,0,0,0,0,0,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,4,4,4,4,4,4,5,5,5,5,5,5,6,6,6,6,6,6],true);
      
      public static const ACTION_HEAD_RIDE_WALK_1:SceneCharacterActionItem = getCopyActionItem(ACTION_HEAD_STAND_FRONT,"walkRide");
      
      public static const ACTION_HEAD_RIDE_WALK_2:SceneCharacterActionItem = getCopyActionItem(ACTION_HEAD_SIT_STAND_2,"walkRide");
      
      public static const ACTION_BODY_RIDE_WALK_FRONT_1:SceneCharacterActionItem = new SceneCharacterActionItem("walkRide","body",[15],true,18);
      
      public static const ACTION_BODY_RIDE_WALK_FRONT_2:SceneCharacterActionItem = new SceneCharacterActionItem("walkRide","body",[15],true,42);
      
      public static const ACTION_BODY_RIDE_WALK_BACK_1:SceneCharacterActionItem = new SceneCharacterActionItem("walkRide","bodyBack",[16],true,18);
      
      public static const ACTION_BODY_RIDE_WALK_BACK_2:SceneCharacterActionItem = new SceneCharacterActionItem("walkRide","bodyBack",[16],true,42);
      
      public static const ACTION_MOUNT_RIDE_WALK_1:SceneCharacterActionItem = new SceneCharacterActionItem("walkRide","mount",[1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6],true);
      
      public static const ACTION_MOUNT_RIDE_WALK_2:SceneCharacterActionItem = new SceneCharacterActionItem("walkRide","mount",[0,0,0,1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6],true);
      
      public static const POINT_HEAD_WALK:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(0,-1),[3,4,5,12,13,14]),ActionPoint(new Point(0,2),[6,7,8,15,16,17])]);
      
      public static const POINT_MOUNT_1:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-208,-58),[0])]);
      
      public static const POINT_MOUNT_1_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(-6,-11),[0,1,2]),ActionPoint(new Point(-6,-3),[3,4,5]),ActionPoint(new Point(-10,-5),[6,7,8,12,13,14]),ActionPoint(new Point(-8,-5),[9,10,11]),ActionPoint(new Point(-9,-11),[15,16,17])]);
      
      public static const POINT_MOUNT_1_BODY:SceneCharacterActionPointItem = getCopyActionPointItem(POINT_MOUNT_1_HEAD,"body");
      
      public static const POINT_MOUNT_1_BODY_BACK:SceneCharacterActionPointItem = getCopyActionPointItem(POINT_MOUNT_1_HEAD,"bodyBack");
      
      public static const POINT_MOUNT_2:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-206,-58),[0])]);
      
      public static const POINT_MOUNT_2_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(-1,1),[0,1,2]),ActionPoint(new Point(0,0),[3,4,5]),ActionPoint(new Point(-3,1),[6,7,8]),ActionPoint(new Point(-4,3),[9,10,11]),ActionPoint(new Point(-4,4),[12,13,14]),ActionPoint(new Point(-1,4),[15,16,17])]);
      
      public static const POINT_MOUNT_3:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-204,-62),[0])]);
      
      public static const POINT_MOUNT_3_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(0,5),[0,1,2]),ActionPoint(new Point(-8,0),[3,4,5]),ActionPoint(new Point(-8,-2),[6,7,8]),ActionPoint(new Point(-11,-1),[9,10,11]),ActionPoint(new Point(-7,0),[12,13,14]),ActionPoint(new Point(-2,-5),[15,16,17])]);
      
      public static const POINT_MOUNT_4:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-208,-59),[0])]);
      
      public static const POINT_MOUNT_4_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",21,[ActionPoint(new Point(0,-1),[0,1,2]),ActionPoint(new Point(-1,-2),[3,4,5]),ActionPoint(new Point(-1,-3),[6,7,8]),ActionPoint(new Point(-2,-4),[9,10,11]),ActionPoint(new Point(-3,-4),[12,13,14]),ActionPoint(new Point(-4,-4),[15,16,17]),ActionPoint(new Point(-3,-3),[18,19,20])]);
      
      public static const POINT_MOUNT_4_HEAD_STAND:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",42,[ActionPoint(new Point(0,-1),[0,1,2,3,4,5]),ActionPoint(new Point(-1,-2),[6,7,8,9,10,11]),ActionPoint(new Point(-1,-3),[12,13,14,15,16,17]),ActionPoint(new Point(-2,-4),[18,19,20,21,22,23]),ActionPoint(new Point(-3,-4),[24,25,26,27,28,29]),ActionPoint(new Point(-4,-4),[30,31,32,33,34,35]),ActionPoint(new Point(-3,-3),[36,37,38,39,40,41])]);
      
      public static const POINT_MOUNT_5:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-211,-54),[0])]);
      
      public static const POINT_MOUNT_5_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",21,[ActionPoint(new Point(0,0),[0,1,2]),ActionPoint(new Point(-1,0),[3,4,5,6,7,8]),ActionPoint(new Point(-2,1),[9,10,11]),ActionPoint(new Point(-3,1),[12,13,14]),ActionPoint(new Point(-4,0),[15,16,17]),ActionPoint(new Point(-2,0),[18,19,20])]);
      
      public static const POINT_MOUNT_5_HEAD_STAND:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",42,[ActionPoint(new Point(0,0),[0,1,2,3,4,5]),ActionPoint(new Point(-1,0),[6,7,8,9,10,11,12,13,14,15,16,17]),ActionPoint(new Point(-2,1),[18,19,20,21,22,23]),ActionPoint(new Point(-3,1),[24,25,26,27,28,29]),ActionPoint(new Point(-4,0),[30,31,32,33,34,35]),ActionPoint(new Point(-2,0),[36,37,38,39,40,41])]);
      
      public static const POINT_MOUNT_6:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-200,-52),[0])]);
      
      public static const POINT_MOUNT_6_SADDLE:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mountSaddle",1,[ActionPoint(new Point(12,85),[0])]);
      
      public static const POINT_MOUNT_7:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-218,-56),[0])]);
      
      public static const POINT_MOUNT_7_SADDLE:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mountSaddle",1,[ActionPoint(new Point(15,83),[0])]);
      
      public static const POINT_MOUNT_8:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-220,-55),[0])]);
      
      public static const POINT_MOUNT_8_SADDLE:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mountSaddle",1,[ActionPoint(new Point(15,83),[0])]);
      
      public static const POINT_MOUNT_9:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-209,-59),[0])]);
      
      public static const POINT_MOUNT_9_SADDLE:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mountSaddle",21,[ActionPoint(new Point(16,87),[0,1,2,3,4,5,6,7,8,9,10,11]),ActionPoint(new Point(14,87),[12,13,14,15,16,17]),ActionPoint(new Point(15,86),[18,19,20])]);
      
      public static const POINT_MOUNT_9_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",21,[ActionPoint(new Point(-1,0),[9,10,11]),ActionPoint(new Point(-2,0),[12,13,14,15,16,17]),ActionPoint(new Point(-1,-1),[18,19,20])]);
      
      public static const POINT_MOUNT_9_SADDLE_STAND:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mountSaddle",42,[ActionPoint(new Point(16,87),[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17]),ActionPoint(new Point(15,87),[18,19,20,21,22,23]),ActionPoint(new Point(14,87),[24,25,26,27,28,29,30,31,32,33,34,35]),ActionPoint(new Point(15,86),[36,37,38,39,40,41])]);
      
      public static const POINT_MOUNT_9_HEAD_STAND:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",42,[ActionPoint(new Point(-1,0),[18,19,20,21,22,23]),ActionPoint(new Point(-2,0),[24,25,26,27,28,29,30,31,32,33,34,35]),ActionPoint(new Point(-1,-1),[36,37,38,39,40,41])]);
      
      public static const POINT_MOUNT_101:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-207,-55),[0])]);
      
      public static const POINT_MOUNT_101_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(1,3),[0,1,2,6,7,8]),ActionPoint(new Point(1,2),[3,4,5,15,16,17]),ActionPoint(new Point(0,3),[9,10,11]),ActionPoint(new Point(0,2),[12,13,14])]);
      
      public static const POINT_MOUNT_102:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-207,-59),[0])]);
      
      public static const POINT_MOUNT_102_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(1,0),[0,1,2,6,7,8]),ActionPoint(new Point(1,-1),[3,4,5,15,16,17]),ActionPoint(new Point(0,-1),[12,13,14])]);
      
      public static const POINT_MOUNT_103:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-208,-56),[0])]);
      
      public static const POINT_MOUNT_103_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",21,[ActionPoint(new Point(0,1),[6,7,8]),ActionPoint(new Point(-1,0),[12,13,14]),ActionPoint(new Point(-1,-1),[15,16,17]),ActionPoint(new Point(0,-2),[18,19,20])]);
      
      public static const POINT_MOUNT_103_HEAD_STAND:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",42,[ActionPoint(new Point(0,1),[12,13,14,15,16,17]),ActionPoint(new Point(-1,0),[24,25,26,27,28,29]),ActionPoint(new Point(-1,-1),[30,31,32,33,34,35]),ActionPoint(new Point(0,-2),[36,37,38,39,40,41])]);
      
      public static const POINT_MOUNT_104:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-210,-56),[0])]);
      
      public static const POINT_MOUNT_104_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(-3,0),[0,1,2]),ActionPoint(new Point(-4,6),[3,4,5]),ActionPoint(new Point(-4,3),[6,7,8]),ActionPoint(new Point(-3,1),[9,10,11]),ActionPoint(new Point(2,2),[12,13,14]),ActionPoint(new Point(1,0),[15,16,17])]);
      
      public static const POINT_MOUNT_105:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-205,-60),[0])]);
      
      public static const POINT_MOUNT_105_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(-7,-14),[0,1,2]),ActionPoint(new Point(-6,-12),[3,4,5]),ActionPoint(new Point(-2,-6),[6,7,8]),ActionPoint(new Point(-8,-10),[9,10,11]),ActionPoint(new Point(-9,-12),[12,13,14]),ActionPoint(new Point(-4,-12),[15,16,17])]);
      
      public static const POINT_MOUNT_106:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-207,-65),[0])]);
      
      public static const POINT_MOUNT_106_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(-5,3),[0,1,2,12,13,14]),ActionPoint(new Point(-5,1),[3,4,5,15,16,17]),ActionPoint(new Point(-5,2),[6,7,8]),ActionPoint(new Point(-8,0),[9,10,11])]);
      
      public static const POINT_MOUNT_107:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-205,-56),[0])]);
      
      public static const POINT_MOUNT_107_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(-7,-9),[0,1,2]),ActionPoint(new Point(-3,-8),[3,4,5]),ActionPoint(new Point(-4,-1),[6,7,8]),ActionPoint(new Point(-10,-3),[9,10,11]),ActionPoint(new Point(-9,-5),[12,13,14]),ActionPoint(new Point(-9,-6),[15,16,17])]);
      
      public static const POINT_MOUNT_108:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-205,-60),[0])]);
      
      public static const POINT_MOUNT_108_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(2,-2),[0,1,2]),ActionPoint(new Point(4,-4),[3,4,5]),ActionPoint(new Point(1,1),[6,7,8]),ActionPoint(new Point(-3,0),[9,10,11]),ActionPoint(new Point(-4,1),[12,13,14]),ActionPoint(new Point(-3,0),[15,16,17])]);
      
      public static const POINT_MOUNT_109:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-207,-59),[0])]);
      
      public static const POINT_MOUNT_109_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(3,0),[0,1,2]),ActionPoint(new Point(-1,-7),[3,4,5]),ActionPoint(new Point(-3,-9),[6,7,8]),ActionPoint(new Point(-1,-6),[9,10,11]),ActionPoint(new Point(1,-6),[12,13,14]),ActionPoint(new Point(-1,-4),[15,16,17])]);
      
      public static const POINT_MOUNT_110:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-200,-55),[0])]);
      
      public static const POINT_MOUNT_110_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(0,2),[0,1,2]),ActionPoint(new Point(2,5),[3,4,5]),ActionPoint(new Point(1,2),[6,7,8]),ActionPoint(new Point(1,-4),[9,10,11]),ActionPoint(new Point(0,1),[12,13,14]),ActionPoint(new Point(-4,-3),[15,16,17])]);
      
      public static const POINT_MOUNT_111:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-205,-59),[0])]);
      
      public static const POINT_MOUNT_111_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(-6,-4),[0,1,2]),ActionPoint(new Point(-5,-2),[3,4,5]),ActionPoint(new Point(-6,0),[6,7,8]),ActionPoint(new Point(-8,-4),[9,10,11]),ActionPoint(new Point(-7,-2),[12,13,14]),ActionPoint(new Point(-3,-1),[15,16,17])]);
      
      public static const POINT_MOUNT_112:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-215,-53),[0])]);
      
      public static const POINT_MOUNT_112_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(2,-2),[0,1,2]),ActionPoint(new Point(1,0),[3,4,5]),ActionPoint(new Point(2,-2),[6,7,8,9,10,11]),ActionPoint(new Point(2,-1),[12,13,14]),ActionPoint(new Point(3,-2),[15,16,17])]);
      
      public static const POINT_MOUNT_113:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-211,-54),[0])]);
      
      public static const POINT_MOUNT_113_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(-1,0),[0,1,2,12,13,14,15,16,17]),ActionPoint(new Point(0,-1),[6,7,8])]);
      
      public static const POINT_MOUNT_114:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-212,-56),[0])]);
      
      public static const POINT_MOUNT_114_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(0,2),[0,1,2,6,7,8,12,13,14]),ActionPoint(new Point(0,3),[3,4,5,9,10,11,15,16,17])]);
      
      public static const POINT_MOUNT_115:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-210,-56),[0])]);
      
      public static const POINT_MOUNT_115_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(1,1),[0,1,2]),ActionPoint(new Point(0,2),[3,4,5,9,10,11]),ActionPoint(new Point(1,2),[6,7,8]),ActionPoint(new Point(0,3),[12,13,14]),ActionPoint(new Point(1,3),[15,16,17])]);
      
      public static const POINT_MOUNT_116:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-208,-56),[0])]);
      
      public static const POINT_MOUNT_116_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(0,-1),[0,1,2,6,7,8]),ActionPoint(new Point(-1,-1),[9,10,11]),ActionPoint(new Point(-2,-3),[12,13,14]),ActionPoint(new Point(-1,-4),[15,16,17])]);
      
      public static const POINT_MOUNT_117:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-211,-57),[0])]);
      
      public static const POINT_MOUNT_117_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(0,-5),[0,1,2]),ActionPoint(new Point(0,-1),[3,4,5]),ActionPoint(new Point(0,-4),[6,7,8]),ActionPoint(new Point(-1,-5),[9,10,11]),ActionPoint(new Point(-1,-8),[12,13,14]),ActionPoint(new Point(0,-8),[15,16,17])]);
      
      public static const POINT_MOUNT_118:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-221,-56),[0])]);
      
      public static const POINT_MOUNT_118_SADDLE:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mountSaddle",1,[ActionPoint(new Point(14,87),[0])]);
      
      public static const POINT_MOUNT_119:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-208,-66),[0])]);
      
      public static const POINT_MOUNT_119_SADDLE:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mountSaddle",1,[ActionPoint(new Point(14,82),[0])]);
      
      public static const POINT_MOUNT_120:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-212,-59),[0])]);
      
      public static const POINT_MOUNT_120_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(1,-1),[0,1,2]),ActionPoint(new Point(1,0),[3,4,5]),ActionPoint(new Point(0,-1),[6,7,8,12,13,14]),ActionPoint(new Point(-1,-1),[9,10,11]),ActionPoint(new Point(0,-2),[15,16,17])]);
      
      public static const POINT_MOUNT_121:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-205,-59),[0])]);
      
      public static const POINT_MOUNT_121_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(0,1),[0,1,2]),ActionPoint(new Point(-1,0),[6,7,8]),ActionPoint(new Point(-1,-1),[9,10,11]),ActionPoint(new Point(0,-1),[15,16,17])]);
      
      public static const POINT_MOUNT_122:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-207,-57),[0])]);
      
      public static const POINT_MOUNT_122_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(-1,-1),[6,7,8,12,13,14]),ActionPoint(new Point(-2,-2),[9,10,11]),ActionPoint(new Point(-1,0),[15,16,17])]);
      
      public static const POINT_MOUNT_123:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-207,-58),[0])]);
      
      public static const POINT_MOUNT_123_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(-8,-5),[0,1,2]),ActionPoint(new Point(-10,1),[3,4,5]),ActionPoint(new Point(-13,-3),[6,7,8]),ActionPoint(new Point(-16,-6),[9,10,11]),ActionPoint(new Point(-22,-7),[12,13,14]),ActionPoint(new Point(-13,-3),[15,16,17])]);
      
      public static const POINT_MOUNT_124:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-212,-57),[0])]);
      
      public static const POINT_MOUNT_124_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(-2,-4),[0,1,2]),ActionPoint(new Point(-1,0),[3,4,5,9,10,11]),ActionPoint(new Point(-2,-1),[6,7,8]),ActionPoint(new Point(0,2),[12,13,14]),ActionPoint(new Point(-2,1),[15,16,17])]);
      
      public static const POINT_MOUNT_125:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-209,-56),[0])]);
      
      public static const POINT_MOUNT_125_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(-6,-10),[0,1,2]),ActionPoint(new Point(-9,-16),[3,4,5]),ActionPoint(new Point(-12,-14),[6,7,8]),ActionPoint(new Point(-11,-12),[9,10,11]),ActionPoint(new Point(-11,-13),[12,13,14]),ActionPoint(new Point(-12,-9),[15,16,17])]);
      
      public static const POINT_MOUNT_126:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-208,-58),[0])]);
      
      public static const POINT_MOUNT_126_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(1,0),[0,1,2]),ActionPoint(new Point(-2,-5),[3,4,5]),ActionPoint(new Point(-3,-8),[6,7,8]),ActionPoint(new Point(-2,-3),[9,10,11]),ActionPoint(new Point(0,-3),[12,13,14]),ActionPoint(new Point(-1,-1),[15,16,17])]);
      
      public static const POINT_MOUNT_127:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-209,-58),[0])]);
      
      public static const POINT_MOUNT_127_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(1,-1),[0,1,2]),ActionPoint(new Point(-3,-6),[3,4,5,9,10,11]),ActionPoint(new Point(-5,-11),[6,7,8]),ActionPoint(new Point(0,-6),[12,13,14]),ActionPoint(new Point(-2,-3),[15,16,17])]);
      
      public static const POINT_MOUNT_128:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-203,-59),[0])]);
      
      public static const POINT_MOUNT_128_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(-4,-4),[0,1,2]),ActionPoint(new Point(-3,-2),[3,4,5]),ActionPoint(new Point(-3,0),[6,7,8]),ActionPoint(new Point(-4,-4),[9,10,11]),ActionPoint(new Point(-4,-2),[12,13,14]),ActionPoint(new Point(-2,0),[15,16,17])]);
      
      public static const POINT_MOUNT_129:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-202,-59),[0])]);
      
      public static const POINT_MOUNT_129_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(-4,-5),[0,1,2,12,13,14]),ActionPoint(new Point(-3,-3),[3,4,5]),ActionPoint(new Point(-2,-1),[6,7,8]),ActionPoint(new Point(-3,-5),[9,10,11]),ActionPoint(new Point(-3,-2),[15,16,17])]);
      
      public static const POINT_MOUNT_130:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-219,-53),[0])]);
      
      public static const POINT_MOUNT_130_SADDLE:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mountSaddle",1,[ActionPoint(new Point(16,83),[0])]);
      
      public static const POINT_MOUNT_131:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-215,-58),[0])]);
      
      public static const POINT_MOUNT_131_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(1,0),[0,1,2]),ActionPoint(new Point(0,2),[3,4,5]),ActionPoint(new Point(1,1),[6,7,8,12,13,14]),ActionPoint(new Point(1,-2),[9,10,11]),ActionPoint(new Point(1,-1),[15,16,17])]);
      
      public static const POINT_MOUNT_132:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-211,-57),[0])]);
      
      public static const POINT_MOUNT_132_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(0,-5),[0,1,2]),ActionPoint(new Point(-2,-5),[3,4,5]),ActionPoint(new Point(-5,-11),[6,7,8]),ActionPoint(new Point(-12,-13),[9,10,11]),ActionPoint(new Point(-9,-11),[12,13,14]),ActionPoint(new Point(-1,-5),[15,16,17])]);
      
      public static const POINT_MOUNT_133:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-206,-57),[0])]);
      
      public static const POINT_MOUNT_133_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(0,-1),[0,1,2]),ActionPoint(new Point(-1,-1),[3,4,5,9,10,11]),ActionPoint(new Point(-1,0),[6,7,8,12,13,14])]);
      
      public static const POINT_MOUNT_134:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-217,-59),[0])]);
      
      public static const POINT_MOUNT_134_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(1,-6),[0,1,2,6,7,8,9,10,11]),ActionPoint(new Point(2,-7),[3,4,5]),ActionPoint(new Point(1,-10),[12,13,14]),ActionPoint(new Point(1,-11),[15,16,17])]);
      
      public static const POINT_MOUNT_135:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-210,-62),[0])]);
      
      public static const POINT_MOUNT_135_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(1,0),[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17])]);
      
      public static const POINT_MOUNT_136:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-212,-61),[0])]);
      
      public static const POINT_MOUNT_136_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(0,1),[0,1,2]),ActionPoint(new Point(1,1),[3,4,5]),ActionPoint(new Point(0,-1),[6,7,8]),ActionPoint(new Point(1,0),[9,10,11,15,16,17]),ActionPoint(new Point(1,-1),[12,13,14])]);
      
      public static const POINT_MOUNT_222:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-207,-57),[0])]);
      
      public static const POINT_MOUNT_222_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(-1,-1),[6,7,8,12,13,14]),ActionPoint(new Point(-2,-2),[9,10,11]),ActionPoint(new Point(-1,0),[15,16,17])]);
      
      public static const POINT_MOUNT_223:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-207,-58),[0])]);
      
      public static const POINT_MOUNT_223_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",18,[ActionPoint(new Point(-8,-5),[0,1,2]),ActionPoint(new Point(-10,1),[3,4,5]),ActionPoint(new Point(-13,-3),[6,7,8]),ActionPoint(new Point(-16,-6),[9,10,11]),ActionPoint(new Point(-22,-7),[12,13,14]),ActionPoint(new Point(-13,-3),[15,16,17])]);
      
      public static const POINT_MOUNT_137:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-205,-67),[0])]);
      
      public static const POINT_MOUNT_137_HEAD:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",21,[ActionPoint(new Point(1,1),[3,4,5]),ActionPoint(new Point(-3,-3),[6,7,8]),ActionPoint(new Point(-3,-5),[9,10,11]),ActionPoint(new Point(-3,-2),[12,13,14]),ActionPoint(new Point(-3,1),[15,16,17]),ActionPoint(new Point(1,6),[18,19,20])]);
      
      public static const POINT_MOUNT_137_SADDLE:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mountSaddle",21,[ActionPoint(new Point(20,79),[0,1,2]),ActionPoint(new Point(21,80),[3,4,5]),ActionPoint(new Point(17,76),[6,7,8]),ActionPoint(new Point(17,74),[9,10,11]),ActionPoint(new Point(17,77),[12,13,14]),ActionPoint(new Point(17,80),[15,16,17]),ActionPoint(new Point(21,86),[18,19,20])]);
      
      public static const POINT_MOUNT_137_HEAD_STAND:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("head",42,[ActionPoint(new Point(1,1),[6,7,8,9,10,11]),ActionPoint(new Point(-3,-3),[12,13,14,15,16,17]),ActionPoint(new Point(-3,-5),[18,19,20,21,22,23]),ActionPoint(new Point(-3,-2),[24,25,26,27,28,29]),ActionPoint(new Point(-3,1),[30,31,32,33,34,35]),ActionPoint(new Point(1,6),[36,37,38,39,40,41])]);
      
      public static const POINT_MOUNT_137_SADDLE_STAND:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mountSaddle",42,[ActionPoint(new Point(20,79),[0,1,2,3,4,5]),ActionPoint(new Point(21,80),[6,7,8,9,10,11]),ActionPoint(new Point(17,76),[12,13,14,15,16,17]),ActionPoint(new Point(17,74),[18,19,20,21,22,23]),ActionPoint(new Point(17,77),[24,25,26,27,28,29]),ActionPoint(new Point(17,80),[30,31,32,33,34,35]),ActionPoint(new Point(21,86),[36,37,38,39,40,41])]);
      
      public static const POINT_MOUNT_140:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-212,-56),[0])]);
      
      public static const POINT_MOUNT_141:SceneCharacterActionPointItem = new SceneCharacterActionPointItem("mount",1,[ActionPoint(new Point(-204,-58),[0])]);
       
      
      public function SceneCharacterActionType()
      {
         super();
      }
      
      public static function getCopyActionItem(param1:SceneCharacterActionItem, param2:String = "", param3:int = 0, param4:Boolean = false) : SceneCharacterActionItem
      {
         var _loc7_:String = param2 == ""?param1.state:param2;
         var _loc6_:Array = !!param4?param1.frames.concat():param1.frames;
         var _loc5_:int = param3 == 0?param1.total:int(param3);
         return new SceneCharacterActionItem(_loc7_,param1.type,_loc6_,param1.repeat,_loc5_);
      }
      
      public static function getCopyActionPointItem(param1:SceneCharacterActionPointItem, param2:String = "", param3:Boolean = false) : SceneCharacterActionPointItem
      {
         var _loc5_:String = param2 == ""?param1.type:param2;
         var _loc4_:Array = !!param3?param1.points.concat():param1.points;
         return new SceneCharacterActionPointItem(_loc5_,param1.amount,_loc4_);
      }
      
      public static function ActionPoint(param1:Point, param2:Array) : SceneCharacterActionPoint
      {
         return new SceneCharacterActionPoint(param1,param2);
      }
   }
}
