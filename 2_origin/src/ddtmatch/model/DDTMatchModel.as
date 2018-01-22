package ddtmatch.model
{
   import flash.events.EventDispatcher;
   
   public class DDTMatchModel extends EventDispatcher
   {
       
      
      private var _myRedPacketCount:int;
      
      private var _myRedPacketMoney:int;
      
      public function DDTMatchModel()
      {
         super();
      }
      
      public function get myRedPacketCount() : int
      {
         return _myRedPacketCount;
      }
      
      public function set myRedPacketCount(param1:int) : void
      {
         _myRedPacketCount = param1;
      }
      
      public function get myRedPacketMoney() : int
      {
         return _myRedPacketMoney;
      }
      
      public function set myRedPacketMoney(param1:int) : void
      {
         _myRedPacketMoney = param1;
      }
   }
}
