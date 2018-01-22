package braveDoor.view
{
   import BraveDoor.event.BraveDoorEvent;
   import braveDoor.BraveDoorControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.RoomEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MapManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import gameCommon.GameControl;
   import room.RoomManager;
   import room.model.RoomInfo;
   import room.model.RoomPlayer;
   import room.view.roomView.BaseRoomView;
   
   public class DuplicateTemRoomView extends BaseRoomView
   {
      
      private static const DUPLICATE_ICON_PATH:String = "asset.braveDoor.room.duplicateTitle";
       
      
      private var _itemList:SimpleTileList;
      
      private var _duplicateName:Bitmap;
      
      private var _startButton:BaseButton;
      
      private var _readyButton:BaseButton;
      
      private var _cancelButton:BaseButton;
      
      private var _exitButton:BaseButton;
      
      private var _inviteButton:BaseButton;
      
      private var _temItemView:DuplicateTemRoomItemView;
      
      private var _control:BraveDoorControl = null;
      
      public function DuplicateTemRoomView(param1:RoomInfo)
      {
         super(param1);
      }
      
      public function set control(param1:BraveDoorControl) : void
      {
         _control = param1;
      }
      
      override protected function initView() : void
      {
         _itemList = ComponentFactory.Instance.creat("braveDoor.duplicateRoom.roomItemList",[1]);
         addChild(_itemList);
         updateDuplicateName(_info.mapId);
         _startButton = ComponentFactory.Instance.creatComponentByStylename("braveDoor.duplicateTeamRoom.startBtn");
         addChild(_startButton);
         _readyButton = ComponentFactory.Instance.creatComponentByStylename("braveDoor.duplicateTeamRoom.readyBtn");
         addChild(_readyButton);
         _cancelButton = ComponentFactory.Instance.creatComponentByStylename("braveDoor.duplicateTeamRoom.cancelBtn");
         addChild(_cancelButton);
         _exitButton = ComponentFactory.Instance.creatComponentByStylename("braveDoor.duplicateTeamRoom.exitBtn");
         addChild(_exitButton);
         _inviteButton = ComponentFactory.Instance.creatComponentByStylename("braveDoor.duplicateTeamRoom.inviteBtn");
         addChild(_inviteButton);
         _playerItems = [];
         initPlayerItems();
         updateButtons();
      }
      
      private function updateDuplicateName(param1:int) : void
      {
         var _loc2_:String = "asset.braveDoor.room.duplicateTitle" + param1;
         if(_duplicateName != null)
         {
            ObjectUtils.disposeObject(_duplicateName);
            _duplicateName = null;
         }
         _duplicateName = ComponentFactory.Instance.creatBitmap(_loc2_);
         _duplicateName.x = 712;
         _duplicateName.y = 96;
         addChild(_duplicateName);
      }
      
      override protected function updateButtons() : void
      {
         updateTimer();
         if(_info == null || _info.selfRoomPlayer == null)
         {
            return;
         }
         _startButton.visible = _info.selfRoomPlayer.isHost && !_info.started;
         _readyButton.visible = !_info.selfRoomPlayer.isHost && !_info.selfRoomPlayer.isReady;
         _cancelButton.visible = !!_info.selfRoomPlayer.isHost?_info.started:Boolean(_info.selfRoomPlayer.isReady);
         _cancelButton.enable = _info.selfRoomPlayer.isHost || !_info.started;
         var _loc1_:* = !_info.started && !_info.selfRoomPlayer.isReady;
         _exitButton.enable = _loc1_;
         _inviteButton.enable = _loc1_;
         if(_info.isAllReady())
         {
            _startButton.addEventListener("click",__startClick);
            _startButton.filters = null;
            _startButton.enable = true;
         }
         else
         {
            _startButton.removeEventListener("click",__startClick);
            _startButton.filters = [ComponentFactory.Instance.model.getSet("grayFilter")];
            _startButton.enable = false;
         }
         RoomManager.Instance.isPrepare = _readyButton.visible;
      }
      
      override protected function initPlayerItems() : void
      {
         var _loc1_:* = null;
         var _loc3_:int = 0;
         if(_info == null || _info.selfRoomPlayer == null)
         {
            return;
         }
         if(_itemList)
         {
            _itemList.disposeAllChildren();
         }
         var _loc2_:int = _info.currentPlayers.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _info.currentPlayers[_loc3_];
            _temItemView = new DuplicateTemRoomItemView();
            _temItemView.info = _loc1_;
            _itemList.addChild(_temItemView);
            _playerItems[_loc1_.place] = _temItemView;
            _loc3_++;
         }
      }
      
      override protected function initEvents() : void
      {
         _inviteButton.addEventListener("click",__inviteClick);
         _startButton.addEventListener("click",__startClick);
         _cancelButton.addEventListener("click",__cancelClick);
         _readyButton.addEventListener("click",__prepareClick);
         _exitButton.addEventListener("click",__exitClickHandler);
         _info.addEventListener("roomplaceChanged",__updatePlayerItems);
         _info.addEventListener("playerStateChanged",__updateState);
         _info.addEventListener("addPlayer",__addPlayer);
         _info.addEventListener("removePlayer",__removePlayer);
         _info.addEventListener("startedChanged",__startHandler);
         _info.addEventListener("mapChanged",__onMapChanged);
         GameControl.Instance.addEventListener("StartLoading",__onStartLoad);
      }
      
      override protected function __inviteClick(param1:MouseEvent) : void
      {
         super.__inviteClick(param1);
      }
      
      override protected function removeEvents() : void
      {
         _inviteButton.removeEventListener("click",__inviteClick);
         _startButton.removeEventListener("click",__startClick);
         _cancelButton.removeEventListener("click",__cancelClick);
         _readyButton.removeEventListener("click",__prepareClick);
         _exitButton.removeEventListener("click",__exitClickHandler);
         _info.removeEventListener("roomplaceChanged",__updatePlayerItems);
         _info.removeEventListener("playerStateChanged",__updateState);
         _info.removeEventListener("addPlayer",__addPlayer);
         _info.removeEventListener("removePlayer",__removePlayer);
         _info.removeEventListener("startedChanged",__startHandler);
         _info.removeEventListener("mapChanged",__onMapChanged);
         _hostTimer.removeEventListener("timer",__onHostTimer);
         _normalTimer.removeEventListener("timer",__onTimerII);
         GameControl.Instance.removeEventListener("StartLoading",__onStartLoad);
      }
      
      protected function __onStartLoad(param1:Event) : void
      {
         ChatManager.Instance.input.faceEnabled = false;
         LayerManager.Instance.clearnGameDynamic();
         StateManager.setState("roomLoading",GameControl.Instance.Current);
      }
      
      protected function __onMapChanged(param1:RoomEvent) : void
      {
         var _loc2_:int = _info.mapId;
         updateDuplicateName(_loc2_);
      }
      
      override protected function updateTimer() : void
      {
         if(_info.selfRoomPlayer.isHost && _startButton.buttonMode == !_info.isAllReady())
         {
            resetHostTimer();
         }
         if(!_info.selfRoomPlayer.isHost && _readyButton.visible == _info.selfRoomPlayer.isReady)
         {
            resetNormalTimer();
         }
      }
      
      override protected function __updatePlayerItems(param1:RoomEvent) : void
      {
         updateButtons();
      }
      
      override protected function __updateState(param1:RoomEvent) : void
      {
         updateButtons();
         if(_info.selfRoomPlayer.isHost)
         {
            startHostTimer();
            stopNormalTimer();
            if(!_info.isAllReady() && _info.started)
            {
               GameInSocketOut.sendCancelWait();
               _info.started = false;
               SoundManager.instance.stop("007");
            }
         }
         else
         {
            stopHostTimer();
            startNormalTimer();
         }
      }
      
      override protected function __addPlayer(param1:RoomEvent) : void
      {
         var _loc2_:RoomPlayer = param1.params[0] as RoomPlayer;
         _temItemView = new DuplicateTemRoomItemView();
         _temItemView.info = _loc2_;
         if(_itemList.contains(_temItemView))
         {
            _itemList.removeChild(_temItemView);
         }
         _itemList.addChildAt(_temItemView,_loc2_.place);
         _itemList.refreshChildPos();
         _playerItems[_loc2_.place] = _temItemView;
         updateButtons();
      }
      
      override protected function __removePlayer(param1:RoomEvent) : void
      {
         var _loc2_:RoomPlayer = param1.params[0] as RoomPlayer;
         _itemList.removeChild(_playerItems[_loc2_.place]);
         _playerItems[_loc2_.place].info = null;
         _playerItems[_loc2_.place] = null;
         _loc2_.dispose();
         _itemList.refreshChildPos();
         updateButtons();
      }
      
      override protected function __startClick(param1:MouseEvent) : void
      {
         if(_info.mapId > 0)
         {
            if(levCheck())
            {
               return;
            }
            super.__startClick(param1);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("game.braveDoor.noSelectDuplicate"));
         }
      }
      
      private function levCheck() : Boolean
      {
         if(_info == null)
         {
            return true;
         }
         var _loc2_:int = MapManager.getBraveDoorDuplicateInfo(_info.mapId).LevelLimits;
         var _loc4_:int = 0;
         var _loc3_:* = _info.currentPlayers;
         for each(var _loc1_ in _info.currentPlayers)
         {
            if(_loc1_.playerInfo.Grade < _loc2_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("game.braveDoor.startGame.levCheckTip",_loc2_));
               return true;
            }
         }
         return false;
      }
      
      override protected function __prepareClick(param1:MouseEvent) : void
      {
         super.__prepareClick(param1);
      }
      
      override protected function __cancelClick(param1:MouseEvent) : void
      {
         super.__cancelClick(param1);
      }
      
      override protected function __startHandler(param1:RoomEvent) : void
      {
         updateButtons();
         if(_info.started)
         {
            stopHostTimer();
            SoundManager.instance.stop("007");
         }
         else if(_info.selfRoomPlayer.isHost && _info.isAllReady())
         {
            startHostTimer();
         }
      }
      
      protected function __exitClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(_control == null)
         {
            return;
         }
         if(!_info.selfRoomPlayer.isReady || !_info.started)
         {
            GameInSocketOut.sendGamePlayerExit();
         }
         _control.dispatchEvent(new BraveDoorEvent("selectedDuplicate",-1));
      }
      
      override protected function kickHandler() : void
      {
         ChatManager.Instance.sysChatRed(LanguageMgr.GetTranslation("tank.room.RoomIIView2.kick"));
         if(_control != null)
         {
            _control.switchView(1);
         }
      }
      
      override public function dispose() : void
      {
         removeEvents();
         if(_inviteFrame)
         {
            ObjectUtils.disposeObject(_inviteFrame);
         }
         _inviteFrame = null;
         var _loc3_:int = 0;
         var _loc2_:* = _playerItems;
         for each(var _loc1_ in _playerItems)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _playerItems = null;
         if(_hostTimer)
         {
            _hostTimer.stop();
         }
         _hostTimer = null;
         if(_normalTimer)
         {
            _normalTimer.stop();
         }
         _normalTimer = null;
         if(_itemList)
         {
            _itemList.disposeAllChildren();
            removeChild(_itemList);
         }
         _itemList = null;
         if(_duplicateName)
         {
            ObjectUtils.disposeObject(_duplicateName);
         }
         _duplicateName = null;
         if(_startButton)
         {
            ObjectUtils.disposeObject(_startButton);
         }
         _startButton = null;
         if(_readyButton)
         {
            ObjectUtils.disposeObject(_readyButton);
         }
         _readyButton = null;
         if(_cancelButton)
         {
            ObjectUtils.disposeObject(_cancelButton);
         }
         _cancelButton = null;
         if(_exitButton)
         {
            ObjectUtils.disposeObject(_exitButton);
         }
         _exitButton = null;
         if(_inviteButton)
         {
            ObjectUtils.disposeObject(_inviteButton);
         }
         _inviteButton = null;
         _info = null;
         _control = null;
         SoundManager.instance.stop("007");
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
