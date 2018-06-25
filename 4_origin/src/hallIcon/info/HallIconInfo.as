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
      
      public function HallIconInfo($icontype:String = "", $isopen:Boolean = false, $timemsg:String = null, $halltype:int = 0, $fightover:Boolean = false, $orderid:int = 0, $num:int = -1, $timeShow:Boolean = false)
      {
         super();
         icontype = $icontype;
         isopen = $isopen;
         timemsg = $timemsg;
         halltype = $halltype;
         fightover = $fightover;
         orderid = $orderid;
         num = $num;
         timeShow = $timeShow;
      }
   }
}
