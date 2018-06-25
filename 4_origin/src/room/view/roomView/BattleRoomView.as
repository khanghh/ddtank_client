package room.view.roomView
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.RoomEvent;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import room.model.RoomInfo;
   import room.model.RoomPlayer;
   import room.view.BattleRoomRightPropView;
   import room.view.RoomPlayerItem;
   import room.view.bigMapInfoPanel.MatchRoomBigMapInfoPanel;
   import room.view.smallMapInfoPanel.MatchRoomSmallMapInfoPanel;
   
   public class BattleRoomView extends BaseRoomView
   {
       
      
      private var _timerII:Timer;
      
      protected var _crossZoneBtn:SelectedButton;
      
      protected var _bg:MovieClip;
      
      protected var _itemListBg:MovieClip;
      
      protected var _bigMapInfoPanel:MatchRoomBigMapInfoPanel;
      
      protected var _smallMapInfoPanel:MatchRoomSmallMapInfoPanel;
      
      private var _playerItemContainer:SimpleTileList;
      
      protected var _battleRoomProView:BattleRoomRightPropView;
      
      public function BattleRoomView(info:RoomInfo)
      {
         _timerII = new Timer(1000);
         super(info);
      }
      
      override protected function initView() : void
      {
         _bg = ClassUtils.CreatInstance("asset.background.room.right") as MovieClip;
         PositionUtils.setPos(_bg,"asset.ddtmatchroom.bgPos");
         addChild(_bg);
         _itemListBg = ClassUtils.CreatInstance("asset.ddtroom.playerItemlist.bg") as MovieClip;
         PositionUtils.setPos(_itemListBg,"asset.ddtroom.playerItemlist.bgPos");
         addChild(_itemListBg);
         _bigMapInfoPanel = ComponentFactory.Instance.creatCustomObject("ddtroom.matchRoomBigMapInfoPanel");
         _bigMapInfoPanel.info = _info;
         addChild(_bigMapInfoPanel);
         _smallMapInfoPanel = ComponentFactory.Instance.creatCustomObject("ddtroom.matchRoomSmallMapInfoPanel");
         _smallMapInfoPanel.info = _info;
         addChild(_smallMapInfoPanel);
         _crossZoneBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.crossZoneButton");
         _crossZoneBtn.selected = true;
         _crossZoneBtn.enable = false;
         addChild(_crossZoneBtn);
         _battleRoomProView = new BattleRoomRightPropView();
         PositionUtils.setPos(_battleRoomProView,"asset.ddtroom.battleRoomRightPropView.pos");
         addChild(_battleRoomProView);
         _btnBg = ComponentFactory.Instance.creatBitmap("asset.ddtroom.btnBg");
         addChild(_btnBg);
         PositionUtils.setPos(_btnBg,"asset.ddtroom.btnBgPos");
         _startBtn = ClassUtils.CreatInstance("asset.ddtroom.startMovie") as MovieClip;
         addChild(_startBtn);
         PositionUtils.setPos(_startBtn,"asset.ddtroom.startMoviePos");
         _prepareBtn = ClassUtils.CreatInstance("asset.ddtroom.preparMovie") as MovieClip;
         addChild(_prepareBtn);
         PositionUtils.setPos(_prepareBtn,"asset.ddtroom.startMoviePos");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.cancelButton");
         addChild(_cancelBtn);
         _inviteBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.inviteButton");
         addChild(_inviteBtn);
         var _loc1_:Boolean = true;
         _prepareBtn.buttonMode = _loc1_;
         _startBtn.buttonMode = _loc1_;
         initTileList();
         initPlayerItems();
         updateButtons();
      }
      
      override protected function __startHandler(evt:RoomEvent) : void
      {
         super.__startHandler(evt);
         if(_info.started)
         {
            _timerII.start();
         }
         else
         {
            _timerII.stop();
            _timerII.reset();
         }
      }
      
      override protected function updateButtons() : void
      {
         var temBol:Boolean = false;
         super.updateButtons();
         if(_battleRoomProView)
         {
            if(_info.selfRoomPlayer.isHost)
            {
               temBol = _info.started;
            }
            else
            {
               temBol = _info.selfRoomPlayer.isReady;
            }
         }
         _smallMapInfoPanel._actionStatus = _info.selfRoomPlayer.isHost && !_info.started && _info.type != 13 && _info.type != 12;
      }
      
      override protected function initTileList() : void
      {
         var i:int = 0;
         var item:* = null;
         super.initTileList();
         _playerItemContainer = new SimpleTileList(2);
         var space:Point = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.matchRoom.listSpace");
         _playerItemContainer.hSpace = space.x;
         _playerItemContainer.vSpace = space.y;
         var p:Point = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.playerListPos");
         _playerItemContainer.x = _bg.x + p.x;
         _playerItemContainer.y = _bg.y + p.y;
         for(i = 0; i < 4; )
         {
            item = new RoomPlayerItem(i);
            _playerItemContainer.addChild(item);
            _playerItems.push(item);
            i++;
         }
         addChild(_playerItemContainer);
         if(isViewerRoom)
         {
            PositionUtils.setPos(_viewerItems[0],"asset.ddtbattleroom.ViewerItemPos");
            addChild(_viewerItems[0]);
         }
      }
      
      override protected function __addPlayer(evt:RoomEvent) : void
      {
         var player:RoomPlayer = evt.params[0] as RoomPlayer;
         if(player.isFirstIn)
         {
            SoundManager.instance.play("158");
         }
         if(player.isViewer)
         {
            _viewerItems[player.place - 8].info = player;
         }
         else
         {
            _playerItems[player.place].info = player;
         }
         updateButtons();
      }
      
      override protected function __removePlayer(evt:RoomEvent) : void
      {
         var player:RoomPlayer = evt.params[0] as RoomPlayer;
         if(player.place >= 8)
         {
            _viewerItems[player.place - 8].info = null;
         }
         else
         {
            _playerItems[player.place].info = null;
         }
         player.dispose();
         updateButtons();
      }
      
      override protected function __startClick(evt:MouseEvent) : void
      {
         if(!_info.isAllReady())
         {
            return;
         }
         SoundManager.instance.play("008");
         if(_info.selfRoomPlayer.isViewer)
         {
            _info.started = true;
            startGame();
         }
         CheckWeaponManager.instance.setFunction(this,__startClick,[evt]);
         _info.started = true;
         startGame();
      }
      
      protected function startCheckWeaponComplete(... args) : void
      {
         var result:int = args[0];
         switch(int(result))
         {
            case 0:
               _info.started = true;
               startGame();
               break;
            case 1:
               CheckWeaponManager.instance.showGoShopAlert();
         }
      }
      
      override protected function __prepareClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         CheckWeaponManager.instance.setFunction(this,__prepareClick,[evt]);
         if(!super.checkCanStartGame())
         {
            return;
         }
         prepareGame();
      }
      
      protected function checkWeaponFragment(callFun:Function) : Boolean
      {
         var result:Boolean = true;
         CheckWeaponManager.instance.setFunction(this,callFun,[]);
         if(CheckWeaponManager.instance.isNoWeaponFragment())
         {
            result = false;
            CheckWeaponManager.instance.showFragmentAlert();
         }
         return result;
      }
      
      protected function proCheckWeaponComplete(... args) : void
      {
         var result:int = args[0];
         switch(int(result))
         {
            case 0:
               prepareGame();
               break;
            case 1:
               CheckWeaponManager.instance.showGoShopAlert();
         }
      }
      
      override public function dispose() : void
      {
         if(_itemListBg)
         {
            removeChild(_itemListBg);
         }
         if(_bigMapInfoPanel)
         {
            ObjectUtils.disposeObject(_bigMapInfoPanel);
         }
         if(_smallMapInfoPanel)
         {
            ObjectUtils.disposeObject(_smallMapInfoPanel);
         }
         if(_crossZoneBtn)
         {
            ObjectUtils.disposeObject(_crossZoneBtn);
         }
         if(_battleRoomProView)
         {
            ObjectUtils.disposeObject(_battleRoomProView);
         }
         if(_btnBg)
         {
            ObjectUtils.disposeObject(_btnBg);
         }
         if(_playerItemContainer)
         {
            _playerItemContainer.removeAllChild();
         }
         if(_bg)
         {
            removeChild(_bg);
         }
         _itemListBg = null;
         _bigMapInfoPanel = null;
         _smallMapInfoPanel = null;
         _crossZoneBtn = null;
         _roomPropView = null;
         _btnBg = null;
         _bg = null;
         super.dispose();
      }
   }
}
