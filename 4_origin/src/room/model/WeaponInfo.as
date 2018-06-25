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
      
      public function WeaponInfo(info:ItemTemplateInfo)
      {
         super();
         _info = info;
         armMinAngle = Number(info.Property5);
         armMaxAngle = Number(info.Property6);
         commonBall = Number(info.Property1);
         skillBall = Number(info.Property2);
         actionType = Number(info.Property3);
         skill = int(info.Property4);
         bombs = WeaponBallManager.getWeaponBallInfo(info.TemplateID);
         if(bombs && bombs[0])
         {
            commonBall = bombs[0];
         }
         refineryLevel = int(info.RefineryLevel);
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
