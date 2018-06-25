package consortionBattle
{
   import consortionBattle.player.ConsortiaBattlePlayer;
   import ddt.manager.PlayerManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class ConsortiaBattleController extends EventDispatcher
   {
      
      private static var _instance:ConsortiaBattleController;
       
      
      public function ConsortiaBattleController(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get instance() : ConsortiaBattleController
      {
         if(_instance == null)
         {
            _instance = new ConsortiaBattleController();
         }
         return _instance;
      }
      
      public function judgePlayerVisible(player:ConsortiaBattlePlayer) : Boolean
      {
         if(player.playerData.id == PlayerManager.Instance.Self.ID)
         {
            return true;
         }
         if(ConsortiaBattleManager.instance.isHide(1) && player.playerData.selfOrEnemy == 1)
         {
            return false;
         }
         if(ConsortiaBattleManager.instance.isHide(2) && player.isInTomb)
         {
            return false;
         }
         if(ConsortiaBattleManager.instance.isHide(3) && player.isInFighting)
         {
            return false;
         }
         return true;
      }
   }
}
