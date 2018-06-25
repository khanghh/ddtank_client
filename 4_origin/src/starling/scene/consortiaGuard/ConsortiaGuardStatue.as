package starling.scene.consortiaGuard
{
   import com.pickgliss.utils.StarlingObjectUtils;
   import consortion.guard.ConsortiaGuardControl;
   import consortion.guard.ConsortiaGuardEvent;
   import road7th.StarlingMain;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class ConsortiaGuardStatue extends Sprite
   {
       
      
      private var _statueImage:Image;
      
      private var _hpBack:Image;
      
      private var _hpProgress:Image;
      
      private var _mask:Sprite;
      
      private var _hpBg:Image;
      
      private var _width:Number;
      
      private var _height:Number;
      
      public function ConsortiaGuardStatue()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _laySortY = 800;
         _statueImage = StarlingMain.instance.createImage("consortiaGuardStatue","consortiaGuardStatuePos");
         addChild(_statueImage);
         _mask = new Sprite();
         _hpBack = StarlingMain.instance.createImage("consortiaGuardBack","consortiaGuardBackPos");
         addChild(_hpBack);
         _hpProgress = StarlingMain.instance.createImage("consortiaGuardProgress","consortiaGuardProgressPos");
         _width = _hpProgress.width;
         _height = _hpProgress.height;
         _hpProgress.mask = _mask;
         addChild(_hpProgress);
         updateState();
         ConsortiaGuardControl.Instance.addEventListener("updateBossState",__onUpdateState);
      }
      
      public function updateState() : void
      {
         var maxHp:Number = ConsortiaGuardControl.Instance.model.statueMaxHp;
         var hp:Number = ConsortiaGuardControl.Instance.model.statueHp;
         var w:Number = hp / maxHp * _width;
         _mask.graphics.clear();
         _mask.graphics.beginFill(0);
         _mask.graphics.drawRect(0,0,w,_height);
         _mask.graphics.endFill();
      }
      
      private function __onUpdateState(e:ConsortiaGuardEvent) : void
      {
         updateState();
      }
      
      override public function dispose() : void
      {
         ConsortiaGuardControl.Instance.removeEventListener("updateBossState",__onUpdateState);
         StarlingObjectUtils.disposeObject(_statueImage);
         _statueImage = null;
         super.dispose();
      }
   }
}
