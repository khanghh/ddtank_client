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
         var self:PlayerVO = new PlayerVO();
         self.playerInfo = PlayerManager.Instance.Self;
         var tempInfo:PlayerInfo = new PlayerInfo();
         ObjectUtils.copyProperties(tempInfo,PlayerManager.Instance.findPlayer(self.playerInfo.ID));
         self.playerInfo = tempInfo;
         self.playerInfo.MountsType = Math.max(1,self.playerInfo.MountsType);
         self.playerInfo.PetsID = 0;
         walkingPlayer = new HorseRaceWalkPlayer(self,callBack);
         addToContent(walkingPlayer);
         setRewardToList();
      }
      
      private function setRewardToList() : void
      {
         var i:int = 0;
         var itemInfo:* = null;
         var tInfo:* = null;
         var cell:* = null;
         var rewardList:Array = HorseRaceManager.Instance.itemInfoList;
         if(rewardList == null)
         {
            return;
         }
         for(i = 0; i < rewardList.length; )
         {
            itemInfo = ItemManager.Instance.getTemplateById(rewardList[i].TemplateID) as ItemTemplateInfo;
            tInfo = new InventoryItemInfo();
            ObjectUtils.copyProperties(tInfo,itemInfo);
            tInfo.ValidDate = rewardList[i].ValidDate;
            tInfo.StrengthenLevel = rewardList[i].StrengthLevel;
            tInfo.AttackCompose = rewardList[i].AttackCompose;
            tInfo.DefendCompose = rewardList[i].DefendCompose;
            tInfo.LuckCompose = rewardList[i].LuckCompose;
            tInfo.AgilityCompose = rewardList[i].AgilityCompose;
            tInfo.IsBinds = rewardList[i].IsBind;
            tInfo.Count = rewardList[i].Count;
            cell = new BagCell(0,tInfo,false);
            cell.x = 6;
            cell.y = 5;
            cell.setBgVisible(false);
            rewardBox.addChild(cell);
            i++;
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
      
      private function callBack($walkingPlayer:HorseRaceWalkPlayer, isLoadSucceed:Boolean, vFlag:int) : void
      {
         if(vFlag == 0)
         {
            var _loc4_:* = $walkingPlayer.playerVO.scenePlayerDirection;
            $walkingPlayer.sceneCharacterDirection = _loc4_;
            $walkingPlayer.setSceneCharacterDirectionDefault = _loc4_;
            $walkingPlayer.mouseEnabled = false;
            $walkingPlayer.showPlayerTitle();
            $walkingPlayer.sceneCharacterStateType = "natural";
            $walkingPlayer.showPlayerTitle();
            $walkingPlayer.showVipName();
            $walkingPlayer.playerPoint = new Point(123,276);
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
      
      private function _onBuyCountClick(e:MouseEvent) : void
      {
         var price:int = 0;
         var content:* = null;
         if(HorseRaceManager.Instance.showBuyCountFram)
         {
            price = ServerConfigManager.instance.HorseGameCostMoneyCount;
            content = LanguageMgr.GetTranslation("horseRace.match.buyCountDescription",price);
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),content,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
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
      
      private function __onClickSelectedBtn(e:MouseEvent) : void
      {
         HorseRaceManager.Instance.showBuyCountFram = !_selectBtn.selected;
      }
      
      private function __onRecoverResponse(e:FrameEvent) : void
      {
         var price:int = 0;
         SoundManager.instance.playButtonSound();
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            price = ServerConfigManager.instance.HorseGameCostMoneyCount;
            if(PlayerManager.Instance.Self.Money < price)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.buyHorseRaceCount();
         }
         else if(e.responseCode == 4 || e.responseCode == 0 || e.responseCode == 1)
         {
            HorseRaceManager.Instance.showBuyCountFram = true;
         }
         (e.currentTarget as BaseAlerFrame).removeEventListener("response",__onRecoverResponse);
         if(_selectBtn)
         {
            _selectBtn.removeEventListener("click",__onClickSelectedBtn);
         }
         ObjectUtils.disposeObject(e.currentTarget);
      }
      
      private function _startClick(e:MouseEvent) : void
      {
         var buyCount1:int = HorseRaceManager.Instance.horseRaceCanRaceTime;
         if(buyCount1 <= 0)
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
      
      private function _onCancel(e:MouseEvent) : void
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
      
      private function cancelMatchHandler(event:FrameEvent) : void
      {
         if(event.responseCode == 1 || event.responseCode == 4 || event.responseCode == 0)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function timerHandler(event:TimerEvent) : void
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
