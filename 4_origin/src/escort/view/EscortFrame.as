package escort.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import escort.EscortControl;
   import escort.EscortManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import invite.InviteManager;
   
   public class EscortFrame extends Frame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _bottomBg:ScaleBitmapImage;
      
      private var _cellList:Vector.<EscortFrameItemCell>;
      
      private var _btn:SimpleBitmapButton;
      
      private var _countTxt:FilterFrameText;
      
      private var _helpBtn:EscortHelpBtn;
      
      private var _doubleTagIcon:Bitmap;
      
      private var _matchView:EscortMatchView;
      
      public function EscortFrame()
      {
         super();
         InviteManager.Instance.enabled = false;
         _cellList = new Vector.<EscortFrameItemCell>();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var tmp:* = null;
         titleText = LanguageMgr.GetTranslation("escort.frame.titleTxt");
         _bg = ComponentFactory.Instance.creatComponentByStylename("escort.frame.bg");
         addToContent(_bg);
         _bottomBg = ComponentFactory.Instance.creatComponentByStylename("escort.frame.bottomBg");
         addToContent(_bottomBg);
         for(i = 0; i < 3; )
         {
            tmp = new EscortFrameItemCell(i,EscortControl.instance.dataInfo.carInfo[i]);
            tmp.x = 8 + (tmp.width + 4) * i;
            tmp.y = 10;
            addToContent(tmp);
            _cellList.push(tmp);
            i++;
         }
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("escort.frame.countTxt");
         refreshEnterCountHandler(null);
         addToContent(_countTxt);
         _helpBtn = new EscortHelpBtn(false);
         addToContent(_helpBtn);
         _doubleTagIcon = ComponentFactory.Instance.creatBitmap("asset.escort.doubleScoreIcon");
         addToContent(_doubleTagIcon);
         refreshDoubleTagIcon();
      }
      
      private function refreshDoubleTagIcon() : void
      {
         if(EscortControl.instance.isInDoubleTime)
         {
            _doubleTagIcon.visible = true;
         }
         else
         {
            _doubleTagIcon.visible = false;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _btn.addEventListener("click",clickHandler,false,0,true);
         EscortManager.instance.addEventListener("escortStartGame",startGameHandler);
         EscortManager.instance.addEventListener("escortEnterGame",enterGameHandler);
         EscortManager.instance.addEventListener("escortEnd",endHandler);
         EscortManager.instance.addEventListener("escortRefreshEnterCount",refreshEnterCountHandler);
      }
      
      private function refreshEnterCountHandler(event:Event) : void
      {
         var tmpCount:* = 0;
         if(_btn)
         {
            _btn.removeEventListener("click",clickHandler);
            ObjectUtils.disposeObject(_btn);
         }
         var tmpFreeCount:int = EscortControl.instance.freeCount;
         if(tmpFreeCount > 0)
         {
            _btn = ComponentFactory.Instance.creatComponentByStylename("escort.frame.freeBtn");
            tmpCount = tmpFreeCount;
         }
         else
         {
            _btn = ComponentFactory.Instance.creatComponentByStylename("escort.frame.startBtn");
            tmpCount = int(EscortControl.instance.usableCount);
         }
         addToContent(_btn);
         _countTxt.text = "(" + tmpCount + ")";
      }
      
      private function endHandler(event:Event) : void
      {
         SocketManager.Instance.out.sendEscortCancelGame();
         dispose();
      }
      
      private function enterGameHandler(event:Event) : void
      {
         dispose();
         StateManager.setState("escort");
      }
      
      private function startGameHandler(event:Event) : void
      {
         _matchView = ComponentFactory.Instance.creatComponentByStylename("escort.frame.matchView");
         LayerManager.Instance.addToLayer(_matchView,2,true,2);
      }
      
      private function clickHandler(event:MouseEvent) : void
      {
         var tmpNeedMoney:int = 0;
         var tmpObj:* = null;
         var confirmFrame:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(EscortControl.instance.freeCount > 0)
         {
            SocketManager.Instance.out.sendEscortStartGame(false);
         }
         else
         {
            if(EscortControl.instance.usableCount <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("escort.noEnoughUsableCount"));
               return;
            }
            tmpNeedMoney = EscortControl.instance.startGameNeedMoney;
            tmpObj = EscortControl.instance.getBuyRecordStatus(1);
            if(tmpObj.isNoPrompt)
            {
               if(tmpObj.isBand && PlayerManager.Instance.Self.BandMoney < tmpNeedMoney)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("bindMoneyPoorNote"));
                  tmpObj.isNoPrompt = false;
               }
               else if(!tmpObj.isBand && PlayerManager.Instance.Self.Money < tmpNeedMoney)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("moneyPoorNote"));
                  tmpObj.isNoPrompt = false;
               }
               else
               {
                  SocketManager.Instance.out.sendEscortStartGame(tmpObj.isBand);
                  return;
               }
            }
            confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("escort.frame.startGameConfirmTxt",tmpNeedMoney),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"EscortBuyConfirmView",30,true);
            confirmFrame.moveEnable = false;
            confirmFrame.addEventListener("response",startConfirm,false,0,true);
         }
      }
      
      private function startConfirm(evt:FrameEvent) : void
      {
         var tmpNeedMoney:int = 0;
         var confirmFrame2:* = null;
         var tmpObj:* = null;
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",startConfirm);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            tmpNeedMoney = EscortControl.instance.startGameNeedMoney;
            if(confirmFrame.isBand && PlayerManager.Instance.Self.BandMoney < tmpNeedMoney)
            {
               confirmFrame2 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("escort.game.useSkillNoEnoughReConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
               confirmFrame2.moveEnable = false;
               confirmFrame2.addEventListener("response",startGameReConfirm,false,0,true);
               return;
            }
            if(!confirmFrame.isBand && PlayerManager.Instance.Self.Money < tmpNeedMoney)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            if((confirmFrame as EscortBuyConfirmView).isNoPrompt)
            {
               tmpObj = EscortControl.instance.getBuyRecordStatus(1);
               tmpObj.isNoPrompt = true;
               tmpObj.isBand = confirmFrame.isBand;
            }
            SocketManager.Instance.out.sendEscortStartGame(confirmFrame.isBand);
         }
      }
      
      private function startGameReConfirm(evt:FrameEvent) : void
      {
         var needMoney:int = 0;
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",startGameReConfirm);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            needMoney = EscortControl.instance.startGameNeedMoney;
            if(PlayerManager.Instance.Self.Money < needMoney)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.sendEscortStartGame(false);
         }
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_btn)
         {
            _btn.removeEventListener("click",clickHandler);
         }
         EscortManager.instance.removeEventListener("escortStartGame",startGameHandler);
         EscortManager.instance.removeEventListener("escortEnterGame",enterGameHandler);
         EscortManager.instance.removeEventListener("escortEnd",endHandler);
         EscortManager.instance.removeEventListener("escortRefreshEnterCount",refreshEnterCountHandler);
      }
      
      override public function dispose() : void
      {
         InviteManager.Instance.enabled = true;
         removeEvent();
         super.dispose();
         _bg = null;
         _bottomBg = null;
         _cellList = null;
         _btn = null;
         _countTxt = null;
         _helpBtn = null;
         _doubleTagIcon = null;
         ObjectUtils.disposeObject(_matchView);
         _matchView = null;
      }
   }
}
