package gameCommon.view.effects{   import gameCommon.model.Living;      public class DisenableFlyEffectIcon extends BaseMirariEffectIcon   {                   public function DisenableFlyEffectIcon() { super(); }
            override public function get mirariType() : int { return 0; }
            override protected function excuteEffectImp(live:Living) : void { }
            override public function unExcuteEffect(live:Living) : void { }
   }}