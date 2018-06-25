package room.view.smallMapInfoPanel
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.events.MouseEvent;
   import room.RoomManager;
   import room.events.RoomPlayerEvent;
   import room.model.RoomInfo;
   import room.view.chooseMap.DungeonChooseMapFrame;
   
   public class DungeonSmallMapInfoPanel extends MissionRoomSmallMapInfoPanel
   {
       
      
      private var _btn:SimpleBitmapButton;
      
      public function DungeonSmallMapInfoPanel()
      {
         super();
      }
      
      private function removeEvents() : void
      {
         _info.selfRoomPlayer.removeEventListener("isHostChange",__update);
         removeEventListener("click",__onClick);
      }
      
      override protected function initView() : void
      {
         super.initView();
         _btn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.smallMapInfo.btn");
         _btn.tipData = LanguageMgr.GetTranslation("tank.room.RoomIIMapSet.room2");
         addChild(_btn);
      }
      
      private function __onClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(RoomManager.Instance.current.isOpenBoss && !RoomManager.Instance.current.selfRoomPlayer.isViewer)
         {
            showAlert();
            return;
         }
         var mapChooser:DungeonChooseMapFrame = new DungeonChooseMapFrame();
         mapChooser.show();
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
      
      override public function set info(value:RoomInfo) : void
      {
         .super.info = value;
         if(_info)
         {
            _info.selfRoomPlayer.addEventListener("isHostChange",__update);
         }
         if(_info && _info.selfRoomPlayer.isHost && _info.mapId != 12016 && _info.mapId != 70002 && _info.mapId != 70020)
         {
            buttonMode = true;
            _btn.visible = true;
            addEventListener("click",__onClick);
         }
         else
         {
            buttonMode = false;
            _btn.visible = false;
            removeEventListener("click",__onClick);
         }
      }
      
      private function __update(evt:RoomPlayerEvent) : void
      {
         if(_info.selfRoomPlayer.isHost && _info.mapId != 12016 && _info.mapId != 70002 && _info.mapId != 70020)
         {
            buttonMode = true;
            _btn.visible = true;
            addEventListener("click",__onClick);
         }
         else
         {
            buttonMode = false;
            _btn.visible = false;
            removeEventListener("click",__onClick);
         }
      }
      
      override protected function updateView() : void
      {
         super.updateView();
         if(_info.selfRoomPlayer.isHost && _info.mapId != 12016 && _info.mapId != 70002 && _info.mapId != 70020)
         {
            buttonMode = true;
            _btn.visible = true;
            addEventListener("click",__onClick);
         }
         else
         {
            buttonMode = false;
            _btn.visible = false;
            removeEventListener("click",__onClick);
         }
      }
      
      override protected function solvePath() : String
      {
         if(_info && _info.mapId > 0)
         {
            if(_info.hardLevel == 4)
            {
               return PathManager.SITE_MAIN + "image/map/" + _info.mapId.toString() + "/samll_map_e.png";
            }
            return PathManager.SITE_MAIN + "image/map/" + _info.mapId.toString() + "/samll_map.png";
         }
         return PathManager.SITE_MAIN + "image/map/" + "10000" + "/samll_map.png";
      }
      
      override public function dispose() : void
      {
         removeEvents();
         _btn.dispose();
         _btn = null;
         super.dispose();
      }
   }
}
