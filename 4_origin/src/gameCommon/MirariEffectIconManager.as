package gameCommon
{
   import gameCommon.view.effects.AttackEffectIcon;
   import gameCommon.view.effects.BaseMirariEffectIcon;
   import gameCommon.view.effects.DefendEffectIcon;
   import gameCommon.view.effects.DefenseEffectIcon;
   import gameCommon.view.effects.DisenableFlyEffectIcon;
   import gameCommon.view.effects.FiringEffectIcon;
   import gameCommon.view.effects.LimitMaxForceEffectIcon;
   import gameCommon.view.effects.LockAngleEffectIcon;
   import gameCommon.view.effects.NoHoleEffectIcon;
   import gameCommon.view.effects.ReduceStrengthEffect;
   import gameCommon.view.effects.ResolveHurtEffectIcon;
   import gameCommon.view.effects.RevertEffectIcon;
   import gameCommon.view.effects.TargetingEffectIcon;
   import gameCommon.view.effects.TiredEffectIcon;
   import gameCommon.view.effects.WeaknessEffectIcon;
   import road7th.data.DictionaryData;
   
   public class MirariEffectIconManager
   {
      
      private static var _instance:MirariEffectIconManager;
       
      
      private var _effecticons:DictionaryData;
      
      private var _isSetup:Boolean;
      
      public function MirariEffectIconManager(param1:SingletonEnforce)
      {
         super();
         initialize();
      }
      
      public static function getInstance() : MirariEffectIconManager
      {
         if(_instance == null)
         {
            _instance = new MirariEffectIconManager(new SingletonEnforce());
         }
         return _instance;
      }
      
      private function initialize() : void
      {
         _effecticons = new DictionaryData();
         _isSetup = false;
      }
      
      private function release() : void
      {
         if(_effecticons)
         {
            _effecticons.clear();
         }
         _effecticons = null;
      }
      
      public function get isSetup() : Boolean
      {
         return _isSetup;
      }
      
      public function setup() : void
      {
         if(_isSetup == false)
         {
            _isSetup = true;
            _effecticons.add(1,TiredEffectIcon);
            _effecticons.add(2,FiringEffectIcon);
            _effecticons.add(3,LockAngleEffectIcon);
            _effecticons.add(4,WeaknessEffectIcon);
            _effecticons.add(5,NoHoleEffectIcon);
            _effecticons.add(6,DefendEffectIcon);
            _effecticons.add(7,TargetingEffectIcon);
            _effecticons.add(8,DisenableFlyEffectIcon);
            _effecticons.add(9,LimitMaxForceEffectIcon);
            _effecticons.add(12,ReduceStrengthEffect);
            _effecticons.add(10,ResolveHurtEffectIcon);
            _effecticons.add(11,RevertEffectIcon);
            _effecticons.add(14,DefenseEffectIcon);
            _effecticons.add(13,AttackEffectIcon);
         }
      }
      
      public function unsetup() : void
      {
         if(_isSetup)
         {
            release();
            _isSetup = false;
         }
      }
      
      public function createEffectIcon(param1:int) : BaseMirariEffectIcon
      {
         if(!_isSetup)
         {
            setup();
         }
         var _loc3_:Class = _effecticons[param1] as Class;
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc2_:BaseMirariEffectIcon = new _loc3_() as BaseMirariEffectIcon;
         return _loc2_;
      }
   }
}

class SingletonEnforce
{
    
   
   function SingletonEnforce()
   {
      super();
   }
}
