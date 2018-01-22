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
      
      public function ExplorerPageRightView(param1:int, param2:ExplorerManualInfo, param3:ExplorerManualController)
      {
         super(param1,param2,param3);
      }
      
      override protected function initView() : void
      {
         super.initView();
         _puzzleView = new ManualPuzzlePageView();
         addChild(_puzzleView);
         PositionUtils.setPos(_puzzleView,"explorerManual.puzzlePagePos");
         _preview = new PreviewPageView();
         PositionUtils.setPos(_preview,"explorerManual.pageRight.previewPageViewPos");
         addChild(_preview);
         _aKeyBtn = ComponentFactory.Instance.creatComponentByStylename("explorerManual.pageRight.aKeyBtn");
         addChild(_aKeyBtn);
         _aKeyBtn.enable = false;
         _activeBtn = ComponentFactory.Instance.creatComponentByStylename("explorerManual.pageRight.activeBtn");
         addChild(_activeBtn);
         _activeBtn.visible = false;
         _activeBtn.enable = false;
         _lostIcon = ComponentFactory.Instance.creat("asset.explorerManual.pageRightView.lostTxtIcon");
         addChild(_lostIcon);
         _payTypeIcon = ComponentFactory.Instance.creat("asset.ddtshop.PayTypeLabelTicket");
         addChild(_payTypeIcon);
         PositionUtils.setPos(_payTypeIcon,"explorerManual.shop.PayTypePos");
         _payMoney = ComponentFactory.Instance.creatComponentByStylename("explorerManual.pageLeftView.payMoneyValue");
         addChild(_payMoney);
         _payMoney.text = "100";
         _activeIconSpri = new Sprite();
         _activeIconSpri.x = 425;
         _activeIconSpri.y = 42;
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         if(_aKeyBtn)
         {
            _aKeyBtn.addEventListener("click",__aKeyBtnClickHandler);
         }
         if(_activeBtn)
         {
            _activeBtn.addEventListener("click",__activeBtnClickHandler);
         }
         if(_puzzleView)
         {
            _puzzleView.addEventListener("PuzzleSucceed",__puzzleSucceedHandler);
         }
         if(_ctrl)
         {
            _ctrl.addEventListener("akeyMuzzleComplete",__akeyMuzzleHandler);
         }
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         if(_aKeyBtn)
         {
            _aKeyBtn.removeEventListener("click",__aKeyBtnClickHandler);
         }
         if(_activeBtn)
         {
            _activeBtn.removeEventListener("click",__activeBtnClickHandler);
         }
         if(_puzzleView)
         {
            _puzzleView.removeEventListener("PuzzleSucceed",__puzzleSucceedHandler);
         }
         if(_ctrl)
         {
            _ctrl.removeEventListener("akeyMuzzleComplete",__akeyMuzzleHandler);
         }
      }
      
      private function __akeyMuzzleHandler(param1:CEvent) : void
      {
         var _loc2_:Boolean = param1.data;
         if(_loc2_)
         {
            _puzzleView.akey();
            _aKeyBtn.enable = false;
         }
         else
         {
            _aKeyBtn.enable = true;
         }
      }
      
      private function __puzzleSucceedHandler(param1:CEvent) : void
      {
         var _loc2_:Boolean = param1.data;
         _activeBtn.visible = _loc2_;
         var _loc3_:* = _loc2_;
         _activeBtn.enable = _loc3_;
         _aKeyBtn.enable = _loc3_;
         _ctrl.puzzleState = true;
      }
      
      private function __aKeyBtnClickHandler(param1:MouseEvent) : void
      {
         if(_pageInfo == null)
         {
            return;
         }
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PlayerManager.Instance.Self.Money < _pageInfo.ActivateCurrency)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("moneyPoorNote"));
            return;
         }
         showAffirmHandle();
      }
      
      private function showAffirmHandle() : void
      {
         _confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("explorerManual.akeyMuzzleConfirmTipTxt",_pageInfo.ActivateCurrency),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
         _confirmFrame.moveEnable = false;
         _confirmFrame.addEventListener("response",__confirmBuy);
      }
      
      private function __confirmBuy(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _confirmFrame.removeEventListener("response",__confirmBuy);
         _confirmFrame = null;
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(_ctrl)
            {
               _ctrl.sendManualPageActive(2,_pageInfo.ID);
               _aKeyBtn.enable = false;
            }
         }
      }
      
      private function __activeBtnClickHandler(param1:MouseEvent) : void
      {
         if(_ctrl)
         {
            _ctrl.sendManualPageActive(1,_pageInfo.ID);
            _activeBtn.enable = false;
            _activeBtn.visible = false;
            _ctrl.puzzleState = false;
         }
      }
      
      private function getPregressValue(param1:int, param2:int) : String
      {
         var _loc3_:* = null;
         _loc3_ = "<FONT FACE=\'Arial\' SIZE=\'14\' COLOR=\'#FF0000\' ><B>" + param1 + "</B></FONT>" + "/" + param2;
         return _loc3_;
      }
      
      override public function set pageInfo(param1:ManualPageItemInfo) : void
      {
         .super.pageInfo = param1;
         _payMoney.text = _pageInfo.ActivateCurrency.toString();
      }
      
      override protected function updateShowView() : void
      {
         if(_pageInfo == null)
         {
            return;
         }
         super.updateShowView();
         clear();
         if(_model.checkPageActiveByPageID(_pageInfo.ID))
         {
            _aKeyBtn.enable = false;
            _activeBtn.visible = false;
            loadActiveIcon();
         }
         else
         {
            var _loc1_:Boolean = false;
            _activeBtn.enable = _loc1_;
            _activeBtn.visible = _loc1_;
            updatePuzzle();
            _aKeyBtn.enable = _puzzleView.isCanClick;
         }
         _preview.tipData = _pageInfo;
      }
      
      private function loadActiveIcon() : void
      {
         addChildAt(_activeIconSpri,0);
         _loaderPic = LoadResourceManager.Instance.createLoader(PathManager.ManualDebrisIconPath(_pageInfo.ImagePath),0);
         _loaderPic.addEventListener("complete",__picCompleteHandler);
         LoadResourceManager.Instance.startLoad(_loaderPic);
      }
      
      private function __picCompleteHandler(param1:LoaderEvent) : void
      {
         if(param1.loader.isSuccess)
         {
            _activeIconSpri.addChild(param1.loader.content as Bitmap);
         }
         clearLoader();
      }
      
      private function clearLoader() : void
      {
         if(_loaderPic)
         {
            _loaderPic.removeEventListener("complete",__picCompleteHandler);
            _loaderPic = null;
         }
      }
      
      private function clear() : void
      {
         if(_puzzleView)
         {
            _puzzleView.clear();
         }
         ObjectUtils.disposeAllChildren(_activeIconSpri);
         clearLoader();
      }
      
      private function updatePuzzle() : void
      {
         var _loc1_:* = null;
         if(_puzzleView)
         {
            _puzzleView.totalDebrisCount = _pageInfo.DebrisCount;
            _loc1_ = _model.debrisInfo.getHaveDebrisByPageID(_pageInfo.ID);
            _puzzleView.debrisInfo = _loc1_;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         clear();
         ObjectUtils.disposeObject(_activeIconSpri);
         _activeIconSpri = null;
         ObjectUtils.disposeObject(_preview);
         _preview = null;
         ObjectUtils.disposeObject(_puzzleView);
         _puzzleView = null;
         if(_aKeyBtn)
         {
            ObjectUtils.disposeObject(_aKeyBtn);
         }
         _aKeyBtn = null;
         ObjectUtils.disposeObject(_lostIcon);
         _lostIcon = null;
         ObjectUtils.disposeObject(_payTypeIcon);
         _payTypeIcon = null;
         ObjectUtils.disposeObject(_payMoney);
         _payMoney = null;
         ObjectUtils.disposeObject(_activeIcon);
         _activeIcon = null;
         if(_confirmFrame)
         {
            _confirmFrame.removeEventListener("response",__confirmBuy);
            ObjectUtils.disposeObject(_confirmFrame);
         }
         _confirmFrame = null;
      }
   }
}
