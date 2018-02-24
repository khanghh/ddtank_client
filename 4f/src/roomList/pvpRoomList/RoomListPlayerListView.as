package roomList.pvpRoomList
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.data.player.SelfInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.buff.BuffControl;
   import ddt.view.buff.BuffControlManager;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ICharacter;
   import ddt.view.common.LevelIcon;
   import ddt.view.common.MarriedIcon;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import guardCore.GuardCoreIcon;
   import guardCore.GuardCoreManager;
   import hall.event.NewHallEvent;
   import kingBless.KingBlessManager;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   import vip.VipController;
   
   public class RoomListPlayerListView extends Sprite implements Disposeable
   {
       
      
      private var _selfInfo:SelfInfo;
      
      protected var _characterBg:MovieClip;
      
      protected var _propbg:MovieClip;
      
      protected var _listbg:MovieClip;
      
      protected var _listbg2:DisplayObject;
      
      private var _player:ICharacter;
      
      private var _levelIcon:LevelIcon;
      
      private var _iconContainer:VBox;
      
      private var _guardCoreIcon:GuardCoreIcon;
      
      private var _nickNameText:FilterFrameText;
      
      private var _consortiaNameText:FilterFrameText;
      
      private var _repute:FilterFrameText;
      
      private var _reputeText:FilterFrameText;
      
      private var _geste:FilterFrameText;
      
      private var _gesteText:FilterFrameText;
      
      protected var _level:FilterFrameText;
      
      protected var _sex:FilterFrameText;
      
      private var _playerList:ListPanel;
      
      private var _data:DictionaryData;
      
      private var _currentItem:RoomListPlayerItem;
      
      private var _marriedIcon:MarriedIcon;
      
      protected var _buffbgVec:Vector.<Bitmap>;
      
      private var _buff:BuffControl;
      
      private var _vipName:GradientText;
      
      public function RoomListPlayerListView(param1:DictionaryData){super();}
      
      public function set type(param1:int) : void{}
      
      protected function initbg() : void{}
      
      protected function initView() : void{}
      
      private function initEvent() : void{}
      
      private function __updatePlayer(param1:DictionaryEvent) : void{}
      
      private function __addPlayer(param1:DictionaryEvent) : void{}
      
      private function __removePlayer(param1:DictionaryEvent) : void{}
      
      private function upSelfItem() : void{}
      
      private function __itemClick(param1:ListItemEvent) : void{}
      
      private function getInsertIndex(param1:PlayerInfo) : int{return 0;}
      
      public function dispose() : void{}
   }
}
