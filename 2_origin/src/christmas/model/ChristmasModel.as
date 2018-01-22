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
      
      public function ChristmasModel()
      {
         super();
      }
      
      public function get activityTime() : String
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc3_:String = "";
         beginTime = ChristmasCoreManager.instance.model.beginTime;
         endTime = ChristmasCoreManager.instance.model.endTime;
         if(beginTime && endTime)
         {
            _loc2_ = beginTime.minutes > 9?beginTime.minutes + "":"0" + beginTime.minutes;
            _loc1_ = endTime.minutes > 9?endTime.minutes + "":"0" + endTime.minutes;
            _loc3_ = beginTime.fullYear + "." + (beginTime.month + 1) + "." + beginTime.date + " - " + endTime.fullYear + "." + (endTime.month + 1) + "." + endTime.date;
         }
         return _loc3_;
      }
      
      public function serverTime() : Array
      {
         var _loc1_:Date = TimeManager.Instance.Now();
         return [_loc1_.hours,_loc1_.minutes];
      }
   }
}
