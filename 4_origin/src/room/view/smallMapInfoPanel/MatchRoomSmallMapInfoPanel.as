package room.view.smallMapInfoPanel
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import room.events.RoomPlayerEvent;
   import room.model.RoomInfo;
   import room.view.chooseMap.MatchRoomSetView;
   
   public class MatchRoomSmallMapInfoPanel extends BaseSmallMapInfoPanel
   {
       
      
      private var _teamPic:Bitmap;
      
      private var _btn:SimpleBitmapButton;
      
      protected var _timeType:ScaleFrameImage;
      
      public function MatchRoomSmallMapInfoPanel()
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
         _teamPic = ComponentFactory.Instance.creatBitmap("asset.ddtroom.smallMapInfoPanel.iconAsset");
         addChild(_teamPic);
         _timeType = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.smallMapInfo.seconds");
         addChild(_timeType);
         _timeType.setFrame(1);
         _btn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.smallMapInfo.btn");
         _btn.tipData = LanguageMgr.GetTranslation("tank.room.RoomIIMapSet.room2");
         addChild(_btn);
      }
      
      override public function set info(param1:RoomInfo) : void
      {
         .super.info = param1;
         if(_info)
         {
            _info.selfRoomPlayer.addEventListener("isHostChange",__update);
         }
         if(_info && _info.selfRoomPlayer.isHost)
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
         if(_info && (_info.gameMode == 41 || _info.gameMode == 42))
         {
            buttonMode = false;
            _btn.visible = false;
            removeEventListener("click",__onClick);
         }
      }
      
      private function __update(param1:RoomPlayerEvent) : void
      {
         if(_info.selfRoomPlayer.isHost)
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
         if(_info && (_info.gameMode == 41 || _info.gameMode == 42))
         {
            buttonMode = false;
            _btn.visible = false;
            removeEventListener("click",__onClick);
         }
      }
      
      public function set _actionStatus(param1:Boolean) : void
      {
         if(param1)
         {
            buttonMode = true;
            addEventListener("click",__onClick);
         }
         else
         {
            buttonMode = false;
            removeEventListener("click",__onClick);
         }
         if(_info && (_info.gameMode == 41 || _info.gameMode == 42))
         {
            buttonMode = false;
            _btn.visible = false;
            removeEventListener("click",__onClick);
         }
      }
      
      protected function __onClick(param1:MouseEvent) : void
      {
         if(_info.gameMode == 58)
         {
            return;
         }
         SoundManager.instance.play("008");
         var _loc2_:MatchRoomSetView = new MatchRoomSetView();
         _loc2_.showMatchRoomSetView();
      }
      
      override public function dispose() : void
      {
         removeEvents();
         _timeType.dispose();
         _timeType = null;
         removeChild(_teamPic);
         _teamPic.bitmapData.dispose();
         _teamPic = null;
         _btn.dispose();
         _btn = null;
         super.dispose();
      }
      
      override protected function updateView() : void
      {
         super.updateView();
         _timeType.setFrame(!!_info?_info.timeType:1);
      }
   }
}
