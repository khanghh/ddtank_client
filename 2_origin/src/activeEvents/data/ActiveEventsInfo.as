package activeEvents.data
{
   import ddt.manager.LanguageMgr;
   import ddt.manager.TimeManager;
   import road7th.utils.DateUtils;
   
   public class ActiveEventsInfo
   {
      
      public static const COMMON:int = 0;
      
      public static const GOODS_EXCHANGE:int = 1;
      
      public static const PICC:int = 2;
      
      public static const SENIOR_PLAYER:int = 5;
      
      public static const SCAN_CODE:int = 6;
       
      
      public var ActiveID:int;
      
      public var Title:String;
      
      public var isAttend:Boolean = false;
      
      public var Description:String;
      
      private var _StartDate:String;
      
      public var IsShow:Boolean;
      
      public var viewId:int;
      
      private var _start:Date;
      
      private var _EndDate:String;
      
      private var _end:Date;
      
      public var Content:String;
      
      public var AwardContent:String;
      
      public var IsAdvance:Boolean;
      
      public var Type:int;
      
      public var IsOnly:int;
      
      public var HasKey:int;
      
      public var ActiveType:int;
      
      public var IconID:int = 1;
      
      public var GoodsExchangeTypes:String;
      
      public var limitType:String;
      
      public var limitValue:String;
      
      public var GoodsExchangeNum:String;
      
      public var ActionTimeContent:String;
      
      public function ActiveEventsInfo()
      {
         super();
      }
      
      public function get StartDate() : String
      {
         return _StartDate;
      }
      
      public function set StartDate(val:String) : void
      {
         _StartDate = val;
         _start = DateUtils.getDateByStr(_StartDate);
      }
      
      public function get start() : Date
      {
         return _start;
      }
      
      public function get EndDate() : String
      {
         return _EndDate;
      }
      
      public function set EndDate(val:String) : void
      {
         _EndDate = val;
         _end = DateUtils.getDateByStr(_EndDate);
      }
      
      public function get end() : Date
      {
         return _end;
      }
      
      public function activeTime() : String
      {
         var result:* = null;
         var begin:* = null;
         var end:* = null;
         if(ActionTimeContent)
         {
            result = ActionTimeContent;
         }
         else if(EndDate)
         {
            begin = DateUtils.getDateByStr(StartDate);
            end = DateUtils.getDateByStr(EndDate);
            result = getActiveString(begin) + "-" + getActiveString(end);
         }
         else
         {
            result = LanguageMgr.GetTranslation("tank.data.MovementInfo.begin",getActiveString(begin));
         }
         return result;
      }
      
      private function getActiveString(date:Date) : String
      {
         return LanguageMgr.GetTranslation("tank.data.MovementInfo.date",addZero(date.getFullYear()),addZero(date.getMonth() + 1),addZero(date.getDate()));
      }
      
      private function addZero(value:Number) : String
      {
         var result:* = null;
         if(value < 10)
         {
            result = "0" + value.toString();
         }
         else
         {
            result = value.toString();
         }
         return result;
      }
      
      public function overdue() : Boolean
      {
         var end:* = null;
         var now:Date = TimeManager.Instance.Now();
         var time:Number = now.time;
         var begin:Date = DateUtils.getDateByStr(StartDate);
         if(time < begin.getTime())
         {
            return true;
         }
         if(EndDate)
         {
            end = DateUtils.getDateByStr(EndDate);
            if(time > end.getTime())
            {
               return true;
            }
         }
         return false;
      }
   }
}
