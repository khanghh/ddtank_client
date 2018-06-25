package gemstone
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.SelfInfo;
   import ddt.manager.PlayerManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.display.Sprite;
   import gemstone.info.GemstoneStaticInfo;
   import gemstone.info.GemstoneUpGradeInfo;
   import gemstone.items.ExpBar;
   import gemstone.views.GemstoneCurInfo;
   import gemstone.views.GemstoneInfoView;
   import gemstone.views.GemstoneObtainView;
   import gemstone.views.GemstoneUpView;
   
   public class GemstoneFrame extends Frame
   {
       
      
      private var _gemstoneObtainView:GemstoneObtainView;
      
      private var _gemstoneInfoView:GemstoneInfoView;
      
      private var _gemstoneUpView:GemstoneUpView;
      
      private var _selfInfo:SelfInfo;
      
      private var _bg:ScaleBitmapImage;
      
      private var _gemstoneCurInfo:GemstoneCurInfo;
      
      private var _loader:BaseLoader;
      
      private var _gInfoList:Vector.<GemstoneStaticInfo>;
      
      public var redInfoList:Vector.<GemstoneStaticInfo>;
      
      public var buleInfoList:Vector.<GemstoneStaticInfo>;
      
      public var greeInfoList:Vector.<GemstoneStaticInfo>;
      
      public var yellInfoList:Vector.<GemstoneStaticInfo>;
      
      private var _goundMask:Sprite;
      
      public function GemstoneFrame()
      {
         super();
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",gemstoneCompHander);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",gemstoneProgress);
         UIModuleLoader.Instance.addUIModuleImp("gemstone");
      }
      
      private function gemstoneProgress(pEvent:UIModuleEvent) : void
      {
         if(pEvent.module == "gemstone")
         {
            UIModuleSmallLoading.Instance.progress = pEvent.loader.progress * 100;
         }
      }
      
      private function gemstoneCompHander(e:UIModuleEvent) : void
      {
         if(e.module == "gemstone")
         {
            UIModuleSmallLoading.Instance.hide();
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",gemstoneCompHander);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",gemstoneProgress);
            _selfInfo = PlayerManager.Instance.Self;
            initView();
         }
      }
      
      public function initView() : void
      {
         _goundMask = new Sprite();
         _goundMask.graphics.beginFill(0);
         _goundMask.graphics.drawRect(-69,-94,1000,800);
         _goundMask.graphics.endFill();
         _goundMask.alpha = 0;
         _goundMask.visible = false;
         _gemstoneUpView = new GemstoneUpView(_selfInfo);
         addToContent(_gemstoneUpView);
         addToContent(_goundMask);
         firstTimeUpdateUpGradeButton();
         _gemstoneUpView.updateContentBG();
      }
      
      public function firstTimeUpdateUpGradeButton() : void
      {
         GemstoneManager.Instance.curUpInfoList = GemstoneManager.Instance.hariList;
         _gemstoneUpView.updateUpButton(GemstoneManager.Instance.hariList);
      }
      
      public function updateUpButton() : void
      {
         _gemstoneUpView.updateUpButton(GemstoneManager.Instance.curUpInfoList);
      }
      
      public function upDatafitCount() : void
      {
         _gemstoneUpView.upDatafitCount();
      }
      
      public function getMaskMc() : Sprite
      {
         return _goundMask;
      }
      
      public function gemstoneAction(info:GemstoneUpGradeInfo) : void
      {
         _gemstoneUpView.gemstoneAction(info);
      }
      
      public function get expBar() : ExpBar
      {
         return _gemstoneUpView.expBar;
      }
      
      override public function dispose() : void
      {
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",gemstoneCompHander);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",gemstoneProgress);
         GemstoneManager.Instance.clearFrame();
         if(_gemstoneObtainView)
         {
            ObjectUtils.disposeObject(_gemstoneObtainView);
            _gemstoneObtainView = null;
         }
         if(_gemstoneInfoView)
         {
            ObjectUtils.disposeObject(_gemstoneInfoView);
            _gemstoneInfoView = null;
         }
         if(_gemstoneUpView)
         {
            ObjectUtils.disposeObject(_gemstoneUpView);
            _gemstoneUpView = null;
         }
         super.dispose();
      }
   }
}
