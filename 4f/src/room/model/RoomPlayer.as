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
      
      public function RoomPlayer(param1:PlayerInfo, param2:Boolean = true){super();}
      
      public function get isViewer() : Boolean{return false;}
      
      private function initEvents() : void{}
      
      private function removeEvents() : void{}
      
      private function __webSpeedHandler(param1:WebSpeedEvent) : void{}
      
      public function get webSpeedInfo() : WebSpeedInfo{return null;}
      
      public function hasDeputyWeapon() : Boolean{return false;}
      
      public function get team() : int{return 0;}
      
      public function set team(param1:int) : void{}
      
      public function get place() : int{return 0;}
      
      public function set place(param1:int) : void{}
      
      public function get isFirstIn() : Boolean{return false;}
      
      public function set isFirstIn(param1:Boolean) : void{}
      
      public function get playerInfo() : PlayerInfo{return null;}
      
      public function get isSelf() : Boolean{return false;}
      
      public function dispose() : void{}
      
      public function get character3D() : ShowCharacter3D{return null;}
      
      public function get movie3D() : GameCharacter3D{return null;}
      
      public function get isHost() : Boolean{return false;}
      
      public function set isHost(param1:Boolean) : void{}
      
      public function get isReady() : Boolean{return false;}
      
      public function set isReady(param1:Boolean) : void{}
      
      public function get progress() : Number{return 0;}
      
      public function set progress(param1:Number) : void{}
      
      public function get currentWeapInfo() : WeaponInfo{return null;}
      
      public function get currentDeputyWeaponInfo() : DeputyWeaponInfo{return null;}
      
      public function get character() : ShowCharacter{return null;}
      
      public function get movie() : GameCharacter{return null;}
      
      public function get roomCharater() : RoomCharacter{return null;}
      
      public function resetCharacter() : void{}
      
      public function claerMovie3D() : void{}
   }
}
