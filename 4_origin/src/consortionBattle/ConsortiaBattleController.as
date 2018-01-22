package consortionBattle
{
   import consortionBattle.player.ConsortiaBattlePlayer;
   import ddt.manager.PlayerManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class ConsortiaBattleController extends EventDispatcher
   {
      
      private static var _instance:ConsortiaBattleController;
       
      
      public function ConsortiaBattleController(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : ConsortiaBattleController
      {
         if(_instance == null)
         {
            _instance = new ConsortiaBattleController();
         }
         return _instance;
      }
      
      public function judgePlayerVisible(param1:ConsortiaBattlePlayer) : Boolean
      {
         if(param1.playerData.id == PlayerManager.Instance.Self.ID)
         {
            return true;
         }
         if(ConsortiaBattleManager.instance.isHide(1) && param1.playerData.selfOrEnemy == 1)
         {
            return false;
         }
         if(ConsortiaBattleManager.instance.isHide(2) && param1.isInTomb)
         {
            return false;
         }
         if(ConsortiaBattleManager.instance.isHide(3) && param1.isInFighting)
         {
            return false;
         }
         return true;
      }
   }
}
