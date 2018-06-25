package store.equipGhost.data
{
   public class GhostPropertyData
   {
       
      
      private var _mainProperty:uint;
      
      private var _attack:uint;
      
      private var _lucky:uint;
      
      private var _defend:uint;
      
      private var _agility:uint;
      
      public function GhostPropertyData(mainProperty:uint, attack:uint = 0, lucky:uint = 0, defend:uint = 0, agility:uint = 0)
      {
         super();
         _mainProperty = mainProperty;
         _attack = attack;
         _lucky = lucky;
         _defend = defend;
         _agility = agility;
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
