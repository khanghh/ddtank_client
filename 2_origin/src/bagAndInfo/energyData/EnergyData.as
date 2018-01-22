package bagAndInfo.energyData
{
   public class EnergyData
   {
       
      
      private var _energy:int;
      
      private var _money:int;
      
      private var _count:int;
      
      public function EnergyData()
      {
         super();
      }
      
      public function get Energy() : int
      {
         return _energy;
      }
      
      public function set Energy(param1:int) : void
      {
         _energy = param1;
      }
      
      public function get Money() : int
      {
         return _money;
      }
      
      public function set Money(param1:int) : void
      {
         _money = param1;
      }
      
      public function get Count() : int
      {
         return _count;
      }
      
      public function set Count(param1:int) : void
      {
         _count = param1;
      }
   }
}
