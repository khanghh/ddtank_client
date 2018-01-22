package room.view.roomView
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.SelfInfo;
   import ddt.events.RoomEvent;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import gameCommon.view.DefyAfficheViewFrame;
   import room.RoomManager;
   import room.model.RoomInfo;
   import room.view.PVPBattleRoomRightPropView;
   import room.view.RoomPlayerItem;
   import room.view.smallMapInfoPanel.ChallengeRoomSmallMapInfoPanel;
   
   public class ChallengeRoomView extends BaseRoomView implements Disposeable
   {
      
      public static const PLAYER_POS_CHANGE:String = "playerposchange";
       
      
      private var _curSelectType:int = -1;
      
      private var _bg:MovieClip;
      
      private var _btnSwitchTeam:BaseButton;
      
      private var _playerItemContainers:Vector.<SimpleTileList>;
      
      private var _smallMapInfoPanel:ChallengeRoomSmallMapInfoPanel;
      
      private var _blueTeam:Bitmap;
      
      private var _redTeam:Bitmap;
      
      private var _blueTeamBitmap:MovieClip;
      
      private var _redTeamBitmap:MovieClip;
      
      private var _self:SelfInfo;
      
      public function ChallengeRoomView(param1:RoomInfo){super(null);}
      
      override public function dispose() : void{}
      
      override protected function updateButtons() : void{}
      
      override protected function initEvents() : void{}
      
      private function __onMapChangedHandler(param1:RoomEvent) : void{}
      
      private function initMapView() : void{}
      
      private function clearRoomProView() : void{}
      
      private function createPVPBattleProView() : void{}
      
      private function createRoomProView() : void{}
      
      private function __switchProViewHandler(param1:Event) : void{}
      
      override protected function __prepareClick(param1:MouseEvent) : void{}
      
      override protected function checkCanStartGame() : Boolean{return false;}
      
      override protected function initTileList() : void{}
      
      override protected function initView() : void{}
      
      private function openDefyAffiche() : void{}
      
      override protected function __updatePlayerItems(param1:RoomEvent) : void{}
      
      override protected function removeEvents() : void{}
      
      private function __switchTeam(param1:MouseEvent) : void{}
   }
}
