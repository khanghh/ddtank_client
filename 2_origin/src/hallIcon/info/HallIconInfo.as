package hallIcon.info
{
   public class HallIconInfo
   {
       
      
      public var halltype:int;
      
      public var icontype:String;
      
      public var isopen:Boolean;
      
      public var timemsg:String;
      
      public var fightover:Boolean;
      
      public var orderid:int;
      
      public var num:int;
      
      public var timeShow:Boolean;
      
      public function HallIconInfo(param1:String = "", param2:Boolean = false, param3:String = null, param4:int = 0, param5:Boolean = false, param6:int = 0, param7:int = -1, param8:Boolean = false)
      {
         super();
         icontype = param1;
         isopen = param2;
         timemsg = param3;
         halltype = param4;
         fightover = param5;
         orderid = param6;
         num = param7;
         timeShow = param8;
      }
   }
}
