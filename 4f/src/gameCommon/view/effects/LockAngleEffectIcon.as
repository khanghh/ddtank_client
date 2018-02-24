package gameCommon.view.effects
{
   import gameCommon.model.Living;
   
   public class LockAngleEffectIcon extends BaseMirariEffectIcon
   {
       
      
      public function LockAngleEffectIcon(){super();}
      
      override public function get mirariType() : int{return 0;}
      
      override protected function excuteEffectImp(param1:Living) : void{}
      
      override public function unExcuteEffect(param1:Living) : void{}
   }
}
