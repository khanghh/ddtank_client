package room.model
{
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.WebSpeedEvent;
   import ddt.manager.ItemManager;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.GameCharacter;
   import ddt.view.character.RoomCharacter;
   import ddt.view.character.ShowCharacter;
   import ddt.view.characterStarling.GameCharacter3D;
   import ddt.view.characterStarling.ShowCharacter3D;
   import flash.events.EventDispatcher;
   import room.events.RoomPlayerEvent;
   
   [Event(name="ready_change",type="room.events.RoomPlayerEvent")]
   [Event(name="is_host_change",type="room.events.RoomPlayerEvent")]
   public class RoomPlayer extends EventDispatcher
   {
      
      public static const BLUE_TEAM:uint = 1;
      
      public static const RED_TEAM:uint = 2;
       
      
      public var horseSkillEquipList:Array;
      
      public var battleSkillEquipList:Array;
      
      private var _playerInfo:PlayerInfo;
      
      private var _team:int;
      
      private var _place:int;
      
      private var _isHost:Boolean;
      
      private var _isReady:Boolean;
      
      private var _webSpeedInfo:WebSpeedInfo;
      
      private var _progress:Number;
      
      private var _isFirstIn:Boolean;
      
      private var _character3D:ShowCharacter3D;
      
      private var _movie3D:GameCharacter3D;
      
      private var _trailEliteLevel:int;
      
      private var _character:ShowCharacter;
      
      private var _movie:GameCharacter;
      
      private var _roomCharater:RoomCharacter;
      
      public function RoomPlayer(playerInfo:PlayerInfo, webFlag:Boolean = true)
      {
         super();
         _playerInfo = playerInfo;
         initEvents();
         if(webFlag)
         {
            _webSpeedInfo = new WebSpeedInfo(_playerInfo.webSpeed);
         }
      }
      
      public function get isViewer() : Boolean
      {
         return _place >= 8;
      }
      
      private function initEvents() : void
      {
         _playerInfo.addEventListener("stateChange",__webSpeedHandler);
      }
      
      private function removeEvents() : void
      {
         if(_playerInfo)
         {
            _playerInfo.removeEventListener("stateChange",__webSpeedHandler);
         }
      }
      
      private function __webSpeedHandler(evt:WebSpeedEvent) : void
      {
         _webSpeedInfo.delay = _playerInfo.webSpeed;
      }
      
      public function get webSpeedInfo() : WebSpeedInfo
      {
         return _webSpeedInfo;
      }
      
      public function hasDeputyWeapon() : Boolean
      {
         return _playerInfo.DeputyWeaponID > 0;
      }
      
      public function get team() : int
      {
         return _team;
      }
      
      public function set team(value:int) : void
      {
         _team = value;
      }
      
      public function get place() : int
      {
         return _place;
      }
      
      public function set place(value:int) : void
      {
         _place = value;
      }
      
      public function get isFirstIn() : Boolean
      {
         return _isFirstIn;
      }
      
      public function set isFirstIn(value:Boolean) : void
      {
         _isFirstIn = value;
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return _playerInfo;
      }
      
      public function get isSelf() : Boolean
      {
         return playerInfo is SelfInfo;
      }
      
      public function dispose() : void
      {
         removeEvents();
         _playerInfo = null;
         _webSpeedInfo = null;
         if(_character)
         {
            _character.dispose();
         }
         _character = null;
         if(_movie)
         {
            _movie.dispose();
         }
         _movie = null;
         if(_roomCharater)
         {
            _roomCharater.dispose();
         }
         _roomCharater = null;
         StarlingObjectUtils.disposeObject(_movie3D);
         StarlingObjectUtils.disposeObject(_character3D);
         _movie3D = null;
         _character3D = null;
      }
      
      public function get character3D() : ShowCharacter3D
      {
         if(_character3D == null)
         {
            _character3D = CharactoryFactory.createCharacter(_playerInfo,"show3d",true) as ShowCharacter3D;
         }
         return _character3D;
      }
      
      public function get movie3D() : GameCharacter3D
      {
         if(_movie3D == null)
         {
            _movie3D = CharactoryFactory.createCharacter(_playerInfo,"game3d") as GameCharacter3D;
         }
         return _movie3D;
      }
      
      public function get isHost() : Boolean
      {
         return _isHost;
      }
      
      public function set isHost(value:Boolean) : void
      {
         _isHost = value;
         dispatchEvent(new RoomPlayerEvent("isHostChange"));
      }
      
      public function get isReady() : Boolean
      {
         return _isReady;
      }
      
      public function set isReady(value:Boolean) : void
      {
         _isReady = value;
         dispatchEvent(new RoomPlayerEvent("readyChange"));
      }
      
      public function get progress() : Number
      {
         return _progress;
      }
      
      public function set progress(value:Number) : void
      {
         _progress = value;
         dispatchEvent(new RoomPlayerEvent("progressChange"));
      }
      
      public function get currentWeapInfo() : WeaponInfo
      {
         return new WeaponInfo(ItemManager.Instance.getTemplateById(_playerInfo.WeaponID));
      }
      
      public function get currentDeputyWeaponInfo() : DeputyWeaponInfo
      {
         return new DeputyWeaponInfo(ItemManager.Instance.getTemplateById(_playerInfo.DeputyWeaponID));
      }
      
      public function get character() : ShowCharacter
      {
         if(_character == null)
         {
            _character = CharactoryFactory.createCharacter(_playerInfo,"show",true) as ShowCharacter;
         }
         return _character;
      }
      
      public function get movie() : GameCharacter
      {
         if(_movie == null)
         {
            _movie = CharactoryFactory.createCharacter(_playerInfo,"game") as GameCharacter;
         }
         return _movie;
      }
      
      public function get roomCharater() : RoomCharacter
      {
         if(_roomCharater == null)
         {
            _roomCharater = CharactoryFactory.createCharacter(_playerInfo,"room") as RoomCharacter;
         }
         _roomCharater.showGun = true;
         return _roomCharater;
      }
      
      public function resetCharacter() : void
      {
         if(_character)
         {
            _character.x = 0;
            _character.y = 0;
            _character.doAction("stand");
         }
      }
      
      public function claerMovie3D() : void
      {
         StarlingObjectUtils.disposeObject(_movie3D);
         StarlingObjectUtils.disposeObject(_character3D);
         _movie3D = null;
         _character3D = null;
      }
   }
}
