package bagAndInfo.tips
{
   public class CallPropTxtTipInfo
   {
       
      
      private var _atcAdd:int = 0;
      
      private var _defAdd:int = 0;
      
      private var _agiAdd:int = 0;
      
      private var _lukAdd:int = 0;
      
      private var _rank:String = "";
      
      public function CallPropTxtTipInfo()
      {
         super();
      }
      
      public function get Attack() : int
      {
         return _atcAdd;
      }
      
      public function set Attack(param1:int) : void
      {
         _atcAdd = param1;
      }
      
      public function get Defend() : int
      {
         return _defAdd;
      }
      
      public function set Defend(param1:int) : void
      {
         _defAdd = param1;
      }
      
      public function get Agility() : int
      {
         return _agiAdd;
      }
      
      public function set Agility(param1:int) : void
      {
         _agiAdd = param1;
      }
      
      public function get Lucky() : int
      {
         return _lukAdd;
      }
      
      public function set Lucky(param1:int) : void
      {
         _lukAdd = param1;
      }
      
      public function get Rank() : String
      {
         return _rank;
      }
      
      public function set Rank(param1:String) : void
      {
         _rank = param1;
      }
   }
}
