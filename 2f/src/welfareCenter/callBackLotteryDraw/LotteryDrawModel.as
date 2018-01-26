package welfareCenter.callBackLotteryDraw
{
   public class LotteryDrawModel
   {
       
      
      public var isOpen:Boolean;
      
      public var startTime:Date;
      
      public var endTime:Date;
      
      public var lastRefreshTime:Date;
      
      public var phase:int;
      
      public var phaseEndTimeArr:Array;
      
      public var awardArr:Array;
      
      public var currPhaseHasGetCount:int;
      
      public function LotteryDrawModel(){super();}
   }
}
