package worldboss.player
{
   import ddt.data.player.PlayerInfo;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import worldboss.event.WorldBossScenePlayerEvent;
   
   public class PlayerVO extends EventDispatcher
   {
       
      
      private var _playerPos:Point;
      
      private var _playerNickName:String;
      
      private var _playerSex:Boolean;
      
      private var _playerInfo:PlayerInfo;
      
      private var _walkPath:Array;
      
      private var _sceneCharacterDirection:SceneCharacterDirection;
      
      private var _playerDirection:int = 3;
      
      private var _playerMoveSpeed:Number = 0.15;
      
      private var _reviveCD:int;
      
      private var _buffs:Array;
      
      public var currentWalkStartPoint:Point;
      
      private var _playerStauts:int = 1;
      
      private var _buffLevel:int = 0;
      
      private var _buffInjure:int = 0;
      
      private var _myDamage:int = 0;
      
      private var _myHonor:int = 0;
      
      public function PlayerVO(){super();}
      
      public function get buffLevel() : int{return 0;}
      
      public function set buffLevel(param1:int) : void{}
      
      public function set myDamage(param1:int) : void{}
      
      public function get myDamage() : int{return 0;}
      
      public function set myHonor(param1:int) : void{}
      
      public function get myHonor() : int{return 0;}
      
      public function get buffInjure() : int{return 0;}
      
      public function set buffInjure(param1:int) : void{}
      
      public function set playerStauts(param1:int) : void{}
      
      public function get playerStauts() : int{return 0;}
      
      public function get playerPos() : Point{return null;}
      
      public function set playerPos(param1:Point) : void{}
      
      public function get reviveCD() : int{return 0;}
      
      public function set reviveCD(param1:int) : void{}
      
      public function get buffs() : Array{return null;}
      
      public function set buffs(param1:Array) : void{}
      
      public function set buffID(param1:int) : void{}
      
      public function get playerInfo() : PlayerInfo{return null;}
      
      public function set playerInfo(param1:PlayerInfo) : void{}
      
      public function get walkPath() : Array{return null;}
      
      public function set walkPath(param1:Array) : void{}
      
      public function get scenePlayerDirection() : SceneCharacterDirection{return null;}
      
      public function set scenePlayerDirection(param1:SceneCharacterDirection) : void{}
      
      public function get playerDirection() : int{return 0;}
      
      public function set playerDirection(param1:int) : void{}
      
      public function get playerMoveSpeed() : Number{return 0;}
      
      public function set playerMoveSpeed(param1:Number) : void{}
      
      public function clone() : PlayerVO{return null;}
      
      public function dispose() : void{}
   }
}
