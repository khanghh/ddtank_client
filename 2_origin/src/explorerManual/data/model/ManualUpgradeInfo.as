package explorerManual.data.model
{
   public class ManualUpgradeInfo
   {
       
      
      private var _manualLevel:int;
      
      private var _describe:String;
      
      private var _conditionType:int;
      
      private var _parameter1:int;
      
      private var _parameter2:int;
      
      private var _parameter3:int;
      
      public function ManualUpgradeInfo()
      {
         super();
      }
      
      public function get Parameter3() : int
      {
         return _parameter3;
      }
      
      public function set Parameter3(value:int) : void
      {
         _parameter3 = value;
      }
      
      public function get Parameter2() : int
      {
         return _parameter2;
      }
      
      public function set Parameter2(value:int) : void
      {
         _parameter2 = value;
      }
      
      public function get Parameter1() : int
      {
         return _parameter1;
      }
      
      public function set Parameter1(value:int) : void
      {
         _parameter1 = value;
      }
      
      public function get ConditionType() : int
      {
         return _conditionType;
      }
      
      public function set ConditionType(value:int) : void
      {
         _conditionType = value;
      }
      
      public function get Describe() : String
      {
         return _describe;
      }
      
      public function set Describe(value:String) : void
      {
         _describe = value;
      }
      
      public function get ManualLevel() : int
      {
         return _manualLevel;
      }
      
      public function set ManualLevel(value:int) : void
      {
         _manualLevel = value;
      }
   }
}
