package gameCommon{   import gameCommon.view.effects.AttackEffectIcon;   import gameCommon.view.effects.BaseMirariEffectIcon;   import gameCommon.view.effects.DefendEffectIcon;   import gameCommon.view.effects.DefenseEffectIcon;   import gameCommon.view.effects.DisenableFlyEffectIcon;   import gameCommon.view.effects.FiringEffectIcon;   import gameCommon.view.effects.LimitMaxForceEffectIcon;   import gameCommon.view.effects.LockAngleEffectIcon;   import gameCommon.view.effects.NoHoleEffectIcon;   import gameCommon.view.effects.ReduceStrengthEffect;   import gameCommon.view.effects.ResolveHurtEffectIcon;   import gameCommon.view.effects.RevertEffectIcon;   import gameCommon.view.effects.TargetingEffectIcon;   import gameCommon.view.effects.TiredEffectIcon;   import gameCommon.view.effects.WeaknessEffectIcon;   import road7th.data.DictionaryData;      public class MirariEffectIconManager   {            private static var _instance:MirariEffectIconManager;                   private var _effecticons:DictionaryData;            private var _isSetup:Boolean;            public function MirariEffectIconManager(enforce:SingletonEnforce) { super(); }
            public static function getInstance() : MirariEffectIconManager { return null; }
            private function initialize() : void { }
            private function release() : void { }
            public function get isSetup() : Boolean { return false; }
            public function setup() : void { }
            public function unsetup() : void { }
            public function createEffectIcon(type:int) : BaseMirariEffectIcon { return null; }
   }}class SingletonEnforce{          function SingletonEnforce() { super(); }
}