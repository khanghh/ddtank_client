package store.equipGhost.data
{
   public class GhostPropertyData
   {
       
      
      private var _mainProperty:uint;
      
      private var _attack:uint;
      
      private var _lucky:uint;
      
      private var _defend:uint;
      
      private var _agility:uint;
      
      public function GhostPropertyData(param1:uint, param2:uint = 0, param3:uint = 0, param4:uint = 0, param5:uint = 0)
      {
         super();
         _mainProperty = param1;
         _attack = param2;
         _lucky = param3;
         _defend = param4;
         _agility = param5;
      }
      
      public function get mainProperty() : uint
      {
         return _mainProperty;
      }
      
      public function get attack() : uint
      {
         return _attack;
      }
      
      public function get lucky() : uint
      {
         return _lucky;
      }
      
      public function get defend() : uint
      {
         return _defend;
      }
      
      public function get agility() : uint
      {
         return _agility;
      }
   }
}
