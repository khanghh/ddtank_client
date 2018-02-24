package consortionBattle
{
   import consortionBattle.player.ConsortiaBattlePlayer;
   import ddt.manager.PlayerManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class ConsortiaBattleController extends EventDispatcher
   {
      
      private static var _instance:ConsortiaBattleController;
       
      
      public function ConsortiaBattleController(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : ConsortiaBattleController{return null;}
      
      public function judgePlayerVisible(param1:ConsortiaBattlePlayer) : Boolean{return false;}
   }
}
