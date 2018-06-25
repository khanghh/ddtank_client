package room.view.bigMapInfoPanel
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.map.DungeonInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.RoomEvent;
   import ddt.manager.MapManager;
   import ddt.manager.PathManager;
   import ddt.manager.SocketManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import gameCommon.GameControl;
   import room.RoomManager;
   import room.model.RoomInfo;
   import room.view.RoomTicketView;
   
   public class MissionRoomBigMapInfoPanel extends Sprite implements Disposeable
   {
       
      
      protected var _bg:MutipleImage;
      
      protected var _mapShowContainer:Sprite;
      
      protected var _dropList:DropList;
      
      protected var _pos1:Point;
      
      protected var _pos2:Point;
      
      protected var _info:RoomInfo;
      
      protected var _ticketView:RoomTicketView;
      
      private var _loader:DisplayLoader;
      
      public function MissionRoomBigMapInfoPanel()
      {
         super();
         initView();
         initEvents();
      }
      
      protected function initEvents() : void
      {
         _dropList.addEventListener("large",__dropListLarge);
         _dropList.addEventListener("small",__dropListSmall);
         SocketManager.Instance.addEventListener("warriorsarenaLastMission",__lastMission);
      }
      
      private function __lastMission(event:CrazyTankSocketEvent) : void
      {
         _ticketView.visible = RoomManager.Instance.IsLastMisstion;
      }
      
      protected function removeEvents() : void
      {
         _dropList.removeEventListener("large",__dropListLarge);
         _dropList.removeEventListener("small",__dropListSmall);
         _loader.removeEventListener("complete",__showMap);
         _info.removeEventListener("mapChanged",__onMapChanged);
         _info.removeEventListener("hardLevelChanged",__updateHard);
         SocketManager.Instance.removeEventListener("warriorsarenaLastMission",__lastMission);
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.bigMapinfo.bg");
         addChild(_bg);
         _mapShowContainer = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.bigMapIconContainer");
         addChild(_mapShowContainer);
         _pos1 = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.dropListPos1");
         _pos2 = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.dropListPos2");
         _dropList = new DropList();
         _dropList.x = _pos1.x;
         _dropList.y = _pos1.y;
         addChild(_dropList);
         _dropList.visible = false;
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
      }
      
      protected function __onMapChanged(evt:RoomEvent) : void
      {
         updateMap();
         updateDropList();
      }
      
      protected function __updateHard(evt:RoomEvent) : void
      {
         updateDropList();
      }
      
      protected function updateMap() : void
      {
         if(_loader)
         {
            _loader.removeEventListener("complete",__showMap);
         }
         _loader = LoadResourceManager.Instance.createLoader(solvePath(),0);
         _loader.addEventListener("complete",__showMap);
         LoadResourceManager.Instance.startLoad(_loader);
      }
      
      private function __showMap(evt:LoaderEvent) : void
      {
         if(evt.loader.isSuccess)
         {
            ObjectUtils.disposeAllChildren(_mapShowContainer);
            evt.loader.removeEventListener("complete",__showMap);
            _mapShowContainer.addChild(evt.loader.content as Bitmap);
            _mapShowContainer.width = 315;
            _mapShowContainer.height = 357;
         }
      }
      
      protected function updateDropList() : void
      {
         var dungeon:DungeonInfo = MapManager.getDungeonInfo(_info.mapId);
         if(_info.mapId != 0 && _info.mapId != 10000)
         {
            if(_ticketView)
            {
               _ticketView.giftBtnEnable();
            }
            switch(int(_info.hardLevel))
            {
               case 0:
                  _dropList.info = dungeon.SimpleTemplateIds.split(",");
                  break;
               case 1:
                  _dropList.info = dungeon.NormalTemplateIds.split(",");
                  break;
               case 2:
                  _dropList.info = dungeon.HardTemplateIds.split(",");
                  break;
               case 3:
                  _dropList.info = dungeon.TerrorTemplateIds.split(",");
                  break;
               case 4:
                  _dropList.info = dungeon.NightmareTemplateIds.split(",");
                  break;
               case 5:
                  _dropList.info = dungeon.EpicTemplateIds.split(",");
            }
            _dropList.visible = true;
         }
         else
         {
            _dropList.visible = false;
         }
      }
      
      private function __dropListLarge(evt:Event) : void
      {
         _dropList.x = _pos2.x;
         _dropList.y = _pos2.y;
         _ticketView.y = _dropList.y - 22;
      }
      
      private function __dropListSmall(evt:Event) : void
      {
         _dropList.x = _pos1.x;
         _dropList.y = _pos1.y;
         _ticketView.y = _dropList.y - 22;
      }
      
      protected function solvePath() : String
      {
         var result:String = "";
         if(RoomManager.Instance.current.isOpenBoss)
         {
            result = PathManager.SITE_MAIN + "image/map/" + _info.mapId + "/" + RoomManager.Instance.current.pic;
         }
         else
         {
            result = PathManager.SITE_MAIN + "image/map/" + _info.mapId + "/" + GameControl.Instance.Current.missionInfo.pic;
         }
         return result;
      }
      
      public function dispose() : void
      {
         removeEvents();
         if(_bg.parent != null)
         {
            _bg.parent.removeChild(_bg);
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeAllChildren(_mapShowContainer);
         if(_mapShowContainer.parent != null)
         {
            _mapShowContainer.parent.removeChild(_mapShowContainer);
         }
         _mapShowContainer = null;
         if(_dropList != null)
         {
            _dropList.dispose();
         }
         _dropList = null;
         if(_loader != null)
         {
            _loader.removeEventListener("complete",__showMap);
         }
         _loader = null;
         _info = null;
         if(_ticketView)
         {
            _ticketView.dispose();
         }
         _ticketView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
