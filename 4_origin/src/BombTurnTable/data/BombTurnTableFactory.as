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
       
      
      public function BombTurnTableFactory(param1:TurnTableFactoryEnforcer)
      {
         super();
      }
      
      public static function get instance() : BombTurnTableFactory
      {
         if(_instance == null)
         {
            _instance = new BombTurnTableFactory(new TurnTableFactoryEnforcer());
         }
         return _instance;
      }
      
      public function createTurnTable(param1:int, param2:int) : BaseTurnTable
      {
         var _loc3_:* = null;
         var _loc4_:int = (param1 - 1) / 4;
         switch(int(_loc4_))
         {
            case 0:
               _loc3_ = new WhiteTurnTable(param2);
               break;
            case 1:
               _loc3_ = new GreenTurnTable(param2);
               break;
            case 2:
               _loc3_ = new BlueTurnTable(param2);
               break;
            case 3:
               _loc3_ = new PurpleTurnTable(param2);
         }
         return _loc3_;
      }
   }
}

class TurnTableFactoryEnforcer
{
    
   
   function TurnTableFactoryEnforcer()
   {
      super();
   }
}
