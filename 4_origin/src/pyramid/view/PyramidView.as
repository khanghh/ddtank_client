package pyramid.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PyramidManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.view.SimpleReturnBar;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import pyramid.PyramidControl;
   
   public class PyramidView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _leftView:PyramidLeftView;
      
      private var _returnBtn:SimpleReturnBar;
      
      private var _helpView:PyramidHelpView;
      
      private var _shopView:PyramidShopView;
      
      private var _activeTimeTitle:FilterFrameText;
      
      private var _activeTimeTxt:FilterFrameText;
      
      public function PyramidView()
      {
         super();
         initView();
         initEvent();
         setActiveTime();
      }
      
      private function setActiveTime() : void
      {
         _activeTimeTxt.htmlText = LanguageMgr.GetTranslation("ddt.pyramid.lastTimeText",PyramidManager.instance.model.startActivityTime,PyramidManager.instance.model.endActivityTime);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("assets.pyramid.bg");
         _leftView = ComponentFactory.Instance.creatCustomObject("pyramid.view.leftView");
         _shopView = ComponentFactory.Instance.creatCustomObject("pyramid.view.shopView");
         _helpView = ComponentFactory.Instance.creatCustomObject("pyramid.view.helpView");
         _returnBtn = ComponentFactory.Instance.creatCustomObject("asset.simpleReturnBar.Button");
         _returnBtn.returnCall = returnToMain;
         _activeTimeTitle = ComponentFactory.Instance.creatComponentByStylename("pyramid.view.activeTimeTitle");
         _activeTimeTitle.text = LanguageMgr.GetTranslation("ddt.pyramid.activeTimeTitle");
         _activeTimeTxt = ComponentFactory.Instance.creatComponentByStylename("pyramid.view.activeTimeTxt");
         addChild(_bg);
         addChild(_leftView);
         addChild(_shopView);
         addChild(_helpView);
         addChild(_returnBtn);
         addChild(_activeTimeTitle);
         addChild(_activeTimeTxt);
      }
      
      private function initEvent() : void
      {
      }
      
      private function returnToMain() : void
      {
         SoundManager.instance.play("008");
         StateManager.setState("main");
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_returnBtn);
         _returnBtn = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_leftView);
         _leftView = null;
         ObjectUtils.disposeObject(_helpView);
         _helpView = null;
         ObjectUtils.disposeObject(_shopView);
         _shopView = null;
         ObjectUtils.disposeObject(_activeTimeTitle);
         _activeTimeTitle = null;
         ObjectUtils.disposeObject(_activeTimeTxt);
         _activeTimeTxt = null;
         PyramidControl.instance.movieLock = false;
         PyramidControl.instance.clearFrame();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
