package room.view.roomView
{
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   import room.RoomManager;
   import room.model.RoomInfo;
   import room.view.RoomPlayerItem;
   import room.view.RoomViewerItem;
   
   public class TeamRoomView extends MatchRoomView
   {
       
      
      public function TeamRoomView(info:RoomInfo)
      {
         super(info);
      }
      
      override protected function initView() : void
      {
         super.initView();
         if(_leagueTxt)
         {
            _leagueTxt.visible = false;
         }
         _crossZoneBtn.enable = false;
         _crossZoneBtn.selected = true;
      }
      
      override protected function updateButtons() : void
      {
         super.updateButtons();
         _crossZoneBtn.enable = false;
      }
      
      override protected function __startClick(evt:MouseEvent) : void
      {
         var i:int = 0;
         var num:int = 0;
         for(i = 0; i < 4; )
         {
            if(_playerItems[i].info)
            {
               num++;
            }
            i++;
         }
         if(num < 2)
         {
            SoundManager.instance.play("008");
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("teamBattle.room.peopleAlert"));
            return;
         }
         super.__startClick(evt);
      }
      
      override protected function initPlayerItems() : void
      {
         var i:int = 0;
         var item:* = null;
         var viewerItem:* = null;
         for(i = 0; i < _playerItems.length; )
         {
            item = _playerItems[i] as RoomPlayerItem;
            item.info = _info.findPlayerByPlace(i);
            item.opened = _info.placesState[i] != 0;
            i++;
         }
         if(isViewerRoom)
         {
            for(i = 0; i < 2; i++)
            {
               if(_viewerItems && _viewerItems[i])
               {
                  viewerItem = _viewerItems[i] as RoomViewerItem;
                  if(RoomManager.SPECIAL_BOSS_MAPID.indexOf(_info.mapId) > -1)
                  {
                     viewerItem.info = null;
                     viewerItem.opened = false;
                  }
                  else
                  {
                     viewerItem.info = _info.findPlayerByPlace(i + 8);
                     viewerItem.opened = false;
                  }
               }
            }
         }
      }
   }
}
