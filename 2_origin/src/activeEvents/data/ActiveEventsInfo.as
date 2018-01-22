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
      
      public function set StartDate(param1:String) : void
      {
         _StartDate = param1;
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
      
      public function set EndDate(param1:String) : void
      {
         _EndDate = param1;
         _end = DateUtils.getDateByStr(_EndDate);
      }
      
      public function get end() : Date
      {
         return _end;
      }
      
      public function activeTime() : String
      {
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(ActionTimeContent)
         {
            _loc1_ = ActionTimeContent;
         }
         else if(EndDate)
         {
            _loc3_ = DateUtils.getDateByStr(StartDate);
            _loc2_ = DateUtils.getDateByStr(EndDate);
            _loc1_ = getActiveString(_loc3_) + "-" + getActiveString(_loc2_);
         }
         else
         {
            _loc1_ = LanguageMgr.GetTranslation("tank.data.MovementInfo.begin",getActiveString(_loc3_));
         }
         return _loc1_;
      }
      
      private function getActiveString(param1:Date) : String
      {
         return LanguageMgr.GetTranslation("tank.data.MovementInfo.date",addZero(param1.getFullYear()),addZero(param1.getMonth() + 1),addZero(param1.getDate()));
      }
      
      private function addZero(param1:Number) : String
      {
         var _loc2_:* = null;
         if(param1 < 10)
         {
            _loc2_ = "0" + param1.toString();
         }
         else
         {
            _loc2_ = param1.toString();
         }
         return _loc2_;
      }
      
      public function overdue() : Boolean
      {
         var _loc3_:* = null;
         var _loc2_:Date = TimeManager.Instance.Now();
         var _loc1_:Number = _loc2_.time;
         var _loc4_:Date = DateUtils.getDateByStr(StartDate);
         if(_loc1_ < _loc4_.getTime())
         {
            return true;
         }
         if(EndDate)
         {
            _loc3_ = DateUtils.getDateByStr(EndDate);
            if(_loc1_ > _loc3_.getTime())
            {
               return true;
            }
         }
         return false;
      }
   }
}
