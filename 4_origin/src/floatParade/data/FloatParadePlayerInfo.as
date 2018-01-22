package floatParade.data
{
   public class FloatParadePlayerInfo
   {
       
      
      public var zoneId:int;
      
      public var id:int;
      
      public var index:int;
      
      public var carType:int;
      
      public var name:String;
      
      public var level:int;
      
      public var vipType:int;
      
      public var vipLevel:int;
      
      public var isSelf:Boolean;
      
      public var acceleEndTime:Date;
      
      public var deceleEndTime:Date;
      
      public var invisiEndTime:Date;
      
      public var missileHitEndTime:Date;
      
      public var missileEndTime:Date;
      
      public var missileLaunchEndTime:Date;
      
      public var posX:int = 0;
      
      public var fightState:int;
      
      public function FloatParadePlayerInfo()
      {
         acceleEndTime = new Date(2000);
         deceleEndTime = new Date(2000);
         invisiEndTime = new Date(2000);
         missileHitEndTime = new Date(2000);
         missileEndTime = new Date(2000);
         missileLaunchEndTime = new Date(2000);
         super();
      }
   }
}
