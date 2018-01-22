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
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("ddtKing.bg");
         _bg.x = -32;
         _bg.y = -102;
         addToContent(_bg);
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc1_ = DDTKingFloatManager.instance.dataInfo;
            _loc2_ = new DDTKingFloatFrameItemCell(_loc3_,DDTKingFloatManager.instance.dataInfo.carInfo[_loc3_]);
            _loc2_.x = 8 + (_loc2_.width - 2) * _loc3_;
            _loc2_.y = 10;
            addToContent(_loc2_);
            _cellList.push(_loc2_);
            _loc3_++;
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
      
      private function refreshEnterCountHandler(param1:Event) : void
      {
         if(_btn)
         {
            _btn.removeEventListener("click",clickHandler);
            ObjectUtils.disposeObject(_btn);
         }
         var _loc2_:int = DDTKingFloatManager.instance.freeCount;
         _btn = ComponentFactory.Instance.creatComponentByStylename("ddtKing.race.startBtn");
         addToContent(_btn);
         _countTxt.text = "(" + _loc2_ + ")";
         if(_loc2_ <= 0)
         {
            _btn.enable = false;
         }
      }
      
      private function endHandler(param1:Event) : void
      {
         SocketManager.Instance.out.sendEscortCancelGame();
         dispose();
      }
      
      private function enterGameHandler(param1:Event) : void
      {
         dispose();
         DDTKingFloatManager.instance.enterGame();
      }
      
      private function startGameHandler(param1:Event) : void
      {
         _matchView = ComponentFactory.Instance.creatComponentByStylename("ddtking.matchView");
         LayerManager.Instance.addToLayer(_matchView,2,true,2);
      }
      
      private function clickHandler(param1:MouseEvent) : void
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
            _loc4_ = DDTKingFloatManager.instance.startGameNeedMoney;
            if(_loc5_.isBand && PlayerManager.Instance.Self.BandMoney < _loc4_)
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("escort.game.useSkillNoEnoughReConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
               _loc2_.moveEnable = false;
               _loc2_.addEventListener("response",startGameReConfirm,false,0,true);
               return;
            }
            if(!_loc5_.isBand && PlayerManager.Instance.Self.Money < _loc4_)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            if((_loc5_ as DDTKingFloatBuyConfirmView).isNoPrompt)
            {
               _loc3_ = DDTKingFloatManager.instance.getBuyRecordStatus(1);
               _loc3_.isNoPrompt = true;
               _loc3_.isBand = _loc5_.isBand;
            }
            SocketManager.Instance.out.sendEscortStartGame(_loc5_.isBand);
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
            _loc2_ = DDTKingFloatManager.instance.startGameNeedMoney;
            if(PlayerManager.Instance.Self.Money < _loc2_)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.sendEscortStartGame(false);
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
