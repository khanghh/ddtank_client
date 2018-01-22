package ddt.data.quest
{
   public class QuestImproveInfo
   {
       
      
      private var _bindMoneyRate:Array;
      
      private var _expRate:Array;
      
      private var _goldRate:Array;
      
      private var _exploitRate:Array;
      
      private var _canOneKeyFinishTime:int;
      
      public function QuestImproveInfo()
      {
         super();
      }
      
      public function get canOneKeyFinishTime() : int
      {
         return _canOneKeyFinishTime;
      }
      
      public function set canOneKeyFinishTime(param1:int) : void
      {
         _canOneKeyFinishTime = param1;
      }
      
      public function get exploitRate() : Array
      {
         return _exploitRate;
      }
      
      public function set exploitRate(param1:Array) : void
      {
         _exploitRate = param1;
      }
      
      public function get goldRate() : Array
      {
         return _goldRate;
      }
      
      public function set goldRate(param1:Array) : void
      {
         _goldRate = param1;
      }
      
      public function get expRate() : Array
      {
         return _expRate;
      }
      
      public function set expRate(param1:Array) : void
      {
         _expRate = param1;
      }
      
      public function get bindMoneyRate() : Array
      {
         return _bindMoneyRate;
      }
      
      public function set bindMoneyRate(param1:Array) : void
      {
         _bindMoneyRate = param1;
      }
   }
}
