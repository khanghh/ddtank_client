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
      
      public function set Attack(M:int) : void
      {
         _atcAdd = M;
      }
      
      public function get Defend() : int
      {
         return _defAdd;
      }
      
      public function set Defend(M:int) : void
      {
         _defAdd = M;
      }
      
      public function get Agility() : int
      {
         return _agiAdd;
      }
      
      public function set Agility(M:int) : void
      {
         _agiAdd = M;
      }
      
      public function get Lucky() : int
      {
         return _lukAdd;
      }
      
      public function set Lucky(M:int) : void
      {
         _lukAdd = M;
      }
      
      public function get Rank() : String
      {
         return _rank;
      }
      
      public function set Rank(M:String) : void
      {
         _rank = M;
      }
   }
}
