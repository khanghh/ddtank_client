package gameCommon.view.effects
{
   import gameCommon.model.Living;
   
   public class ReduceStrengthEffect extends BaseMirariEffectIcon
   {
       
      
      public var strength:int;
      
      public function ReduceStrengthEffect()
      {
         _iconClass = "asset.game.tiredAsset";
         _iconImageClass = "game_buff_tiredAsset";
         super();
      }
      
      override public function get mirariType() : int
      {
         return 12;
      }
      
      override protected function excuteEffectImp(param1:Living) : void
      {
         param1.energy = strength;
         super.excuteEffectImp(param1);
      }
   }
}
