package room.view.bigMapInfoPanel
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.events.RoomEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.view.MainToolBar;
   import flash.events.MouseEvent;
   import room.RoomManager;
   import room.view.chooseMap.DungeonChooseMapFrame;
   
   public class DungeonBigMapInfoPanel extends MissionRoomBigMapInfoPanel
   {
       
      
      private var _chooseBtn:SimpleBitmapButton;
      
      public function DungeonBigMapInfoPanel()
      {
         super();
      }
      
      override protected function initEvents() : void
      {
         super.initEvents();
         _chooseBtn.addEventListener("mouseOver",__overHandler);
         _chooseBtn.addEventListener("mouseOut",__outHandler);
         _chooseBtn.addEventListener("click",__clickHandler);
         _info.addEventListener("startedChanged",__onGameStarted);
         _info.addEventListener("playerStateChanged",__playerStateChange);
         _info.addEventListener("openBossChange",__openBossChange);
      }
      
      private function __clickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(RoomManager.Instance.current.isOpenBoss)
         {
            _chooseBtn.visible = false;
            return;
         }
         var mapChooser:DungeonChooseMapFrame = new DungeonChooseMapFrame();
         mapChooser.show();
         dispatchEvent(new RoomEvent("openDungeonChooser"));
         if(!PlayerManager.Instance.Self.isDungeonGuideFinish(121))
         {
            SocketManager.Instance.out.syncWeakStep(121);
         }
      }
      
      private function __outHandler(event:MouseEvent) : void
      {
         if(_info.mapId != 0 && _info.mapId != 10000)
         {
            _chooseBtn.alpha = 0;
         }
         else
         {
            if(RoomManager.Instance.current.isOpenBoss)
            {
               _chooseBtn.visible = false;
               return;
            }
            _chooseBtn.alpha = 1;
         }
      }
      
      private function __overHandler(event:MouseEvent) : void
      {
         if(RoomManager.Instance.current.isOpenBoss)
         {
            _chooseBtn.visible = false;
            return;
         }
         _chooseBtn.alpha = 1;
      }
      
      override protected function removeEvents() : void
      {
         super.removeEvents();
         _chooseBtn.removeEventListener("mouseOver",__overHandler);
         _chooseBtn.removeEventListener("mouseOut",__outHandler);
         _chooseBtn.removeEventListener("click",__clickHandler);
         _info.removeEventListener("startedChanged",__onGameStarted);
         _info.removeEventListener("playerStateChanged",__playerStateChange);
         _info.removeEventListener("openBossChange",__openBossChange);
      }
      
      override protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.bigMapinfo.bg");
         addChild(_bg);
         _mapShowContainer = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.bigMapIconContainer");
         addChild(_mapShowContainer);
         _chooseBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.selectDungeonButton");
         _chooseBtn.mouseChildren = true;
         _chooseBtn.mouseEnabled = true;
         _chooseBtn.visible = false;
         addChild(_chooseBtn);
         _pos1 = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.dropListPos1");
         _pos2 = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.dropListPos2");
         _dropList = new DropList();
         _dropList.x = _pos1.x;
         _dropList.y = _pos1.y;
         addChild(_dropList);
         _dropList.visible = true;
         _info = RoomManager.Instance.current;
         if(_info)
         {
            _info.addEventListener("mapChanged",__onMapChanged);
            _info.addEventListener("hardLevelChanged",__updateHard);
            updateMap();
         }
         if(_ticketView == null)
         {
            _ticketView = ComponentFactory.Instance.creatCustomObject("asset.warriorsArena.ticketView");
            _ticketView.visible = RoomManager.Instance.IsLastMisstion;
            addChild(_ticketView);
         }
         if(_info)
         {
            updateDropList();
         }
         MainToolBar.Instance.backFunction = leaveAlert;
      }
      
      private function leaveAlert() : void
      {
         if((RoomManager.Instance.current.isOpenBoss || RoomManager.Instance.current.mapId == 12016 || RoomManager.Instance.current.mapId == 70020) && !RoomManager.Instance.current.selfRoomPlayer.isViewer)
         {
            showAlert();
         }
         else
         {
            StateManager.setState("dungeon");
         }
      }
      
      private function showAlert() : void
      {
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.missionsettle.dungeon.leaveConfirm.contents"),"",LanguageMgr.GetTranslation("cancel"),true,true,false,1);
         alert.moveEnable = false;
         alert.addEventListener("response",__onResponse);
      }
      
      private function __onResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = evt.target as BaseAlerFrame;
         alert.removeEventListener("response",__onResponse);
         alert.dispose();
         alert = null;
         if(evt.responseCode == 2 || evt.responseCode == 3)
         {
            StateManager.setState("dungeon");
         }
      }
      
      private function __onGameStarted(evt:RoomEvent) : void
      {
         _chooseBtn.enable = !_info.started;
      }
      
      override protected function __onMapChanged(evt:RoomEvent) : void
      {
         super.__onMapChanged(evt);
         if(_info.mapId == 12016 || _info.mapId == 70002 || _info.mapId == 70020)
         {
            _chooseBtn.visible = false;
         }
         if(_info.mapId != 0 && _info.mapId != 10000)
         {
            _chooseBtn.alpha = 0;
         }
         else
         {
            _chooseBtn.alpha = 1;
         }
      }
      
      private function __playerStateChange(evt:RoomEvent) : void
      {
         if(RoomManager.Instance.current.isOpenBoss || RoomManager.Instance.current.mapId == 12016 || RoomManager.Instance.current.mapId == 70002 || RoomManager.Instance.current.mapId == 70020)
         {
            _chooseBtn.visible = false;
         }
         else
         {
            _chooseBtn.visible = _info.selfRoomPlayer.isHost;
         }
      }
      
      private function __openBossChange(evt:RoomEvent) : void
      {
         updateMap();
         updateDropList();
      }
      
      override protected function updateMap() : void
      {
         super.updateMap();
         if(_info.selfRoomPlayer && _info.mapId != 12016 && _info.mapId != 70020)
         {
            _chooseBtn.visible = _info.selfRoomPlayer.isHost;
         }
      }
      
      override protected function solvePath() : String
      {
         var result:String = PathManager.SITE_MAIN + "image/map/";
         if(_info && _info.mapId > 0)
         {
            if(_info.isOpenBoss)
            {
               if(_info.pic && _info.pic.length > 0)
               {
                  result = result + (_info.mapId + "/" + _info.pic);
               }
            }
            else
            {
               result = result + (_info.mapId + "/show1.jpg");
            }
         }
         else
         {
            result = result + "10000/show1.jpg";
         }
         return result;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _chooseBtn.dispose();
         _chooseBtn = null;
         MainToolBar.Instance.backFunction = null;
      }
   }
}
