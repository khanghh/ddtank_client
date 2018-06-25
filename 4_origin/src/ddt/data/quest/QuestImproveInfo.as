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
      
      public function set canOneKeyFinishTime(value:int) : void
      {
         _canOneKeyFinishTime = value;
      }
      
      public function get exploitRate() : Array
      {
         return _exploitRate;
      }
      
      public function set exploitRate(value:Array) : void
      {
         _exploitRate = value;
      }
      
      public function get goldRate() : Array
      {
         return _goldRate;
      }
      
      public function set goldRate(value:Array) : void
      {
         _goldRate = value;
      }
      
      public function get expRate() : Array
      {
         return _expRate;
      }
      
      public function set expRate(value:Array) : void
      {
         _expRate = value;
      }
      
      public function get bindMoneyRate() : Array
      {
         return _bindMoneyRate;
      }
      
      public function set bindMoneyRate(value:Array) : void
      {
         _bindMoneyRate = value;
      }
   }
}
