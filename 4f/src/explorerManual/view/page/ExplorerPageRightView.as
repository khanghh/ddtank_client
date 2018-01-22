package explorerManual.view.page
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import explorerManual.ExplorerManualController;
   import explorerManual.data.ExplorerManualInfo;
   import explorerManual.data.model.ManualPageItemInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ExplorerPageRightView extends ExplorerPageRightViewBase
   {
       
      
      private var _preview:PreviewPageView;
      
      private var _lostIcon:Bitmap;
      
      private var _payTypeIcon:Bitmap;
      
      private var _payMoney:FilterFrameText;
      
      private var _aKeyBtn:BaseButton;
      
      private var _puzzleView:ManualPuzzlePageView;
      
      private var _activeBtn:BaseButton;
      
      private var _activeIcon:Bitmap;
      
      private var _activeIconSpri:Sprite;
      
      private var _confirmFrame:BaseAlerFrame;
      
      private var _loaderPic:DisplayLoader;
      
      public function ExplorerPageRightView(param1:int, param2:ExplorerManualInfo, param3:ExplorerManualController){super(null,null,null);}
      
      override protected function initView() : void{}
      
      override protected function initEvent() : void{}
      
      override protected function removeEvent() : void{}
      
      private function __akeyMuzzleHandler(param1:CEvent) : void{}
      
      private function __puzzleSucceedHandler(param1:CEvent) : void{}
      
      private function __aKeyBtnClickHandler(param1:MouseEvent) : void{}
      
      private function showAffirmHandle() : void{}
      
      private function __confirmBuy(param1:FrameEvent) : void{}
      
      private function __activeBtnClickHandler(param1:MouseEvent) : void{}
      
      private function getPregressValue(param1:int, param2:int) : String{return null;}
      
      override public function set pageInfo(param1:ManualPageItemInfo) : void{}
      
      override protected function updateShowView() : void{}
      
      private function loadActiveIcon() : void{}
      
      private function __picCompleteHandler(param1:LoaderEvent) : void{}
      
      private function clearLoader() : void{}
      
      private function clear() : void{}
      
      private function updatePuzzle() : void{}
      
      override public function dispose() : void{}
   }
}
