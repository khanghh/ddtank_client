package road7th.utils
{
   public class DateUtils
   {
      
      private static const _weekString:Array = ["一","二","三","四","五","六","日"];
       
      
      public function DateUtils()
      {
         super();
      }
      
      public static function getDateByStr(value:String) : Date
      {
         var temp:* = null;
         var date:* = null;
         var year:int = 0;
         var month:int = 0;
         var day:int = 0;
         var time:* = null;
         var hour:int = 0;
         var minute:int = 0;
         var second:int = 0;
         if(value)
         {
            temp = value.split(" ");
            date = temp[0].split("-");
            if(date.length == 1)
            {
               date = temp[0].split("/");
            }
            year = date[0];
            month = date[1] - 1;
            day = date[2];
            if(temp.length == 1)
            {
               hour = 0;
               minute = 0;
               second = 1;
            }
            else
            {
               time = temp[1].split(":");
               hour = time[0];
               minute = time[1];
               second = time[2];
            }
            return new Date(year,month,day,hour,minute,second);
         }
         return new Date(0);
      }
      
      public static function checkTime(beginTime:String, endTime:String, serverTime:Date) : Boolean
      {
         if(serverTime.time > getDateByStr(beginTime).time && serverTime.time < getDateByStr(endTime).time)
         {
            return true;
         }
         return false;
      }
      
      public static function getHourDifference(start:Number, end:Number) : int
      {
         return Math.floor((end - start) / 3600000);
      }
      
      public static function getDays(year:int, month:int) : int
      {
         var newDate:Date = new Date(year,month);
         return newDate.getUTCDate();
      }
      
      public static function decodeDated(dateStr:String) : Date
      {
         var temp:Array = dateStr.split("T");
         var tempD:Array = temp[0].split("-");
         var tempT:Array = temp[1].split(":");
         return new Date(tempD[0],tempD[1] - 1,tempD[2],tempT[0],tempT[1],tempT[2]);
      }
      
      public static function encodeDated(date:Date) : String
      {
         var str:String = "";
         var years:String = date.fullYear.toString();
         var mouth:String = date.month + 1 < 10?"0" + date.month + 1:(date.month + 1).toString();
         var day:String = date.date < 10?"0" + date.date:date.date.toString();
         var hours:String = date.hours < 10?"0" + date.hours:date.hours.toString();
         var min:String = date.minutes < 10?"0" + date.minutes:date.minutes.toString();
         var sec:String = date.seconds < 10?"0" + date.seconds:date.seconds.toString();
         return years + "-" + mouth + "-" + day + "T" + hours + ":" + min + ":" + sec;
      }
      
      public static function isToday(date:Date) : Boolean
      {
         var today:Date = new Date();
         return date.getDate() == today.getDate() && date.getMonth() == today.getMonth() && date.getFullYear() == today.getFullYear();
      }
      
      public static function dealWithStringDate(date:String) : Date
      {
         var h:int = 0;
         var d:int = 0;
         var m:int = 0;
         var y:int = 0;
         var min:int = 0;
         if(date.indexOf("-") > 0)
         {
            h = parseInt(date.split(" ")[1].split(":")[0]);
            min = parseInt(date.split(" ")[1].split(":")[1]);
            d = parseInt(date.split(" ")[0].split("-")[2]);
            m = parseInt(date.split(" ")[0].split("-")[1]) - 1;
            y = parseInt(date.split(" ")[0].split("-")[0]);
         }
         if(date.indexOf("/") > 0)
         {
            if(date.indexOf("PM") > 0)
            {
               h = parseInt(date.split(" ")[1].split(":")[0]) + 12;
            }
            else
            {
               h = parseInt(date.split(" ")[1].split(":")[0]);
            }
            min = parseInt(date.split(" ")[1].split(":")[1]);
            d = parseInt(date.split(" ")[0].split("/")[1]);
            m = parseInt(date.split(" ")[0].split("/")[0]) - 1;
            y = parseInt(date.split(" ")[0].split("/")[2]);
         }
         var realDate:Date = new Date(y,m,d,h,min);
         return realDate;
      }
      
      public static function dateFormat(date:Date) : String
      {
         var str:String = "";
         var years:String = date.fullYear.toString();
         var mouth:String = date.month + 1 < 10?"0" + (date.month + 1):(date.month + 1).toString();
         var day:String = date.date < 10?"0" + date.date:date.date.toString();
         var hours:String = date.hours < 10?"0" + date.hours:date.hours.toString();
         var min:String = date.minutes < 10?"0" + date.minutes:date.minutes.toString();
         var sec:String = date.seconds < 10?"0" + date.seconds:date.seconds.toString();
         return years + "-" + mouth + "-" + day + " " + hours + ":" + min + ":" + sec;
      }
      
      public static function dateFormat2(date:Date) : String
      {
         var str:String = "";
         var years:String = date.fullYear.toString();
         var mouth:String = date.month + 1 < 10?"0" + (date.month + 1):(date.month + 1).toString();
         var day:String = date.date < 10?"0" + date.date:date.date.toString();
         var hours:String = date.hours < 10?"0" + date.hours:date.hours.toString();
         var min:String = date.minutes < 10?"0" + date.minutes:date.minutes.toString();
         var sec:String = date.seconds < 10?"0" + date.seconds:date.seconds.toString();
         return years + "/" + mouth + "/" + day + " " + hours + ":" + min + ":" + sec;
      }
      
      public static function dateFormat3(date:Date) : String
      {
         var str:String = "";
         var years:String = date.fullYear.toString();
         var mouth:String = date.month + 1 < 10?"0" + (date.month + 1):(date.month + 1).toString();
         var day:String = date.date < 10?"0" + date.date:date.date.toString();
         return years + "/" + mouth + "/" + day + " 00:00:00";
      }
      
      public static function dateFormat4(date:Date) : String
      {
         var str:String = "";
         var years:String = date.fullYear.toString();
         var mouth:String = date.month + 1 < 10?"0" + (date.month + 1):(date.month + 1).toString();
         var day:String = date.date < 10?"0" + date.date:date.date.toString();
         return years + "/" + mouth + "/" + day + " 23:59:59";
      }
      
      public static function dateFormat5(date:Date) : String
      {
         var str:String = "";
         var years:String = date.fullYear.toString();
         var mouth:String = date.month + 1 < 10?"0" + (date.month + 1):(date.month + 1).toString();
         var day:String = date.date < 10?"0" + date.date:date.date.toString();
         var hours:String = date.hours < 10?"0" + date.hours:date.hours.toString();
         var min:String = date.minutes < 10?"0" + date.minutes:date.minutes.toString();
         return years + "-" + mouth + "-" + day + " " + hours + ":" + min;
      }
      
      public static function dateFormat6(date:Date) : String
      {
         var years:String = date.fullYear.toString();
         var mouth:String = date.month + 1 < 10?"0" + (date.month + 1):(date.month + 1).toString();
         var day:String = date.date < 10?"0" + date.date:date.date.toString();
         return years + "/" + mouth + "/" + day;
      }
      
      public static function dateFormatString(date:String, needTime:Boolean) : String
      {
         var myPattern:RegExp = /\//g;
         var resData:String = date.replace(myPattern,".");
         if(!needTime)
         {
            resData = resData.split(" ")[0];
         }
         return resData;
      }
      
      public static function dateTimeRemainArr(remainSeconds:Number) : Array
      {
         var day:int = remainSeconds / 86400;
         var hour:int = (remainSeconds - day * 86400) / 3600;
         var minutes:int = (remainSeconds - day * 86400 - hour * 3600) / 60;
         var seconds:int = (remainSeconds - day * 86400 - hour * 3600) % 60;
         var resArr:Array = [];
         resArr[0] = day < 0?0:day;
         resArr[1] = hour < 0?0:hour;
         resArr[2] = minutes < 0?0:minutes;
         resArr[3] = seconds < 0?0:seconds;
         return resArr;
      }
      
      public static function weekFormatString(NumWeek:int) : String
      {
         if(NumWeek > 0 && NumWeek <= 7)
         {
            return _weekString[NumWeek - 1];
         }
         return "";
      }
      
      public static function shorTimeRemainArr(second:int) : Array
      {
         var timeArr:Array = [];
         var s_time:* = second;
         var m_time:int = 0;
         var h_time:int = 0;
         if(s_time >= 60)
         {
            m_time = s_time / 60;
            s_time = int(s_time % 60);
            if(m_time > 60)
            {
               h_time = m_time / 60;
               m_time = m_time % 60;
            }
         }
         timeArr.push(h_time.toString());
         timeArr.push(m_time < 10?"0" + m_time:m_time.toString());
         timeArr.push(s_time < 10?"0" + s_time:s_time.toString());
         return timeArr;
      }
   }
}
