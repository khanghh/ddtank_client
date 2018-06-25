package consortionBattle.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import consortionBattle.ConsortiaBattleManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class ConsBatTwoBtnView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _bg2:Bitmap;
      
      private var _powerFullBtn:SimpleBitmapButton;
      
      private var _doubleScoreBtn:SimpleBitmapButton;
      
      private var _powerFullSprite:SimpleBitmapButton;
      
      private var _doubleScoreSprite:SimpleBitmapButton;
      
      private var _autoBuyBtn:SelectedCheckButton;
      
      private var _lastPowerFullClickTime:int = 0;
      
      public function ConsBatTwoBtnView()
      {
         super();
         this.x = 380;
         this.y = 35;
         initView();
         initEvent();
         refreshView();
         if(ConsortiaBattleManager.instance.isAutoPowerFull)
         {
            _autoBuyBtn.selected = true;
            autoBuyPowerFull();
         }
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.consortiaBattle.twoBtnBg");
         _bg2 = ComponentFactory.Instance.creatBitmap("asset.consortiaBattle.twoBtnBg2");
         _powerFullBtn = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.powerFull");
         _powerFullBtn.tipData = LanguageMgr.GetTranslation("ddt.consortiaBattle.powerFullBtn.tipTxt");
         _doubleScoreBtn = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.doubleScoreBtn");
         _doubleScoreBtn.tipData = LanguageMgr.GetTranslation("ddt.consortiaBattle.doubleScoreBtn.tipTxt");
         _powerFullSprite = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.powerFull");
         _powerFullSprite.tipData = LanguageMgr.GetTranslation("ddt.consortiaBattle.powerFullBtn.tipTxt");
         _powerFullSprite.alpha = 0;
         _powerFullSprite.buttonMode = false;
         _doubleScoreSprite = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.doubleScoreBtn");
         _doubleScoreSprite.tipData = LanguageMgr.GetTranslation("ddt.consortiaBattle.doubleScoreBtn.tipTxt");
         _doubleScoreSprite.alpha = 0;
         _doubleScoreSprite.buttonMode = false;
         _autoBuyBtn = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.autoBuyPowerFull");
         _autoBuyBtn.tipData = LanguageMgr.GetTranslation("ddt.consortiaBattle.autoBuyPowerFullBtnTipTxt");
         addChild(_bg);
         addChild(_bg2);
         addChild(_powerFullBtn);
         addChild(_doubleScoreBtn);
         addChild(_powerFullSprite);
         addChild(_doubleScoreSprite);
         addChild(_autoBuyBtn);
      }
      
      private function refreshView(event:Event = null) : void
      {
         if(ConsortiaBattleManager.instance.isPowerFullUsed)
         {
            _powerFullBtn.enable = false;
            _powerFullSprite.visible = true;
         }
         else
         {
            _powerFullBtn.enable = true;
            _powerFullSprite.visible = false;
         }
         if(ConsortiaBattleManager.instance.isDoubleScoreUsed)
         {
            _doubleScoreBtn.enable = false;
            _doubleScoreSprite.visible = true;
         }
         else
         {
            _doubleScoreBtn.enable = true;
            _doubleScoreSprite.visible = false;
         }
      }
      
      private function initEvent() : void
      {
         _powerFullBtn.addEventListener("click",powerFullHandler,false,0,true);
         _doubleScoreBtn.addEventListener("click",doubleScoreHandler,false,0,true);
         _autoBuyBtn.addEventListener("click",autoClickHandler,false,0,true);
         ConsortiaBattleManager.instance.addEventListener("consortiaBattleUpdateSceneInfo",refreshView);
      }
      
      private function autoClickHandler(event:MouseEvent) : void
      {
         var confirmFrame:* = null;
         if(!_autoBuyBtn.selected)
         {
            confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.consortiaBattle.autoBuyPowerFullTipTxt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
            confirmFrame.moveEnable = false;
            confirmFrame.addEventListener("response",__autoBuyConfirm,false,0,true);
         }
         else
         {
            _autoBuyBtn.selected = false;
            ConsortiaBattleManager.instance.isAutoPowerFull = false;
         }
      }
      
      private function __autoBuyConfirm(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",__autoBuyConfirm);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            _autoBuyBtn.selected = true;
            ConsortiaBattleManager.instance.isAutoPowerFull = true;
            autoBuyPowerFull();
         }
      }
      
      private function autoBuyPowerFull() : void
      {
         if(!ConsortiaBattleManager.instance.isPowerFullUsed)
         {
            if(PlayerManager.Instance.Self.BandMoney >= 100)
            {
               SocketManager.Instance.out.sendConsBatConsume(1,true);
            }
            else if(PlayerManager.Instance.Self.Money >= 100)
            {
               SocketManager.Instance.out.sendConsBatConsume(1,false);
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortiaBattle.autoBuyPowerFullNoEnoughMoney"),0,true);
               _autoBuyBtn.selected = false;
               ConsortiaBattleManager.instance.isAutoPowerFull = false;
            }
         }
      }
      
      private function powerFullHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(getTimer() - _lastPowerFullClickTime <= 1000)
         {
            return;
         }
         _lastPowerFullClickTime = getTimer();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var tmpObj:Object = ConsortiaBattleManager.instance.getBuyRecordStatus(0);
         if(tmpObj.isNoPrompt)
         {
            if(tmpObj.isBand && PlayerManager.Instance.Self.BandMoney < 30)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortiaBattle.buy.noEnoughBindMoneyTxt"));
               tmpObj.isNoPrompt = false;
            }
            else if(!tmpObj.isBand && PlayerManager.Instance.Self.Money < 30)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortiaBattle.buy.noEnoughMoneyTxt"));
               tmpObj.isNoPrompt = false;
            }
            else
            {
               SocketManager.Instance.out.sendConsBatConsume(1,tmpObj.isBand);
               return;
            }
         }
         var confirmFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.consortiaBattle.buyPowerFull.promptTxt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"ConsBatBuyConfirmView",30,true,1,-15);
         confirmFrame.moveEnable = false;
         confirmFrame.addEventListener("response",__powerFullConfirm,false,0,true);
      }
      
      private function __powerFullConfirm(evt:FrameEvent) : void
      {
         var tmpObj:* = null;
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",__powerFullConfirm);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            if(confirmFrame.isBand && PlayerManager.Instance.Self.BandMoney < 30)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortiaBattle.buy.noEnoughBindMoneyTxt"));
               return;
            }
            if(!confirmFrame.isBand && PlayerManager.Instance.Self.Money < 30)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            if((confirmFrame as ConsBatBuyConfirmView).isNoPrompt)
            {
               tmpObj = ConsortiaBattleManager.instance.getBuyRecordStatus(0);
               tmpObj.isNoPrompt = true;
               tmpObj.isBand = confirmFrame.isBand;
            }
            SocketManager.Instance.out.sendConsBatConsume(1,confirmFrame.isBand);
         }
      }
      
      private function doubleScoreHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var confirmFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.consortiaBattle.buyDoubleScore.promptTxt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"SimpleAlert",30,true,1);
         confirmFrame.moveEnable = false;
         confirmFrame.addEventListener("response",__doubleScoreConfirm,false,0,true);
      }
      
      private function __doubleScoreConfirm(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",__doubleScoreConfirm);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            if(confirmFrame.isBand && PlayerManager.Instance.Self.BandMoney < 300)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortiaBattle.buy.noEnoughBindMoneyTxt"));
               return;
            }
            if(!confirmFrame.isBand && PlayerManager.Instance.Self.Money < 300)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.sendConsBatConsume(2,confirmFrame.isBand);
         }
      }
      
      private function removeEvent() : void
      {
         if(_powerFullBtn)
         {
            _powerFullBtn.removeEventListener("click",powerFullHandler);
         }
         if(_doubleScoreBtn)
         {
            _doubleScoreBtn.removeEventListener("click",doubleScoreHandler);
         }
         if(_autoBuyBtn)
         {
            _autoBuyBtn.removeEventListener("click",autoClickHandler);
         }
         ConsortiaBattleManager.instance.removeEventListener("consortiaBattleUpdateSceneInfo",refreshView);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _bg2 = null;
         _powerFullBtn = null;
         _doubleScoreBtn = null;
         _autoBuyBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
