package room.view.states
{
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.ui.LayerManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.states.BaseStateView;
   import ddt.utils.PositionUtils;
   import ddt.view.MainToolBar;
   import room.RoomManager;
   import room.view.roomView.DungeonRoomView;
   import trainer.view.NewHandContainer;
   
   public class DungeonRoomState extends BaseRoomState
   {
       
      
      public function DungeonRoomState()
      {
         super();
      }
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         SocketManager.Instance.out.getPlayerSpecialProperty(3);
         _roomView = new DungeonRoomView(RoomManager.Instance.current);
         PositionUtils.setPos(_roomView,"asset.ddtroom.matchroomstate.pos");
         addChild(_roomView);
         super.enter(prev,data);
         if(!PlayerManager.Instance.Self.isDungeonGuideFinish(120))
         {
            NoviceDataManager.instance.saveNoviceData(1040,PathManager.userName(),PathManager.solveRequestPath());
            SocketManager.Instance.out.syncWeakStep(120);
         }
         if(!PlayerManager.Instance.Self.isDungeonGuideFinish(121))
         {
            NewHandContainer.Instance.showArrow(130,0,"guide.dungeon.step2ArrowPos","asset.trainer.dungeonGuide2Txt","guide.dungeon.step2TipPos",LayerManager.Instance.getLayerByType(2));
         }
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         NewHandContainer.Instance.clearArrowByID(130);
         MainToolBar.Instance.hide();
         if(_info && _info.selfRoomPlayer.isHost)
         {
            if(RoomManager.Instance.current.isOpenBoss)
            {
               if(RoomManager.SPECIAL_BOSS_MAPID.indexOf(_info.mapId) >= 0)
               {
                  GameInSocketOut.sendGameRoomSetUp(10000,123,true,_info.roomPass,_info.roomName,1,_info.hardLevel,0,false,_info.mapId);
               }
               else
               {
                  GameInSocketOut.sendGameRoomSetUp(10000,4,true,_info.roomPass,_info.roomName,1,_info.hardLevel,0,false,_info.mapId);
               }
            }
            else if(RoomManager.SPECIAL_BOSS_MAPID.indexOf(_info.mapId) >= 0)
            {
               GameInSocketOut.sendGameRoomSetUp(10000,123,false,_info.roomPass,_info.roomName,1,0,0,false,0);
            }
            else
            {
               GameInSocketOut.sendGameRoomSetUp(10000,4,false,_info.roomPass,_info.roomName,1,0,0,false,0);
            }
         }
         super.leaving(next);
      }
      
      override public function getType() : String
      {
         return "dungeonRoom";
      }
      
      override public function getBackType() : String
      {
         return "dungeon";
      }
   }
}
