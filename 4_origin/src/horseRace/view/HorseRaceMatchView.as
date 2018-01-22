package horseRace.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import hall.player.vo.PlayerPetsInfo;
   import hall.player.vo.PlayerVO;
   import horseRace.controller.HorseRaceManager;
   import invite.InviteManager;
   
   public class HorseRaceMatchView extends Frame
   {
      
      public static var petsDisInfo:PlayerPetsInfo;
       
      
      private var _bg:Bitmap;
      
      private var _helpTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _cancelBtn:SimpleBitmapButton;
      
      private var _startBnt:SimpleBitmapButton;
      
      private var _countDown:int = 0;
      
      private var _timer:Timer;
      
      private var _matchTxt:Bitmap;
      
      private var walkingPlayer:HorseRaceWalkPlayer;
      
      private var _buyCountTxt:FilterFrameText;
      
      private var _buyCount:int = 5;
      
      private var _buyBnt:BaseButton;
      
      private var rewardBox:HBox;
      
      private var _selectBtn:SelectedCheckButton;
      
      private var alert:BaseAlerFrame;
      
      public function HorseRaceMatchView()
      {
         super();
         initView();
         initEvent();
         InviteManager.Instance.enabled = false;
         walkingPlayer.stand();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("horseRace.horseRaceMatchView.title");
         _bg = ComponentFactory.Instance.creatBitmap("horseRace.matchView.bg");
         _helpTxt = ComponentFactory.Instance.creatComponentByStylename("horseRace.race.matchView.rightTxt");
         _helpTxt.text = LanguageMgr.GetTranslation("horseRace.match.description");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("horseRace.race.matchView.timeTxt");
         _timeTxt.text = "0" + _countDown;
         _timeTxt.visible = false;
         _matchTxt = ComponentFactory.Instance.creat("horseRace.matchView.txt");
         _matchTxt.visible = false;
         _startBnt = ComponentFactory.Instance.creatComponentByStylename("horseRace.matchView.startBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("horseRace.matchView.cancelBtn");
         _cancelBtn.visible = false;
         _buyCountTxt = ComponentFactory.Instance.creatComponentByStylename("horseRace.race.matchView.buyCountTxt");
         _buyCount = HorseRaceManager.Instance.horseRaceCanRaceTime;
         _buyCountTxt.htmlText = LanguageMgr.GetTranslation("horseRace.match.buyCountTxt",_buyCount);
         _buyBnt = ComponentFactory.Instance.creatComponentByStylename("horseRace.race.matchView.buyCountBnt");
         rewardBox = ComponentFactory.Instance.creatComponentByStylename("horseRace.race.matchView.rewardList");
         addToContent(_bg);
         addToContent(_helpTxt);
         addToContent(_timeTxt);
         addToContent(_matchTxt);
         addToContent(_cancelBtn);
         addToContent(_startBnt);
         addToContent(_buyCountTxt);
         addToContent(_buyBnt);
         addToContent(rewardBox);
         var _loc2_:PlayerVO = new PlayerVO();
         _loc2_.playerInfo = PlayerManager.Instance.Self;
         var _loc1_:PlayerInfo = new PlayerInfo();
         ObjectUtils.copyProperties(_loc1_,PlayerManager.Instance.findPlayer(_loc2_.playerInfo.ID));
         _loc2_.playerInfo = _loc1_;
         _loc2_.playerInfo.MountsType = Math.max(1,_loc2_.playerInfo.MountsType);
         _loc2_.playerInfo.PetsID = 0;
         walkingPlayer = new HorseRaceWalkPlayer(_loc2_,callBack);
         addToContent(walkingPlayer);
         setRewardToList();
      }
      
      private function setRewardToList() : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc1_:Array = HorseRaceManager.Instance.itemInfoList;
         if(_loc1_ == null)
         {
            return;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc4_ = ItemManager.Instance.getTemplateById(_loc1_[_loc5_].TemplateID) as ItemTemplateInfo;
            _loc2_ = new InventoryItemInfo();
            ObjectUtils.copyProperties(_loc2_,_loc4_);
            _loc2_.ValidDate = _loc1_[_loc5_].ValidDate;
            _loc2_.StrengthenLevel = _loc1_[_loc5_].StrengthLevel;
            _loc2_.AttackCompose = _loc1_[_loc5_].AttackCompose;
            _loc2_.DefendCompose = _loc1_[_loc5_].DefendCompose;
            _loc2_.LuckCompose = _loc1_[_loc5_].LuckCompose;
            _loc2_.AgilityCompose = _loc1_[_loc5_].AgilityCompose;
            _loc2_.IsBinds = _loc1_[_loc5_].IsBind;
            _loc2_.Count = _loc1_[_loc5_].Count;
            _loc3_ = new BagCell(0,_loc2_,false);
            _loc3_.x = 6;
            _loc3_.y = 5;
            _loc3_.setBgVisible(false);
            rewardBox.addChild(_loc3_);
            _loc5_++;
         }
      }
      
      public function reflushHorseRaceTime() : void
      {
         _buyCount = HorseRaceManager.Instance.horseRaceCanRaceTime;
         if(_buyCountTxt)
         {
            _buyCountTxt.htmlText = LanguageMgr.GetTranslation("horseRace.match.buyCountTxt",_buyCount);
         }
      }
      
      private function callBack(param1:HorseRaceWalkPlayer, param2:Boolean, param3:int) : void
      {
         if(param3 == 0)
         {
            var _loc4_:* = param1.playerVO.scenePlayerDirection;
            param1.sceneCharacterDirection = _loc4_;
            param1.setSceneCharacterDirectionDefault = _loc4_;
            param1.mouseEnabled = false;
            param1.showPlayerTitle();
            param1.sceneCharacterStateType = "natural";
            param1.showPlayerTitle();
            param1.showVipName();
            param1.playerPoint = new Point(123,276);
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",cancelMatchHandler);
         _startBnt.addEventListener("click",_startClick);
         _cancelBtn.addEventListener("click",_onCancel);
         _buyBnt.addEventListener("click",_onBuyCountClick);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",timerHandler,false,0,true);
         _timer.start();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",cancelMatchHandler);
         _startBnt.removeEventListener("click",_startClick);
         _cancelBtn.removeEventListener("click",_onCancel);
         _buyBnt.removeEventListener("click",_onBuyCountClick);
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",timerHandler);
         }
         _timer = null;
         walkingPlayer.stop();
      }
      
      private function _onBuyCountClick(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(HorseRaceManager.Instance.showBuyCountFram)
         {
            _loc3_ = ServerConfigManager.instance.HorseGameCostMoneyCount;
            _loc2_ = LanguageMgr.GetTranslation("horseRace.match.buyCountDescription",_loc3_);
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc2_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            _selectBtn = ComponentFactory.Instance.creatComponentByStylename("ddtGame.buyConfirmNo.scb");
            _selectBtn.text = LanguageMgr.GetTranslation("horseRace.match.notTip");
            _selectBtn.addEventListener("click",__onClickSelectedBtn);
            alert.addToContent(_selectBtn);
            alert.moveEnable = false;
            alert.addEventListener("response",__onRecoverResponse);
            alert.height = 200;
            _selectBtn.x = 66;
            _selectBtn.y = 67;
         }
         else
         {
            SocketManager.Instance.out.buyHorseRaceCount();
         }
      }
      
      private function __onClickSelectedBtn(param1:MouseEvent) : void
      {
         HorseRaceManager.Instance.showBuyCountFram = !_selectBtn.selected;
      }
      
      private function __onRecoverResponse(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.playButtonSound();
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            _loc2_ = ServerConfigManager.instance.HorseGameCostMoneyCount;
            if(PlayerManager.Instance.Self.Money < _loc2_)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.buyHorseRaceCount();
         }
         else if(param1.responseCode == 4 || param1.responseCode == 0 || param1.responseCode == 1)
         {
            HorseRaceManager.Instance.showBuyCountFram = true;
         }
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",__onRecoverResponse);
         if(_selectBtn)
         {
            _selectBtn.removeEventListener("click",__onClickSelectedBtn);
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function _startClick(param1:MouseEvent) : void
      {
         var _loc2_:int = HorseRaceManager.Instance.horseRaceCanRaceTime;
         if(_loc2_ <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("horseRace.raceView.noTimeToRace"));
            return;
         }
         _timeTxt.visible = true;
         _matchTxt.visible = true;
         _timer.reset();
         _countDown = 0;
         if(_countDown < 10)
         {
            _timeTxt.text = "0" + _countDown;
         }
         else
         {
            _timeTxt.text = "" + _countDown;
         }
         _timer.start();
         _startBnt.visible = false;
         _cancelBtn.visible = true;
         walkingPlayer.walk();
         GameInSocketOut.sendSingleRoomBegin(60);
      }
      
      private function _onCancel(param1:MouseEvent) : void
      {
         _timeTxt.visible = false;
         _matchTxt.visible = false;
         _timer.reset();
         _timer.stop();
         _countDown = 0;
         _startBnt.visible = true;
         _cancelBtn.visible = false;
         walkingPlayer.stand();
         GameInSocketOut.sendCancelWait();
      }
      
      private function cancelMatchHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 1 || param1.responseCode == 4 || param1.responseCode == 0)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function timerHandler(param1:TimerEvent) : void
      {
         _countDown = Number(_countDown) + 1;
         if(_countDown > 10)
         {
            _countDown = 0;
         }
         if(_countDown < 10)
         {
            _timeTxt.text = "0" + _countDown;
         }
         else
         {
            _timeTxt.text = "" + _countDown;
         }
      }
      
      public function dispose2() : void
      {
         if(alert)
         {
            alert.removeEventListener("response",__onRecoverResponse);
            ObjectUtils.disposeObject(alert);
         }
         removeEvent();
         super.dispose();
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         InviteManager.Instance.enabled = true;
      }
      
      override public function dispose() : void
      {
         GameInSocketOut.sendCancelWait();
         if(alert)
         {
            alert.removeEventListener("response",__onRecoverResponse);
            ObjectUtils.disposeObject(alert);
         }
         removeEvent();
         super.dispose();
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         InviteManager.Instance.enabled = true;
      }
   }
}
