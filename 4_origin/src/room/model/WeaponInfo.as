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
      
      public function WeaponInfo(param1:ItemTemplateInfo)
      {
         super();
         _info = param1;
         armMinAngle = Number(param1.Property5);
         armMaxAngle = Number(param1.Property6);
         commonBall = Number(param1.Property1);
         skillBall = Number(param1.Property2);
         actionType = Number(param1.Property3);
         skill = int(param1.Property4);
         bombs = WeaponBallManager.getWeaponBallInfo(param1.TemplateID);
         if(bombs && bombs[0])
         {
            commonBall = bombs[0];
         }
         refineryLevel = int(param1.RefineryLevel);
      }
      
      public function get TemplateID() : int
      {
         return _info.TemplateID;
      }
      
      public function dispose() : void
      {
         _info = null;
      }
   }
}
