package ddtmatch.model
{
   import flash.events.EventDispatcher;
   
   public class DDTMatchModel extends EventDispatcher
   {
       
      
      private var _myRedPacketCount:int;
      
      private var _myRedPacketMoney:int;
      
      public function DDTMatchModel(){super();}
      
      public function get myRedPacketCount() : int{return 0;}
      
      public function set myRedPacketCount(param1:int) : void{}
      
      public function get myRedPacketMoney() : int{return 0;}
      
      public function set myRedPacketMoney(param1:int) : void{}
   }
}
