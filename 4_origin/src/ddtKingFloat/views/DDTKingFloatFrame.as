package ddtKingFloat.views
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
   import ddtKingFloat.DDTKingFloatIconManager;
   import ddtKingFloat.DDTKingFloatManager;
   import ddtKingFloat.data.DDTKingFloatInfoVo;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import invite.InviteManager;
   
   public class DDTKingFloatFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _bottomBg:ScaleBitmapImage;
      
      private var _cellList:Vector.<DDTKingFloatFrameItemCell>;
      
      private var _btn:SimpleBitmapButton;
      
      private var _countTxt:FilterFrameText;
      
      private var _helpBtn:DDTKingFloatHelpBtn;
      
      private var _doubleTagIcon:Bitmap;
      
      private var _matchView:DDTKingFloatMatchView;
      
      public function DDTKingFloatFrame()
      {
         super();
         InviteManager.Instance.enabled = false;
         _cellList = new Vector.<DDTKingFloatFrameItemCell>();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var data:* = null;
         var tmp:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("ddtKing.bg");
         _bg.x = -32;
         _bg.y = -102;
         addToContent(_bg);
         for(i = 0; i < 3; )
         {
            data = DDTKingFloatManager.instance.dataInfo;
            tmp = new DDTKingFloatFrameItemCell(i,DDTKingFloatManager.instance.dataInfo.carInfo[i]);
            tmp.x = 8 + (tmp.width - 2) * i;
            tmp.y = 10;
            addToContent(tmp);
            _cellList.push(tmp);
            i++;
         }
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("ddtKing.race.countTxt");
         refreshEnterCountHandler(null);
         addToContent(_countTxt);
         _helpBtn = new DDTKingFloatHelpBtn(false);
         addToContent(_helpBtn);
         _doubleTagIcon = ComponentFactory.Instance.creatBitmap("ddtKing.doubleScoreIcon");
         addToContent(_doubleTagIcon);
         refreshDoubleTagIcon();
      }
      
      private function refreshDoubleTagIcon() : void
      {
         if(DDTKingFloatManager.instance.isInDoubleTime)
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
         DDTKingFloatManager.instance.addEventListener("floatParadeStartGame",startGameHandler);
         DDTKingFloatManager.instance.addEventListener("floatParadeEnterGame",enterGameHandler);
         DDTKingFloatIconManager.instance.addEventListener("floatParadeEnd",endHandler);
         DDTKingFloatManager.instance.addEventListener("floatParadeRefreshEnterCount",refreshEnterCountHandler);
      }
      
      private function refreshEnterCountHandler(event:Event) : void
      {
         if(_btn)
         {
            _btn.removeEventListener("click",clickHandler);
            ObjectUtils.disposeObject(_btn);
         }
         var tmpFreeCount:int = DDTKingFloatManager.instance.freeCount;
         _btn = ComponentFactory.Instance.creatComponentByStylename("ddtKing.race.startBtn");
         addToContent(_btn);
         _countTxt.text = "(" + tmpFreeCount + ")";
         if(tmpFreeCount <= 0)
         {
            _btn.enable = false;
         }
      }
      
      private function endHandler(event:Event) : void
      {
         SocketManager.Instance.out.sendEscortCancelGame();
         dispose();
      }
      
      private function enterGameHandler(event:Event) : void
      {
         dispose();
         DDTKingFloatManager.instance.enterGame();
      }
      
      private function startGameHandler(event:Event) : void
      {
         _matchView = ComponentFactory.Instance.creatComponentByStylename("ddtking.matchView");
         LayerManager.Instance.addToLayer(_matchView,2,true,2);
      }
      
      private function clickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(DDTKingFloatManager.instance.freeCount > 0)
         {
            SocketManager.Instance.out.sendUpdateSysDate();
            SocketManager.Instance.out.sendEscortStartGame(false);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddtKing.noEnoughUsableCount"));
         }
         _btn.enable = false;
         return;
         §§push(setTimeout(enableBtn,5000));
      }
      
      private function enableBtn() : void
      {
         if(_btn)
         {
            _btn.enable = true;
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
            tmpNeedMoney = DDTKingFloatManager.instance.startGameNeedMoney;
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
            if((confirmFrame as DDTKingFloatBuyConfirmView).isNoPrompt)
            {
               tmpObj = DDTKingFloatManager.instance.getBuyRecordStatus(1);
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
            needMoney = DDTKingFloatManager.instance.startGameNeedMoney;
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
         DDTKingFloatManager.instance.removeEventListener("floatParadeStartGame",startGameHandler);
         DDTKingFloatManager.instance.removeEventListener("floatParadeEnterGame",enterGameHandler);
         DDTKingFloatIconManager.instance.removeEventListener("floatParadeEnd",endHandler);
         DDTKingFloatManager.instance.removeEventListener("floatParadeRefreshEnterCount",refreshEnterCountHandler);
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
