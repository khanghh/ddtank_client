package sevenDouble.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
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
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import sevenDouble.SevenDoubleControl;
   import sevenDouble.SevenDoubleManager;
   
   public class SevenDoubleFrame extends Frame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _bottomBg:ScaleBitmapImage;
      
      private var _cellList:Vector.<SevenDoubleFrameItemCell>;
      
      private var _btn:SimpleBitmapButton;
      
      private var _countTxt:FilterFrameText;
      
      private var _matchView:SevenDoubleMatchView;
      
      private var _helpBtn:SevenDoubleHelpBtn;
      
      private var _doubleTagIcon:Bitmap;
      
      public function SevenDoubleFrame()
      {
         super();
         _cellList = new Vector.<SevenDoubleFrameItemCell>();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var tmp:* = null;
         titleText = LanguageMgr.GetTranslation("sevenDouble.frame.titleTxt");
         _bg = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.frame.bg");
         addToContent(_bg);
         _bottomBg = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.frame.bottomBg");
         addToContent(_bottomBg);
         for(i = 0; i < 3; )
         {
            tmp = new SevenDoubleFrameItemCell(i,SevenDoubleControl.instance.dataInfo.carInfo[i]);
            tmp.x = 8 + (tmp.width + 4) * i;
            tmp.y = 10;
            addToContent(tmp);
            _cellList.push(tmp);
            i++;
         }
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.frame.countTxt");
         refreshEnterCountHandler(null);
         addToContent(_countTxt);
         _helpBtn = new SevenDoubleHelpBtn(false);
         addToContent(_helpBtn);
         _doubleTagIcon = ComponentFactory.Instance.creatBitmap("asset.sevenDouble.doubleScoreIcon");
         addToContent(_doubleTagIcon);
         refreshDoubleTagIcon();
      }
      
      private function refreshDoubleTagIcon() : void
      {
         if(SevenDoubleControl.instance.isInDoubleTime)
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
         SevenDoubleManager.instance.addEventListener("sevenDoubleStartGame",startGameHandler);
         SevenDoubleManager.instance.addEventListener("sevenDoubleEnterGame",enterGameHandler);
         SevenDoubleManager.instance.addEventListener("sevenDoubleEnd",endHandler);
         SevenDoubleManager.instance.addEventListener("sevenDoubleRefreshEnterCount",refreshEnterCountHandler);
      }
      
      private function refreshEnterCountHandler(event:Event) : void
      {
         var tmpCount:* = 0;
         if(_btn)
         {
            _btn.removeEventListener("click",clickHandler);
            ObjectUtils.disposeObject(_btn);
         }
         var tmpFreeCount:int = SevenDoubleControl.instance.freeCount;
         if(tmpFreeCount > 0)
         {
            _btn = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.frame.freeBtn");
            tmpCount = tmpFreeCount;
         }
         else
         {
            _btn = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.frame.startBtn");
            tmpCount = int(SevenDoubleControl.instance.usableCount);
         }
         addToContent(_btn);
         _countTxt.text = "(" + tmpCount + ")";
      }
      
      private function endHandler(event:Event) : void
      {
         SocketManager.Instance.out.sendSevenDoubleCancelGame();
         dispose();
      }
      
      private function enterGameHandler(event:Event) : void
      {
         dispose();
         StateManager.setState("sevenDoubleScene");
      }
      
      private function startGameHandler(event:Event) : void
      {
         _matchView = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.frame.matchView");
         _matchView.show();
         _matchView.addEventListener("response",cancelMatchHandler,false,0,true);
      }
      
      private function cancelMatchHandler(event:FrameEvent) : void
      {
         if(event.responseCode == 1 || event.responseCode == 4 || event.responseCode == 0)
         {
            SoundManager.instance.play("008");
            SocketManager.Instance.out.sendSevenDoubleCancelGame();
            disposeMatchView();
         }
      }
      
      private function disposeMatchView() : void
      {
         if(_matchView)
         {
            _matchView.removeEventListener("response",cancelMatchHandler);
            ObjectUtils.disposeObject(_matchView);
            _matchView = null;
         }
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
         if(SevenDoubleControl.instance.freeCount > 0)
         {
            SocketManager.Instance.out.sendSevenDoubleStartGame(false);
         }
         else
         {
            if(SevenDoubleControl.instance.usableCount <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("sevenDouble.noEnoughUsableCount"));
               return;
            }
            tmpNeedMoney = SevenDoubleControl.instance.startGameNeedMoney;
            tmpObj = SevenDoubleControl.instance.getBuyRecordStatus(1);
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
                  SocketManager.Instance.out.sendSevenDoubleStartGame(tmpObj.isBand);
                  return;
               }
            }
            confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("sevenDouble.frame.startGameConfirmTxt",tmpNeedMoney),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"SevenDoubleBuyConfirmView",30,true,1);
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
            tmpNeedMoney = SevenDoubleControl.instance.startGameNeedMoney;
            if(confirmFrame.isBand && PlayerManager.Instance.Self.BandMoney < tmpNeedMoney)
            {
               confirmFrame2 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("sevenDouble.game.useSkillNoEnoughReConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
               confirmFrame2.moveEnable = false;
               confirmFrame2.addEventListener("response",startGameReConfirm,false,0,true);
               return;
            }
            if(!confirmFrame.isBand && PlayerManager.Instance.Self.Money < tmpNeedMoney)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            if((confirmFrame as SevenDoubleBuyConfirmView).isNoPrompt)
            {
               tmpObj = SevenDoubleControl.instance.getBuyRecordStatus(1);
               tmpObj.isNoPrompt = true;
               tmpObj.isBand = confirmFrame.isBand;
            }
            SocketManager.Instance.out.sendSevenDoubleStartGame(confirmFrame.isBand);
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
            needMoney = SevenDoubleControl.instance.startGameNeedMoney;
            if(PlayerManager.Instance.Self.Money < needMoney)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.sendSevenDoubleStartGame(false);
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
         SevenDoubleManager.instance.removeEventListener("sevenDoubleStartGame",startGameHandler);
         SevenDoubleManager.instance.removeEventListener("sevenDoubleEnterGame",enterGameHandler);
         SevenDoubleManager.instance.removeEventListener("sevenDoubleEnd",endHandler);
         SevenDoubleManager.instance.removeEventListener("sevenDoubleRefreshEnterCount",refreshEnterCountHandler);
      }
      
      override public function dispose() : void
      {
         disposeMatchView();
         removeEvent();
         super.dispose();
         _bg = null;
         _bottomBg = null;
         _cellList = null;
         _btn = null;
         _countTxt = null;
         _helpBtn = null;
         _doubleTagIcon = null;
      }
   }
}
