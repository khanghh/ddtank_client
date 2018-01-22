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
      
      public function PlayerVO()
      {
         _walkPath = [];
         _sceneCharacterDirection = SceneCharacterDirection.RT;
         _buffs = [];
         super();
      }
      
      public function get buffLevel() : int
      {
         return _buffLevel;
      }
      
      public function set buffLevel(param1:int) : void
      {
         _buffLevel = param1;
      }
      
      public function set myDamage(param1:int) : void
      {
         _myDamage = param1;
      }
      
      public function get myDamage() : int
      {
         return _myDamage;
      }
      
      public function set myHonor(param1:int) : void
      {
         _myHonor = param1;
      }
      
      public function get myHonor() : int
      {
         return _myHonor;
      }
      
      public function get buffInjure() : int
      {
         return _buffInjure;
      }
      
      public function set buffInjure(param1:int) : void
      {
         _buffInjure = param1;
      }
      
      public function set playerStauts(param1:int) : void
      {
         _playerStauts = param1;
      }
      
      public function get playerStauts() : int
      {
         return _playerStauts;
      }
      
      public function get playerPos() : Point
      {
         return _playerPos;
      }
      
      public function set playerPos(param1:Point) : void
      {
         _playerPos = param1;
         if(_playerInfo)
         {
            dispatchEvent(new WorldBossScenePlayerEvent("playerPosChange",_playerInfo.ID));
         }
      }
      
      public function get reviveCD() : int
      {
         return _reviveCD;
      }
      
      public function set reviveCD(param1:int) : void
      {
         _reviveCD = param1;
      }
      
      public function get buffs() : Array
      {
         return _buffs;
      }
      
      public function set buffs(param1:Array) : void
      {
         _buffs = param1;
      }
      
      public function set buffID(param1:int) : void
      {
         if(!_buffs)
         {
            _buffs = [];
         }
         _buffs.push(param1);
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return _playerInfo;
      }
      
      public function set playerInfo(param1:PlayerInfo) : void
      {
         _playerInfo = param1;
      }
      
      public function get walkPath() : Array
      {
         return _walkPath;
      }
      
      public function set walkPath(param1:Array) : void
      {
         _walkPath = param1;
      }
      
      public function get scenePlayerDirection() : SceneCharacterDirection
      {
         if(!_sceneCharacterDirection)
         {
            _sceneCharacterDirection = SceneCharacterDirection.RT;
         }
         return _sceneCharacterDirection;
      }
      
      public function set scenePlayerDirection(param1:SceneCharacterDirection) : void
      {
         _sceneCharacterDirection = param1;
         var _loc2_:* = _sceneCharacterDirection;
         if(SceneCharacterDirection.RT !== _loc2_)
         {
            if(SceneCharacterDirection.LT !== _loc2_)
            {
               if(SceneCharacterDirection.RB !== _loc2_)
               {
                  if(SceneCharacterDirection.LB === _loc2_)
                  {
                     _playerDirection = 4;
                  }
               }
               else
               {
                  _playerDirection = 3;
               }
            }
            else
            {
               _playerDirection = 2;
            }
         }
         else
         {
            _playerDirection = 1;
         }
      }
      
      public function get playerDirection() : int
      {
         return _playerDirection;
      }
      
      public function set playerDirection(param1:int) : void
      {
         _playerDirection = param1;
         switch(int(_playerDirection) - 1)
         {
            case 0:
               _sceneCharacterDirection = SceneCharacterDirection.RT;
               break;
            case 1:
               _sceneCharacterDirection = SceneCharacterDirection.LT;
               break;
            case 2:
               _sceneCharacterDirection = SceneCharacterDirection.RB;
               break;
            case 3:
               _sceneCharacterDirection = SceneCharacterDirection.LB;
         }
      }
      
      public function get playerMoveSpeed() : Number
      {
         return _playerMoveSpeed;
      }
      
      public function set playerMoveSpeed(param1:Number) : void
      {
         if(_playerMoveSpeed == param1)
         {
            return;
         }
         _playerMoveSpeed = param1;
         dispatchEvent(new WorldBossScenePlayerEvent("playerMoveSpeedChange",_playerInfo.ID));
      }
      
      public function clone() : PlayerVO
      {
         var _loc1_:PlayerVO = new PlayerVO();
         _loc1_.playerInfo = _playerInfo;
         _loc1_.playerPos = _playerPos;
         _loc1_.walkPath = _walkPath;
         _loc1_.playerDirection = _playerDirection;
         _loc1_.playerMoveSpeed = _playerMoveSpeed;
         return _loc1_;
      }
      
      public function dispose() : void
      {
         while(_walkPath && _walkPath.length > 0)
         {
            _walkPath.shift();
         }
         _walkPath = null;
         _playerPos = null;
         _sceneCharacterDirection = null;
      }
   }
}
