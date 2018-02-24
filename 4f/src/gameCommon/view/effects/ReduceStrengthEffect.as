package gameCommon.view.effects
{
   import gameCommon.model.Living;
   
   public class ReduceStrengthEffect extends BaseMirariEffectIcon
   {
       
      
      public var strength:int;
      
      public function ReduceStrengthEffect(){super();}
      
      override public function get mirariType() : int{return 0;}
      
      override protected function excuteEffectImp(param1:Living) : void{}
   }
}
