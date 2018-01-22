package escort.data
{
   public class EscortPlayerInfo
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
      
      public var posX:int = 0;
      
      public var fightState:int;
      
      public function EscortPlayerInfo()
      {
         acceleEndTime = new Date(2000);
         deceleEndTime = new Date(2000);
         invisiEndTime = new Date(2000);
         super();
      }
   }
}
