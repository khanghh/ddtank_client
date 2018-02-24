package BombTurnTable.data
{
   import BombTurnTable.view.quality.BaseTurnTable;
   import BombTurnTable.view.quality.BlueTurnTable;
   import BombTurnTable.view.quality.GreenTurnTable;
   import BombTurnTable.view.quality.PurpleTurnTable;
   import BombTurnTable.view.quality.WhiteTurnTable;
   
   public class BombTurnTableFactory
   {
      
      private static var _instance:BombTurnTableFactory;
       
      
      public function BombTurnTableFactory(param1:TurnTableFactoryEnforcer){super();}
      
      public static function get instance() : BombTurnTableFactory{return null;}
      
      public function createTurnTable(param1:int, param2:int) : BaseTurnTable{return null;}
   }
}

class TurnTableFactoryEnforcer
{
    
   
   function TurnTableFactoryEnforcer(){super();}
}
