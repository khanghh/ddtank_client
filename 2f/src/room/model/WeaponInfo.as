package room.model
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.WeaponBallManager;
   
   public class WeaponInfo
   {
      
      public static var ROTATITON_SPEED:Number = 1;
       
      
      private var _info:ItemTemplateInfo;
      
      public var armMaxAngle:Number = 90;
      
      public var armMinAngle:Number = 50;
      
      public var commonBall:int;
      
      public var skillBall:int;
      
      public var skill:int = -1;
      
      public var actionType:int;
      
      public var specialSkillMovie:int;
      
      public var refineryLevel:int;
      
      public var bombs:Array;
      
      public function WeaponInfo(param1:ItemTemplateInfo){super();}
      
      public function get TemplateID() : int{return 0;}
      
      public function dispose() : void{}
   }
}
