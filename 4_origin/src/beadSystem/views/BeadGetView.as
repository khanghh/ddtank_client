package beadSystem.views
{
   import baglocked.BaglockedManager;
   import beadSystem.beadSystemManager;
   import beadSystem.data.BeadEvent;
   import beadSystem.model.BeadModel;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import kingBless.KingBlessManager;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class BeadGetView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _requestBtn1:SimpleBitmapButton;
      
      private var _requestBtn2:SimpleBitmapButton;
      
      private var _requestBtn3:SimpleBitmapButton;
      
      private var _requestBtn4:SimpleBitmapButton;
      
      private var _requestBtn1MC:MovieClip;
      
      private var _requestBtn2MC:MovieClip;
      
      private var _requestBtn3MC:MovieClip;
      
      private var _requestBtn4MC:MovieClip;
      
      private var _autoOpenBeadTimer:TimerJuggler;
      
      private var _autoOpenBeadCheckBtn:SelectedCheckButton;
      
      private var _isSelectAutoCheck:Boolean = false;
      
      private var _isServerReplied:Boolean = false;
      
      private var _isFirst:Boolean = true;
      
      private var _alertConfirm:BaseAlerFrame;
      
      private var _alertCharge:BaseAlerFrame;
      
      private var _titleBmp:Bitmap;
      
      private var _freeTipTxt:FilterFrameText;
      
      private var _selectedBandBtn:SelectedCheckButton;
      
      private var _selectedBtn:SelectedCheckButton;
      
      private var _moneyTxt:FilterFrameText;
      
      private var _bandMoneyTxt:FilterFrameText;
      
      private var _isBand:Boolean;
      
      private var vBtn:SimpleBitmapButton;
      
      public function BeadGetView()
      {
         super();
         initView();
         initEvent();
         createMovies();
         initBtnState();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("beadSystem.getBead.bg");
         addChild(_bg);
         _requestBtn1 = ComponentFactory.Instance.creatComponentByStylename("beadSystem.getBead.requestBtn1");
         _requestBtn1.tipData = 0;
         _requestBtn2 = ComponentFactory.Instance.creatComponentByStylename("beadSystem.getBead.requestBtn2");
         _requestBtn2.tipData = 1;
         _requestBtn2.enable = false;
         _requestBtn3 = ComponentFactory.Instance.creatComponentByStylename("beadSystem.getBead.requestBtn3");
         _requestBtn3.tipData = 2;
         _requestBtn3.enable = false;
         _requestBtn4 = ComponentFactory.Instance.creatComponentByStylename("beadSystem.getBead.requestBtn4");
         _requestBtn4.tipData = 3;
         _requestBtn4.enable = false;
         _autoOpenBeadCheckBtn = ComponentFactory.Instance.creatComponentByStylename("beadSystem.autoOpenBeadCheckBtn");
         _autoOpenBeadCheckBtn.text = LanguageMgr.GetTranslation("ddt.beadSystem.autoOpen");
         _titleBmp = ComponentFactory.Instance.creatBitmap("beadSystem.autoOpenTitle");
         _freeTipTxt = ComponentFactory.Instance.creatComponentByStylename("beadSystem.getBeadView.freeGetTipTxt");
         addChild(_requestBtn1);
         addChild(_requestBtn2);
         addChild(_requestBtn3);
         addChild(_requestBtn4);
         addChild(_autoOpenBeadCheckBtn);
         addChild(_titleBmp);
         addChild(_freeTipTxt);
         refreshFreeTipTxt(null);
         _isBand = false;
         _selectedBandBtn = ComponentFactory.Instance.creatComponentByStylename("vip.core.selectBtn");
         _selectedBandBtn.x = 264;
         _selectedBandBtn.y = 75;
         _selectedBandBtn.addEventListener("click",selectedBandHander);
         addChild(_selectedBandBtn);
         _selectedBtn = ComponentFactory.Instance.creatComponentByStylename("vip.core.selectBtn");
         _selectedBtn.x = 187;
         _selectedBtn.y = 75;
         _selectedBtn.selected = true;
         _selectedBtn.enable = false;
         _selectedBtn.addEventListener("click",selectedHander);
         addChild(_selectedBtn);
         _bandMoneyTxt = ComponentFactory.Instance.creatComponentByStylename("vip.core.bandMoney");
         _bandMoneyTxt.x = 243;
         _bandMoneyTxt.y = 84;
         _bandMoneyTxt.text = LanguageMgr.GetTranslation("ddtMoney");
         addChild(_bandMoneyTxt);
         _moneyTxt = ComponentFactory.Instance.creatComponentByStylename("vip.core.bandMoney");
         _moneyTxt.x = 153;
         _moneyTxt.y = 84;
         _moneyTxt.text = LanguageMgr.GetTranslation("money");
         addChild(_moneyTxt);
      }
      
      private function selectedHander(e:MouseEvent) : void
      {
         if(_selectedBandBtn.selected)
         {
            _selectedBtn.enable = false;
            _selectedBtn.selected = true;
            _selectedBandBtn.enable = true;
            _selectedBandBtn.selected = false;
            _isBand = false;
         }
      }
      
      private function selectedBandHander(e:MouseEvent) : void
      {
         if(_selectedBtn.selected)
         {
            _selectedBandBtn.enable = false;
            _selectedBandBtn.selected = true;
            _selectedBtn.enable = true;
            _selectedBtn.selected = false;
            _isBand = true;
         }
      }
      
      private function createMovies() : void
      {
         _requestBtn1MC = ClassUtils.CreatInstance("beadSystem.requestBtn1.movie");
         _requestBtn1MC.gotoAndStop(1);
         _requestBtn1MC.mouseEnabled = false;
         _requestBtn1MC.mouseChildren = false;
         _requestBtn1MC.x = 7;
         _requestBtn1MC.y = 14;
         _requestBtn2MC = ClassUtils.CreatInstance("beadSystem.requestBtn2.movie");
         _requestBtn2MC.gotoAndStop(1);
         _requestBtn2MC.mouseEnabled = false;
         _requestBtn2MC.mouseChildren = false;
         _requestBtn2MC.x = 114;
         _requestBtn2MC.y = 9;
         _requestBtn2MC.visible = false;
         _requestBtn3MC = ClassUtils.CreatInstance("beadSystem.requestBtn3.movie");
         _requestBtn3MC.gotoAndStop(1);
         _requestBtn3MC.mouseEnabled = false;
         _requestBtn3MC.mouseChildren = false;
         _requestBtn3MC.x = 220;
         _requestBtn3MC.y = 9;
         _requestBtn3MC.visible = false;
         _requestBtn4MC = ClassUtils.CreatInstance("beadSystem.requestBtn4.movie");
         _requestBtn4MC.gotoAndStop(1);
         _requestBtn4MC.mouseEnabled = false;
         _requestBtn4MC.mouseChildren = false;
         _requestBtn4MC.x = 327;
         _requestBtn4MC.y = 9;
         _requestBtn4MC.visible = false;
         addChild(_requestBtn1MC);
         addChild(_requestBtn2MC);
         addChild(_requestBtn3MC);
         addChild(_requestBtn4MC);
      }
      
      private function initBtnState() : void
      {
         if(BeadModel.beadRequestBtnIndex > 0)
         {
            buttonState(BeadModel.beadRequestBtnIndex);
         }
      }
      
      private function initEvent() : void
      {
         _requestBtn1.addEventListener("click",__requestClick);
         _requestBtn2.addEventListener("click",__requestClick);
         _requestBtn3.addEventListener("click",__requestClick);
         _requestBtn4.addEventListener("click",__requestClick);
         _autoOpenBeadCheckBtn.addEventListener("select",__autoCheck);
         _autoOpenBeadCheckBtn.addEventListener("click",__onAutoBtnClick);
         this.addEventListener("unSelectAutoOpenBtn",__onOpenBeadAlertCancelled);
         beadSystemManager.Instance.addEventListener("autoOpenBead",__onViewIndexChanged);
         KingBlessManager.instance.addEventListener("update_buff_data_event",refreshFreeTipTxt);
         KingBlessManager.instance.addEventListener("update_main_event",refreshFreeTipTxt);
      }
      
      private function refreshFreeTipTxt(event:Event) : void
      {
         var freeCount:int = KingBlessManager.instance.getOneBuffData(3);
         if(freeCount > 0)
         {
            _freeTipTxt.text = LanguageMgr.GetTranslation("ddt.beadSystem.getBeadView.freeGetTipTxt",freeCount);
            _freeTipTxt.visible = true;
         }
         else
         {
            _freeTipTxt.visible = false;
         }
      }
      
      private function __onOpenBeadAlertCancelled(pEvent:Event) : void
      {
         _isSelectAutoCheck = false;
         _autoOpenBeadCheckBtn.selected = false;
      }
      
      private function removeEvent() : void
      {
         _requestBtn1.removeEventListener("click",__requestClick);
         _requestBtn2.removeEventListener("click",__requestClick);
         _requestBtn3.removeEventListener("click",__requestClick);
         _requestBtn4.removeEventListener("click",__requestClick);
         _autoOpenBeadCheckBtn.removeEventListener("select",__autoCheck);
         _autoOpenBeadCheckBtn.removeEventListener("click",__onAutoBtnClick);
         this.removeEventListener("unSelectAutoOpenBtn",__onOpenBeadAlertCancelled);
         beadSystemManager.Instance.removeEventListener("autoOpenBead",__onViewIndexChanged);
         KingBlessManager.instance.removeEventListener("update_buff_data_event",refreshFreeTipTxt);
         KingBlessManager.instance.removeEventListener("update_main_event",refreshFreeTipTxt);
      }
      
      private function __onViewIndexChanged(pEvent:BeadEvent) : void
      {
         if(pEvent.CellId == 3)
         {
            removeTimer();
         }
      }
      
      private function __onAutoBtnClick(pEvent:MouseEvent) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            _autoOpenBeadCheckBtn.selected = false;
            return;
         }
      }
      
      private function __autoCheck(pEvent:Event) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            return;
         }
         if(_autoOpenBeadCheckBtn.selected)
         {
            if(!_isBand && PlayerManager.Instance.Self.Money < ServerConfigManager.instance.getRequestBeadPrice()[getMaxRequestBtn()] && KingBlessManager.instance.getOneBuffData(3) <= 0)
            {
               if(!_alertCharge)
               {
                  _alertCharge = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("poorNote"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
                  _alertCharge.moveEnable = false;
                  _alertCharge.addEventListener("response",__poorManResponse);
                  _autoOpenBeadCheckBtn.selected = false;
                  return;
               }
            }
            else if(_isBand && PlayerManager.Instance.Self.BandMoney < ServerConfigManager.instance.getRequestBeadPrice()[getMaxRequestBtn()] && KingBlessManager.instance.getOneBuffData(3) <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.transfer.StoreIITransferBG.lijinbuzu"));
               _autoOpenBeadCheckBtn.selected = false;
               return;
            }
            _alertConfirm = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("ddt.beadSystem.autoOpenBeadAlertTip"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            _alertConfirm.addEventListener("response",__onAutoOpenResponse);
         }
         else if(!_autoOpenBeadCheckBtn.selected && _isSelectAutoCheck)
         {
            removeTimer();
         }
      }
      
      private function __onAutoOpenResponse(pEvent:FrameEvent) : void
      {
         _alertConfirm.removeEventListener("response",__onAutoOpenResponse);
         switch(int(pEvent.responseCode))
         {
            case 0:
            case 1:
               dispatchEvent(new Event("unSelectAutoOpenBtn"));
               break;
            case 2:
            case 3:
            case 4:
               addTimer();
               _isSelectAutoCheck = true;
               beadSystemManager.Instance.dispatchEvent(new BeadEvent("autoOpenBead",1));
         }
         ObjectUtils.disposeObject(_alertConfirm);
         _alertConfirm = null;
      }
      
      private function __requestClick(pEvent:MouseEvent) : void
      {
         if(!_isSelectAutoCheck)
         {
            SoundManager.instance.play("008");
            vBtn = pEvent.currentTarget as SimpleBitmapButton;
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            if(KingBlessManager.instance.getOneBuffData(3) > 0)
            {
               SocketManager.Instance.out.sendOpenBead(int(vBtn.tipData),_isBand);
               return;
            }
            CheckMoneyUtils.instance.checkMoney(_isBand,ServerConfigManager.instance.getRequestBeadPrice()[int(vBtn.tipData)],onCheckComplete);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.beadSystem.autoOpenBeadTip"));
         }
      }
      
      protected function onCheckComplete() : void
      {
         SocketManager.Instance.out.sendOpenBead(int(vBtn.tipData),CheckMoneyUtils.instance.isBind);
      }
      
      private function __poorManResponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _alertCharge.removeEventListener("response",__poorManResponse);
         if(event.responseCode == 3 || event.responseCode == 2)
         {
            dispatchEvent(new Event("unSelectAutoOpenBtn"));
            LeavePageManager.leaveToFillPath();
         }
         else
         {
            dispatchEvent(new Event("unSelectAutoOpenBtn"));
         }
         ObjectUtils.disposeObject(_alertCharge);
         _alertCharge = null;
      }
      
      public function buttonState(pIndex:int) : void
      {
         if((pIndex & 1) == 1)
         {
            _requestBtn2.enable = true;
            _requestBtn2MC.visible = true;
         }
         else
         {
            _requestBtn2.enable = false;
            _requestBtn2MC.visible = false;
         }
         if((pIndex & 2) > 0)
         {
            _requestBtn3.enable = true;
            _requestBtn3MC.visible = true;
         }
         else
         {
            _requestBtn3.enable = false;
            _requestBtn3MC.visible = false;
         }
         if((pIndex & 4) > 0)
         {
            _requestBtn4.enable = true;
            _requestBtn4MC.visible = true;
         }
         else
         {
            _requestBtn4.enable = false;
            _requestBtn4MC.visible = false;
         }
         _isServerReplied = true;
      }
      
      private function addTimer() : void
      {
         if(!_autoOpenBeadTimer)
         {
            _autoOpenBeadTimer = TimerManager.getInstance().addTimerJuggler(1000);
         }
         _autoOpenBeadTimer.addEventListener("timer",__onAutoOpen);
         _autoOpenBeadTimer.start();
      }
      
      public function removeTimer() : void
      {
         if(_autoOpenBeadTimer)
         {
            _autoOpenBeadTimer.stop();
            _autoOpenBeadTimer.removeEventListener("timer",__onAutoOpen);
            TimerManager.getInstance().removeTimerJuggler(_autoOpenBeadTimer.id);
         }
         _autoOpenBeadTimer = null;
         dispatchEvent(new Event("unSelectAutoOpenBtn"));
         beadSystemManager.Instance.dispatchEvent(new BeadEvent("autoOpenBead",0));
      }
      
      private function __onAutoOpen(pEvent:Event) : void
      {
         autoOpenBead();
      }
      
      private function autoOpenBead() : void
      {
         if(!_isBand && PlayerManager.Instance.Self.Money >= ServerConfigManager.instance.getRequestBeadPrice()[getMaxRequestBtn()] || _isBand && PlayerManager.Instance.Self.BandMoney >= ServerConfigManager.instance.getRequestBeadPrice()[getMaxRequestBtn()] || KingBlessManager.instance.getOneBuffData(3) > 0)
         {
            if(_isServerReplied || _isFirst)
            {
               SoundManager.instance.play("008");
               SocketManager.Instance.out.sendOpenBead(getMaxRequestBtn(),_isBand);
               _isServerReplied = false;
               _isFirst = false;
            }
            return;
         }
         removeTimer();
         if(!_isBand)
         {
            if(!_alertCharge)
            {
               _alertCharge = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("poorNote"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
               _alertCharge.moveEnable = false;
               _alertCharge.addEventListener("response",__poorManResponse);
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.transfer.StoreIITransferBG.lijinbuzu"));
         }
      }
      
      private function getMaxRequestBtn() : int
      {
         var result:int = 0;
         if(_requestBtn4MC.visible)
         {
            result = 3;
         }
         else if(_requestBtn3MC.visible)
         {
            result = 2;
         }
         else if(_requestBtn2MC.visible)
         {
            result = 1;
         }
         else if(_requestBtn1MC.visible)
         {
            result = 0;
         }
         return result;
      }
      
      public function dispose() : void
      {
         removeEvent();
         removeTimer();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_requestBtn1)
         {
            ObjectUtils.disposeObject(_requestBtn1);
         }
         _requestBtn1 = null;
         if(_requestBtn2)
         {
            ObjectUtils.disposeObject(_requestBtn1);
         }
         _requestBtn1 = null;
         if(_requestBtn3)
         {
            ObjectUtils.disposeObject(_requestBtn1);
         }
         _requestBtn1 = null;
         if(_requestBtn4)
         {
            ObjectUtils.disposeObject(_requestBtn1);
         }
         _requestBtn1 = null;
         if(_requestBtn1MC)
         {
            ObjectUtils.disposeObject(_requestBtn1MC);
         }
         _requestBtn1MC = null;
         if(_requestBtn2MC)
         {
            ObjectUtils.disposeObject(_requestBtn2MC);
         }
         _requestBtn2MC = null;
         if(_requestBtn3MC)
         {
            ObjectUtils.disposeObject(_requestBtn3MC);
         }
         _requestBtn3MC = null;
         if(_requestBtn4MC)
         {
            ObjectUtils.disposeObject(_requestBtn4MC);
         }
         _requestBtn4MC = null;
         if(_autoOpenBeadCheckBtn)
         {
            ObjectUtils.disposeObject(_autoOpenBeadCheckBtn);
         }
         _autoOpenBeadCheckBtn = null;
         if(_titleBmp)
         {
            ObjectUtils.disposeObject(_titleBmp);
         }
         _titleBmp = null;
         ObjectUtils.disposeObject(_freeTipTxt);
         _freeTipTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
