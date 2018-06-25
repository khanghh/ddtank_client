package gameCommon.view.effects{   import gameCommon.model.Living;      public class LockAngleEffectIcon extends BaseMirariEffectIcon   {                   public function LockAngleEffectIcon() { super(); }
            override public function get mirariType() : int { return 0; }
            override protected function excuteEffectImp(live:Living) : void { }
            override public function unExcuteEffect(live:Living) : void { }
   }}