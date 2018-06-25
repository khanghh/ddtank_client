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
      
      public function set buffLevel(value:int) : void
      {
         _buffLevel = value;
      }
      
      public function set myDamage(value:int) : void
      {
         _myDamage = value;
      }
      
      public function get myDamage() : int
      {
         return _myDamage;
      }
      
      public function set myHonor(value:int) : void
      {
         _myHonor = value;
      }
      
      public function get myHonor() : int
      {
         return _myHonor;
      }
      
      public function get buffInjure() : int
      {
         return _buffInjure;
      }
      
      public function set buffInjure(value:int) : void
      {
         _buffInjure = value;
      }
      
      public function set playerStauts(value:int) : void
      {
         _playerStauts = value;
      }
      
      public function get playerStauts() : int
      {
         return _playerStauts;
      }
      
      public function get playerPos() : Point
      {
         return _playerPos;
      }
      
      public function set playerPos(value:Point) : void
      {
         _playerPos = value;
         if(_playerInfo)
         {
            dispatchEvent(new WorldBossScenePlayerEvent("playerPosChange",_playerInfo.ID));
         }
      }
      
      public function get reviveCD() : int
      {
         return _reviveCD;
      }
      
      public function set reviveCD(value:int) : void
      {
         _reviveCD = value;
      }
      
      public function get buffs() : Array
      {
         return _buffs;
      }
      
      public function set buffs(value:Array) : void
      {
         _buffs = value;
      }
      
      public function set buffID(value:int) : void
      {
         if(!_buffs)
         {
            _buffs = [];
         }
         _buffs.push(value);
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return _playerInfo;
      }
      
      public function set playerInfo(value:PlayerInfo) : void
      {
         _playerInfo = value;
      }
      
      public function get walkPath() : Array
      {
         return _walkPath;
      }
      
      public function set walkPath(value:Array) : void
      {
         _walkPath = value;
      }
      
      public function get scenePlayerDirection() : SceneCharacterDirection
      {
         if(!_sceneCharacterDirection)
         {
            _sceneCharacterDirection = SceneCharacterDirection.RT;
         }
         return _sceneCharacterDirection;
      }
      
      public function set scenePlayerDirection(value:SceneCharacterDirection) : void
      {
         _sceneCharacterDirection = value;
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
      
      public function set playerDirection(value:int) : void
      {
         _playerDirection = value;
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
      
      public function set playerMoveSpeed(value:Number) : void
      {
         if(_playerMoveSpeed == value)
         {
            return;
         }
         _playerMoveSpeed = value;
         dispatchEvent(new WorldBossScenePlayerEvent("playerMoveSpeedChange",_playerInfo.ID));
      }
      
      public function clone() : PlayerVO
      {
         var playerVO:PlayerVO = new PlayerVO();
         playerVO.playerInfo = _playerInfo;
         playerVO.playerPos = _playerPos;
         playerVO.walkPath = _walkPath;
         playerVO.playerDirection = _playerDirection;
         playerVO.playerMoveSpeed = _playerMoveSpeed;
         return playerVO;
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
