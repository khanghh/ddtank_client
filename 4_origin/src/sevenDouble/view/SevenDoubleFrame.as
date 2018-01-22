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
         var _loc2_:int = 0;
         var _loc1_:* = null;
         titleText = LanguageMgr.GetTranslation("sevenDouble.frame.titleTxt");
         _bg = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.frame.bg");
         addToContent(_bg);
         _bottomBg = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.frame.bottomBg");
         addToContent(_bottomBg);
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new SevenDoubleFrameItemCell(_loc2_,SevenDoubleControl.instance.dataInfo.carInfo[_loc2_]);
            _loc1_.x = 8 + (_loc1_.width + 4) * _loc2_;
            _loc1_.y = 10;
            addToContent(_loc1_);
            _cellList.push(_loc1_);
            _loc2_++;
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
      
      private function refreshEnterCountHandler(param1:Event) : void
      {
         var _loc3_:* = 0;
         if(_btn)
         {
            _btn.removeEventListener("click",clickHandler);
            ObjectUtils.disposeObject(_btn);
         }
         var _loc2_:int = SevenDoubleControl.instance.freeCount;
         if(_loc2_ > 0)
         {
            _btn = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.frame.freeBtn");
            _loc3_ = _loc2_;
         }
         else
         {
            _btn = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.frame.startBtn");
            _loc3_ = int(SevenDoubleControl.instance.usableCount);
         }
         addToContent(_btn);
         _countTxt.text = "(" + _loc3_ + ")";
      }
      
      private function endHandler(param1:Event) : void
      {
         SocketManager.Instance.out.sendSevenDoubleCancelGame();
         dispose();
      }
      
      private function enterGameHandler(param1:Event) : void
      {
         dispose();
         StateManager.setState("sevenDoubleScene");
      }
      
      private function startGameHandler(param1:Event) : void
      {
         _matchView = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.frame.matchView");
         _matchView.show();
         _matchView.addEventListener("response",cancelMatchHandler,false,0,true);
      }
      
      private function cancelMatchHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 1 || param1.responseCode == 4 || param1.responseCode == 0)
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
      
      private function clickHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc4_:* = null;
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
            _loc3_ = SevenDoubleControl.instance.startGameNeedMoney;
            _loc2_ = SevenDoubleControl.instance.getBuyRecordStatus(1);
            if(_loc2_.isNoPrompt)
            {
               if(_loc2_.isBand && PlayerManager.Instance.Self.BandMoney < _loc3_)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("bindMoneyPoorNote"));
                  _loc2_.isNoPrompt = false;
               }
               else if(!_loc2_.isBand && PlayerManager.Instance.Self.Money < _loc3_)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("moneyPoorNote"));
                  _loc2_.isNoPrompt = false;
               }
               else
               {
                  SocketManager.Instance.out.sendSevenDoubleStartGame(_loc2_.isBand);
                  return;
               }
            }
            _loc4_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("sevenDouble.frame.startGameConfirmTxt",_loc3_),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"SevenDoubleBuyConfirmView",30,true,1);
            _loc4_.moveEnable = false;
            _loc4_.addEventListener("response",startConfirm,false,0,true);
         }
      }
      
      private function startConfirm(param1:FrameEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         SoundManager.instance.play("008");
         var _loc5_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc5_.removeEventListener("response",startConfirm);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc4_ = SevenDoubleControl.instance.startGameNeedMoney;
            if(_loc5_.isBand && PlayerManager.Instance.Self.BandMoney < _loc4_)
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("sevenDouble.game.useSkillNoEnoughReConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
               _loc2_.moveEnable = false;
               _loc2_.addEventListener("response",startGameReConfirm,false,0,true);
               return;
            }
            if(!_loc5_.isBand && PlayerManager.Instance.Self.Money < _loc4_)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            if((_loc5_ as SevenDoubleBuyConfirmView).isNoPrompt)
            {
               _loc3_ = SevenDoubleControl.instance.getBuyRecordStatus(1);
               _loc3_.isNoPrompt = true;
               _loc3_.isBand = _loc5_.isBand;
            }
            SocketManager.Instance.out.sendSevenDoubleStartGame(_loc5_.isBand);
         }
      }
      
      private function startGameReConfirm(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         var _loc3_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc3_.removeEventListener("response",startGameReConfirm);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc2_ = SevenDoubleControl.instance.startGameNeedMoney;
            if(PlayerManager.Instance.Self.Money < _loc2_)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.sendSevenDoubleStartGame(false);
         }
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
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
