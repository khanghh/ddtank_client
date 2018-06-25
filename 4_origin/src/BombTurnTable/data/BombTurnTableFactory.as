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
       
      
      public function BombTurnTableFactory(instance:TurnTableFactoryEnforcer)
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
      
      public function createTurnTable(level:int, status:int) : BaseTurnTable
      {
         var view:* = null;
         var type:int = (level - 1) / 4;
         switch(int(type))
         {
            case 0:
               view = new WhiteTurnTable(status);
               break;
            case 1:
               view = new GreenTurnTable(status);
               break;
            case 2:
               view = new BlueTurnTable(status);
               break;
            case 3:
               view = new PurpleTurnTable(status);
         }
         return view;
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
