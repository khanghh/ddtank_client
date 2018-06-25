package ddt.manager
{
   import ddt.data.player.BasePlayer;
   import ddt.view.tips.PlayerTip;
   
   public class PlayerTipManager
   {
      
      private static var _view:PlayerTip;
      
      private static var _yOffset:int;
       
      
      public function PlayerTipManager()
      {
         super();
      }
      
      public static function show(info:BasePlayer, yOffset:int = -1) : void
      {
         if(info == null)
         {
            return;
         }
         if(info.ID == PlayerManager.Instance.Self.ID)
         {
            instance.setSelfDisable(true);
         }
         else
         {
            instance.setSelfDisable(false);
            if(PlayerManager.Instance.Self.IsMarried)
            {
               instance.proposeEnable(false);
            }
         }
         instance.playerInfo = info;
         instance.show(yOffset);
      }
      
      public static function get instance() : PlayerTip
      {
         if(_view == null)
         {
            _view = new PlayerTip();
         }
         return _view;
      }
      
      public static function hide() : void
      {
         instance.hide();
      }
   }
}
