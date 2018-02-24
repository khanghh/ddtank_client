package road7th.utils
{
   public class DateUtils
   {
      
      private static const _weekString:Array = ["一","二","三","四","五","六","日"];
       
      
      public function DateUtils()
      {
         super();
      }
      
      public static function getDateByStr(param1:String) : Date
      {
         var _loc6_:* = null;
         var _loc10_:* = null;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc9_:int = 0;
         var _loc3_:* = null;
         var _loc8_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(param1)
         {
            _loc6_ = param1.split(" ");
            _loc10_ = _loc6_[0].split("-");
            if(_loc10_.length == 1)
            {
               _loc10_ = _loc6_[0].split("/");
            }
            _loc7_ = _loc10_[0];
            _loc5_ = _loc10_[1] - 1;
            _loc9_ = _loc10_[2];
            if(_loc6_.length == 1)
            {
               _loc8_ = 0;
               _loc2_ = 0;
               _loc4_ = 1;
            }
            else
            {
               _loc3_ = _loc6_[1].split(":");
               _loc8_ = _loc3_[0];
               _loc2_ = _loc3_[1];
               _loc4_ = _loc3_[2];
            }
            return new Date(_loc7_,_loc5_,_loc9_,_loc8_,_loc2_,_loc4_);
         }
         return new Date(0);
      }
      
      public static function checkTime(param1:String, param2:String, param3:Date) : Boolean
      {
         if(param3.time > getDateByStr(param1).time && param3.time < getDateByStr(param2).time)
         {
            return true;
         }
         return false;
      }
      
      public static function getHourDifference(param1:Number, param2:Number) : int
      {
         return Math.floor((param2 - param1) / 3600000);
      }
      
      public static function getDays(param1:int, param2:int) : int
      {
         var _loc3_:Date = new Date(param1,param2);
         return _loc3_.getUTCDate();
      }
      
      public static function decodeDated(param1:String) : Date
      {
         var _loc3_:Array = param1.split("T");
         var _loc4_:Array = _loc3_[0].split("-");
         var _loc2_:Array = _loc3_[1].split(":");
         return new Date(_loc4_[0],_loc4_[1] - 1,_loc4_[2],_loc2_[0],_loc2_[1],_loc2_[2]);
      }
      
      public static function encodeDated(param1:Date) : String
      {
         var _loc3_:String = "";
         var _loc8_:String = param1.fullYear.toString();
         var _loc6_:String = param1.month + 1 < 10?"0" + param1.month + 1:(param1.month + 1).toString();
         var _loc7_:String = param1.date < 10?"0" + param1.date:param1.date.toString();
         var _loc5_:String = param1.hours < 10?"0" + param1.hours:param1.hours.toString();
         var _loc2_:String = param1.minutes < 10?"0" + param1.minutes:param1.minutes.toString();
         var _loc4_:String = param1.seconds < 10?"0" + param1.seconds:param1.seconds.toString();
         return _loc8_ + "-" + _loc6_ + "-" + _loc7_ + "T" + _loc5_ + ":" + _loc2_ + ":" + _loc4_;
      }
      
      public static function isToday(param1:Date) : Boolean
      {
         var _loc2_:Date = new Date();
         return param1.getDate() == _loc2_.getDate() && param1.getMonth() == _loc2_.getMonth() && param1.getFullYear() == _loc2_.getFullYear();
      }
      
      public static function dealWithStringDate(param1:String) : Date
      {
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         if(param1.indexOf("-") > 0)
         {
            _loc7_ = parseInt(param1.split(" ")[1].split(":")[0]);
            _loc2_ = parseInt(param1.split(" ")[1].split(":")[1]);
            _loc3_ = parseInt(param1.split(" ")[0].split("-")[2]);
            _loc5_ = parseInt(param1.split(" ")[0].split("-")[1]) - 1;
            _loc6_ = parseInt(param1.split(" ")[0].split("-")[0]);
         }
         if(param1.indexOf("/") > 0)
         {
            if(param1.indexOf("PM") > 0)
            {
               _loc7_ = parseInt(param1.split(" ")[1].split(":")[0]) + 12;
            }
            else
            {
               _loc7_ = parseInt(param1.split(" ")[1].split(":")[0]);
            }
            _loc2_ = parseInt(param1.split(" ")[1].split(":")[1]);
            _loc3_ = parseInt(param1.split(" ")[0].split("/")[1]);
            _loc5_ = parseInt(param1.split(" ")[0].split("/")[0]) - 1;
            _loc6_ = parseInt(param1.split(" ")[0].split("/")[2]);
         }
         var _loc4_:Date = new Date(_loc6_,_loc5_,_loc3_,_loc7_,_loc2_);
         return _loc4_;
      }
      
      public static function dateFormat(param1:Date) : String
      {
         var _loc3_:String = "";
         var _loc8_:String = param1.fullYear.toString();
         var _loc6_:String = param1.month + 1 < 10?"0" + (param1.month + 1):(param1.month + 1).toString();
         var _loc7_:String = param1.date < 10?"0" + param1.date:param1.date.toString();
         var _loc5_:String = param1.hours < 10?"0" + param1.hours:param1.hours.toString();
         var _loc2_:String = param1.minutes < 10?"0" + param1.minutes:param1.minutes.toString();
         var _loc4_:String = param1.seconds < 10?"0" + param1.seconds:param1.seconds.toString();
         return _loc8_ + "-" + _loc6_ + "-" + _loc7_ + " " + _loc5_ + ":" + _loc2_ + ":" + _loc4_;
      }
      
      public static function dateFormat2(param1:Date) : String
      {
         var _loc3_:String = "";
         var _loc8_:String = param1.fullYear.toString();
         var _loc6_:String = param1.month + 1 < 10?"0" + (param1.month + 1):(param1.month + 1).toString();
         var _loc7_:String = param1.date < 10?"0" + param1.date:param1.date.toString();
         var _loc5_:String = param1.hours < 10?"0" + param1.hours:param1.hours.toString();
         var _loc2_:String = param1.minutes < 10?"0" + param1.minutes:param1.minutes.toString();
         var _loc4_:String = param1.seconds < 10?"0" + param1.seconds:param1.seconds.toString();
         return _loc8_ + "/" + _loc6_ + "/" + _loc7_ + " " + _loc5_ + ":" + _loc2_ + ":" + _loc4_;
      }
      
      public static function dateFormat3(param1:Date) : String
      {
         var _loc2_:String = "";
         var _loc5_:String = param1.fullYear.toString();
         var _loc3_:String = param1.month + 1 < 10?"0" + (param1.month + 1):(param1.month + 1).toString();
         var _loc4_:String = param1.date < 10?"0" + param1.date:param1.date.toString();
         return _loc5_ + "/" + _loc3_ + "/" + _loc4_ + " 00:00:00";
      }
      
      public static function dateFormat4(param1:Date) : String
      {
         var _loc2_:String = "";
         var _loc5_:String = param1.fullYear.toString();
         var _loc3_:String = param1.month + 1 < 10?"0" + (param1.month + 1):(param1.month + 1).toString();
         var _loc4_:String = param1.date < 10?"0" + param1.date:param1.date.toString();
         return _loc5_ + "/" + _loc3_ + "/" + _loc4_ + " 23:59:59";
      }
      
      public static function dateFormat5(param1:Date) : String
      {
         var _loc3_:String = "";
         var _loc7_:String = param1.fullYear.toString();
         var _loc5_:String = param1.month + 1 < 10?"0" + (param1.month + 1):(param1.month + 1).toString();
         var _loc6_:String = param1.date < 10?"0" + param1.date:param1.date.toString();
         var _loc4_:String = param1.hours < 10?"0" + param1.hours:param1.hours.toString();
         var _loc2_:String = param1.minutes < 10?"0" + param1.minutes:param1.minutes.toString();
         return _loc7_ + "-" + _loc5_ + "-" + _loc6_ + " " + _loc4_ + ":" + _loc2_;
      }
      
      public static function dateFormat6(param1:Date) : String
      {
         var _loc4_:String = param1.fullYear.toString();
         var _loc2_:String = param1.month + 1 < 10?"0" + (param1.month + 1):(param1.month + 1).toString();
         var _loc3_:String = param1.date < 10?"0" + param1.date:param1.date.toString();
         return _loc4_ + "/" + _loc2_ + "/" + _loc3_;
      }
      
      public static function dateFormatString(param1:String, param2:Boolean) : String
      {
         var _loc3_:RegExp = /\//g;
         var _loc4_:String = param1.replace(_loc3_,".");
         if(!param2)
         {
            _loc4_ = _loc4_.split(" ")[0];
         }
         return _loc4_;
      }
      
      public static function dateTimeRemainArr(param1:Number) : Array
      {
         var _loc6_:int = param1 / 86400;
         var _loc5_:int = (param1 - _loc6_ * 86400) / 3600;
         var _loc3_:int = (param1 - _loc6_ * 86400 - _loc5_ * 3600) / 60;
         var _loc4_:int = (param1 - _loc6_ * 86400 - _loc5_ * 3600) % 60;
         var _loc2_:Array = [];
         _loc2_[0] = _loc6_ < 0?0:_loc6_;
         _loc2_[1] = _loc5_ < 0?0:_loc5_;
         _loc2_[2] = _loc3_ < 0?0:_loc3_;
         _loc2_[3] = _loc4_ < 0?0:_loc4_;
         return _loc2_;
      }
      
      public static function weekFormatString(param1:int) : String
      {
         if(param1 > 0 && param1 <= 7)
         {
            return _weekString[param1 - 1];
         }
         return "";
      }
      
      public static function shorTimeRemainArr(param1:int) : Array
      {
         var _loc5_:Array = [];
         var _loc4_:* = param1;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_loc4_ >= 60)
         {
            _loc2_ = _loc4_ / 60;
            _loc4_ = int(_loc4_ % 60);
            if(_loc2_ > 60)
            {
               _loc3_ = _loc2_ / 60;
               _loc2_ = _loc2_ % 60;
            }
         }
         _loc5_.push(_loc3_.toString());
         _loc5_.push(_loc2_ < 10?"0" + _loc2_:_loc2_.toString());
         _loc5_.push(_loc4_ < 10?"0" + _loc4_:_loc4_.toString());
         return _loc5_;
      }
   }
}
