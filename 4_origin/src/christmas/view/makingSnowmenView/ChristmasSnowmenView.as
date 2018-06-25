package christmas.view.makingSnowmenView
{
   import christmas.ChristmasCoreController;
   import christmas.info.ChristmasSystemItemsInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class ChristmasSnowmenView extends Sprite implements Disposeable
   {
       
      
      private var _upGradeMc:MovieClip;
      
      private var _info:ChristmasSystemItemsInfo;
      
      public function ChristmasSnowmenView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _upGradeMc = ComponentFactory.Instance.creat("asset.snowmen.MC");
         _upGradeMc.x = -39;
         _upGradeMc.y = -32;
         _upGradeMc.gotoAndStop(_upGradeMc.totalFrames);
         _upGradeMc.visible = false;
         addChild(_upGradeMc);
      }
      
      private function init() : void
      {
         ChristmasCoreController.instance.expBar.initBar(ChristmasCoreController.instance.model.exp,ChristmasCoreController.instance.model.totalExp);
         _upGradeMc.visible = false;
      }
      
      public function upGradeAction(info:ChristmasSystemItemsInfo) : void
      {
         _info = info;
         if(!_info.isUp)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("christmas.curInfo.upgradeExp",info.num));
            ChristmasCoreController.instance.expBar.initBar(ChristmasCoreController.instance.model.exp,ChristmasCoreController.instance.model.totalExp);
            return;
         }
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("christmas.curInfo.succe",info.snowNum));
         _upGradeMc.visible = true;
         _upGradeMc.gotoAndPlay(1);
         ChristmasCoreController.instance.expBar.initBar(ChristmasCoreController.instance.model.totalExp,ChristmasCoreController.instance.model.totalExp);
         addEventListener("enterFrame",enterframeHander);
      }
      
      private function enterframeHander(e:Event) : void
      {
         if(_upGradeMc.currentFrame == _upGradeMc.totalFrames - 1)
         {
            _upGradeMc.visible = false;
            _upGradeMc.gotoAndStop(_upGradeMc.totalFrames);
            SoundManager.instance.stop("170");
            SoundManager.instance.play("169");
            init();
            removeEventListener("enterFrame",enterframeHander);
         }
      }
      
      public function dispose() : void
      {
         removeEventListener("enterFrame",enterframeHander);
         if(_upGradeMc)
         {
            _upGradeMc.gotoAndStop(_upGradeMc.totalFrames);
         }
         _info = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
