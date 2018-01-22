package gameCommon.view.effects
{
   public class LimitMaxForceEffectIcon extends BaseMirariEffectIcon
   {
       
      
      public var force:int;
      
      public function LimitMaxForceEffectIcon()
      {
         _iconClass = "asset.game.limitForceAsset";
         _iconImageClass = "game_buff_limitForceAsset";
         super();
      }
      
      override public function get mirariType() : int
      {
         return 9;
      }
      
      override public function get single() : Boolean
      {
         return true;
      }
   }
}
