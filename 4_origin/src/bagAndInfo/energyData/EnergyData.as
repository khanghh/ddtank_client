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
      
      public function set Energy(value:int) : void
      {
         _energy = value;
      }
      
      public function get Money() : int
      {
         return _money;
      }
      
      public function set Money(value:int) : void
      {
         _money = value;
      }
      
      public function get Count() : int
      {
         return _count;
      }
      
      public function set Count(value:int) : void
      {
         _count = value;
      }
   }
}
