package christmas.model
{
   import christmas.ChristmasCoreManager;
   import christmas.info.ChristmasSystemItemsInfo;
   import ddt.manager.TimeManager;
   import flash.events.EventDispatcher;
   
   public class ChristmasModel extends EventDispatcher
   {
       
      
      public var isOpen:Boolean;
      
      public var isEnter:Boolean;
      
      public var beginTime:Date;
      
      public var endTime:Date;
      
      public var gameBeginTime:Date;
      
      public var gameEndTime:Date;
      
      public var count:int;
      
      public var exp:int = 0;
      
      public var totalExp:int = 10;
      
      public var awardState:int;
      
      public var packsNumber:int;
      
      public var packsLen:int;
      
      public var myGiftData:Vector.<ChristmasSystemItemsInfo>;
      
      public var isSelect:Boolean;
      
      public var snowPackNum:Array;
      
      public var lastPacks:int;
      
      public var money:int;
      
      public var snowPackNumber:int;
      
      public var maxSnowMenNumber:int = 2000;
      
      public var todayCount:int;
      
      public function ChristmasModel(){super();}
      
      public function get activityTime() : String{return null;}
      
      public function serverTime() : Array{return null;}
   }
}
