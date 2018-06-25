package starling.scene.hall.player
{
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import hall.player.vo.PlayerVO;
   import horse.HorseManager;
   import road7th.StarlingMain;
   import starling.display.Image;
   import starling.display.sceneCharacter.SceneCharacterActionPointSet;
   import starling.display.sceneCharacter.SceneCharacterActionSet;
   import starling.display.sceneCharacter.SceneCharacterActionType;
   import starling.display.sceneCharacter.SceneCharacterPlayerBase;
   import starling.display.sceneCharacter.SceneCharacterState;
   import starling.display.sceneCharacter.SceneCharacterTextureItem;
   import starling.display.sceneCharacter.SceneCharacterTextureSet;
   import starling.display.sceneCharacter.event.SceneCharacterEvent;
   import starling.events.Event;
   
   public class HallPlayerBase extends SceneCharacterPlayerBase
   {
       
      
      private var _playerInfo:PlayerInfo;
      
      private var _playerVO:PlayerVO;
      
      private var _playerAsset:HallPlayerAsset;
      
      public function HallPlayerBase(playerVO:PlayerVO)
      {
         _playerVO = playerVO;
         _playerInfo = _playerVO.playerInfo;
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         sceneCharacterDirection = _playerVO.scenePlayerDirection;
         setSceneCharacterDirectionDefault = _playerVO.scenePlayerDirection;
         showDefault();
         _playerAsset = new HallPlayerAsset(_playerInfo);
         _playerAsset.addEventListener("complete",__onPlayerAssetComplete);
         _playerAsset.load();
      }
      
      override protected function initEvent() : void
      {
         _playerInfo.addEventListener("propertychange",__onStyleChange);
         super.initEvent();
      }
      
      override protected function removeEvent() : void
      {
         _playerInfo.removeEventListener("propertychange",__onStyleChange);
         super.removeEvent();
      }
      
      private function showDefault() : void
      {
         var player:Image = StarlingMain.instance.createImage("image_deafult_player");
         player.x = 35;
         player.y = 30;
         _characterPlayer.addChild(player);
         _isDefaultCharacter = true;
      }
      
      protected function __onStyleChange(evt:PlayerPropertyEvent) : void
      {
         if(evt.changedProperties["Style"] || evt.changedProperties["Colors"])
         {
            _sceneCharacterState.removeTexture("head");
            _playerAsset.resetLoader();
            _playerAsset.loadHead();
         }
         if(evt.changedProperties["mountsType"])
         {
            if(_playerInfo.IsMounts)
            {
               _playerAsset.resetLoader();
               _playerAsset.loadBody();
               _playerAsset.loadMount();
            }
            else if(!_isDefaultCharacter)
            {
               sceneCharacterActionState = _sceneCharacterState.setSceneCharacterActionState;
            }
         }
      }
      
      private function __onPlayerAssetComplete(e:Event) : void
      {
         _isDefaultCharacter = false;
         resetPlayerAsset();
      }
      
      protected function resetPlayerAsset() : void
      {
         var head:* = null;
         var body:* = null;
         var mount:* = null;
         var state:* = null;
         if(_playerAsset.isFirstLoad())
         {
            setCharacterData();
            changeCharacterDirection();
            initSceneCharacterState();
            if(sceneCharacterDefaultActionState != "")
            {
               sceneCharacterActionState = sceneCharacterDefaultActionState;
            }
         }
         else
         {
            if(_playerAsset.isResetByAssetName(_playerAsset.headAssetName))
            {
               head = new SceneCharacterTextureItem("head",_playerAsset.headAssetName,3,1,3,120,150,0);
               _sceneCharacterState.updateTexture(head);
            }
            if(_playerAsset.isResetByAssetName(_playerAsset.bodyAssetName))
            {
               body = new SceneCharacterTextureItem("body",_playerAsset.bodyAssetName,17,3,7,120,175,4);
               _sceneCharacterState.updateTexture(body);
            }
            if(_playerAsset.isResetByAssetName(_playerAsset.mountsAssetName))
            {
               mount = new SceneCharacterTextureItem("mount",_playerAsset.mountsAssetName,7,0,0,500,400,2,1);
               _sceneCharacterState.updateTexture(mount);
               state = _sceneCharacterState.setSceneCharacterActionState;
               if(state == "walkRide" || state == "walkSit" || state == "standRide" || state == "standSit")
               {
                  setSceneCharacterAction(state);
                  setSceneCharacterActionPoint(state);
               }
               sceneCharacterActionState = _sceneCharacterState.setSceneCharacterActionState;
            }
            _sceneCharacterState.resetSceneCharacterDraw();
         }
      }
      
      protected function setCharacterData() : void
      {
         var actionSet:SceneCharacterActionSet = getSceneCharacterActionSet();
         var actionPointSet:SceneCharacterActionPointSet = getSceneCharacterActionPointSet();
         var textureSet:SceneCharacterTextureSet = getSceneCharacterTextureSet();
         var playerDraw:HallPlayerDraw = new HallPlayerDraw(_playerInfo);
         var state:SceneCharacterState = new SceneCharacterState(textureSet,actionSet,actionPointSet,playerDraw);
         this.sceneCharacterState = state;
      }
      
      protected function getSceneCharacterActionSet() : SceneCharacterActionSet
      {
         var actionSet:SceneCharacterActionSet = new SceneCharacterActionSet();
         actionSet.push(SceneCharacterActionType.ACTION_HEAD_STAND_FRONT);
         actionSet.push(SceneCharacterActionType.ACTION_BODY_STAND_FRONT);
         actionSet.push(SceneCharacterActionType.ACTION_STAND_BACK_ACTION);
         actionSet.push(SceneCharacterActionType.ACTION_BODY_STAND_BACK);
         actionSet.push(SceneCharacterActionType.ACTION_HEAD_WALK_FRONT);
         actionSet.push(SceneCharacterActionType.ACTION_BODY_WALK_FRONT);
         actionSet.push(SceneCharacterActionType.ACTION_HEAD_WALK_BACK);
         actionSet.push(SceneCharacterActionType.ACTION_BODY_WALK_BACK);
         return actionSet;
      }
      
      protected function getSceneCharacterActionPointSet() : SceneCharacterActionPointSet
      {
         var actionPointSet:SceneCharacterActionPointSet = new SceneCharacterActionPointSet();
         return actionPointSet;
      }
      
      protected function getSceneCharacterTextureSet() : SceneCharacterTextureSet
      {
         var mount:* = null;
         var textureSet:SceneCharacterTextureSet = new SceneCharacterTextureSet();
         var head:SceneCharacterTextureItem = new SceneCharacterTextureItem("head",_playerAsset.headAssetName,3,1,3,120,150,0);
         var body:SceneCharacterTextureItem = new SceneCharacterTextureItem("body",_playerAsset.bodyAssetName,17,3,7,120,175,4);
         textureSet.push(head);
         textureSet.push(body);
         if(_playerInfo.IsMounts)
         {
            mount = new SceneCharacterTextureItem("mount",_playerAsset.mountsAssetName,7,0,0,500,400,2,1);
            textureSet.push(mount);
         }
         return textureSet;
      }
      
      override public function set sceneCharacterActionState(value:String) : void
      {
         var state:* = value;
         if(_playerVO.playerInfo.IsMounts)
         {
            if(HorseManager.instance.getIsSit(_playerVO.playerInfo.MountsType))
            {
               if(value == "walkBack" || value == "walkFront" || value == "walkRide" || value == "walkSit")
               {
                  state = "walkSit";
               }
               else
               {
                  state = "standSit";
               }
            }
            else if(value == "walkBack" || value == "walkFront" || value == "walkSit" || value == "walkRide")
            {
               state = "walkRide";
            }
            else
            {
               state = "standRide";
            }
         }
         else
         {
            if(value == "walkSit" || value == "walkRide")
            {
               characterDirectionChange(true);
               return;
            }
            if(value == "standSit" || value == "standRide")
            {
               characterDirectionChange(false);
               return;
            }
         }
         sceneCharacterDefaultActionState = state;
         if(!_sceneCharacterState || _sceneCharacterState.setSceneCharacterActionState == state)
         {
            return;
         }
         setSceneCharacterAction(state);
         setSceneCharacterActionPoint(state);
         _sceneCharacterState.setSceneCharacterActionState = state;
         dispatchEvent(new SceneCharacterEvent("characterActionChange",state));
      }
      
      private function setSceneCharacterActionPoint(state:String) : void
      {
         var mount:String = "POINT_MOUNT_" + _playerInfo.MountsType;
         var body:String = "POINT_MOUNT_" + _playerInfo.MountsType + "_BODY";
         var bodyBack:String = "POINT_MOUNT_" + _playerInfo.MountsType + "_BODY_BACK";
         var saddle:String = "POINT_MOUNT_" + _playerInfo.MountsType + "_SADDLE";
         var head:String = "POINT_MOUNT_" + _playerInfo.MountsType + "_HEAD";
         _sceneCharacterState.sceneCharacterActionPointSet.reset();
         var _loc7_:* = state;
         if("walkFront" !== _loc7_)
         {
            if("walkBack" !== _loc7_)
            {
               if("standSit" !== _loc7_)
               {
                  if("standRide" !== _loc7_)
                  {
                     if("walkSit" !== _loc7_)
                     {
                        if("walkRide" !== _loc7_)
                        {
                        }
                     }
                     if(SceneCharacterActionType[head])
                     {
                        _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType[head]);
                     }
                     if(SceneCharacterActionType[body])
                     {
                        _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType[body]);
                        _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType[bodyBack]);
                     }
                     else if(SceneCharacterActionType[head])
                     {
                        _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType.getCopyActionPointItem(SceneCharacterActionType[head],"body"));
                        _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType.getCopyActionPointItem(SceneCharacterActionType[head],"bodyBack"));
                     }
                     if(SceneCharacterActionType[mount])
                     {
                        _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType[mount]);
                     }
                     if(SceneCharacterActionType[saddle])
                     {
                        _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType[saddle]);
                     }
                  }
               }
               if(SceneCharacterActionType[mount])
               {
                  _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType[mount]);
               }
               if(SceneCharacterActionType[saddle + "_STAND"])
               {
                  _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType[saddle + "_STAND"]);
               }
               else if(SceneCharacterActionType[saddle])
               {
                  _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType[saddle]);
               }
               head = head + "_STAND";
               if(HorseManager.instance.getIsShakeRide(_playerInfo.MountsType) && SceneCharacterActionType[head])
               {
                  _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType[head]);
                  _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType.getCopyActionPointItem(SceneCharacterActionType[head],"body"));
                  _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType.getCopyActionPointItem(SceneCharacterActionType[head],"bodyBack"));
               }
            }
            addr279:
            return;
         }
         _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType.POINT_HEAD_WALK);
         §§goto(addr279);
      }
      
      private function setSceneCharacterAction(state:String) : void
      {
         if(state == "standSit" || state == "standRide")
         {
            if(HorseManager.instance.getIsShakeRide(_playerInfo.MountsType))
            {
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_HEAD_SIT_STAND_2);
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_BODY_SIT_STAND_2);
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_MOUNT_SIT_STAND_2);
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_SADDLE_SIT_STAND_2);
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_HEAD_RIDE_STAND_2);
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_BODY_RIDE_STAND_FRONT_2);
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_BODY_RIDE_STAND_BACK_2);
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_MOUNT_RIDE_STAND_2);
            }
            else
            {
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_HEAD_SIT_STAND_1);
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_BODY_SIT_STAND_1);
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_MOUNT_SIT_STAND_1);
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_SADDLE_SIT_STAND_1);
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_HEAD_RIDE_STAND_1);
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_BODY_RIDE_STAND_FRONT_1);
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_BODY_RIDE_STAND_BACK_1);
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_MOUNT_RIDE_STAND_1);
            }
         }
         else if(state == "walkRide" || state == "walkSit")
         {
            if(HorseManager.instance.getIsShakeRide(_playerInfo.MountsType))
            {
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_HEAD_RIDE_WALK_2);
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_BODY_RIDE_WALK_FRONT_2);
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_BODY_RIDE_WALK_BACK_2);
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_MOUNT_RIDE_WALK_2);
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_HEAD_SIT_WALK_2);
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_BODY_SIT_WALK_2);
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_MOUNT_SIT_WALK_2);
            }
            else
            {
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_HEAD_RIDE_WALK_1);
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_BODY_RIDE_WALK_FRONT_1);
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_BODY_RIDE_WALK_BACK_1);
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_MOUNT_RIDE_WALK_1);
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_HEAD_SIT_WALK_1);
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_BODY_SIT_WALK_1);
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_MOUNT_SIT_WALK_1);
            }
            if(HorseManager.instance.getIsSaddleShake(_playerInfo.MountsType))
            {
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_SADDLE_SIT_WALK_2);
            }
            else
            {
               _sceneCharacterState.sceneCharacterActionSet.replace(SceneCharacterActionType.ACTION_SADDLE_SIT_WALK_1);
            }
         }
      }
      
      public function set setSceneCharacterDirectionDefault(value:SceneCharacterDirection) : void
      {
         if(value == SceneCharacterDirection.LT || value == SceneCharacterDirection.RT)
         {
            sceneCharacterActionState = "standBack";
         }
         else if(value == SceneCharacterDirection.LB || value == SceneCharacterDirection.RB)
         {
            sceneCharacterActionState = "standFront";
         }
      }
      
      protected function characterDirectionChange(actionFlag:Boolean) : void
      {
         if(_playerVO)
         {
            _playerVO.scenePlayerDirection = sceneCharacterDirection;
         }
         if(actionFlag)
         {
            if(sceneCharacterDirection == SceneCharacterDirection.LT || sceneCharacterDirection == SceneCharacterDirection.RT)
            {
               sceneCharacterActionState = "walkBack";
            }
            else if(sceneCharacterDirection == SceneCharacterDirection.LB || sceneCharacterDirection == SceneCharacterDirection.RB)
            {
               sceneCharacterActionState = "walkFront";
            }
         }
         else if(sceneCharacterDirection == SceneCharacterDirection.LT || sceneCharacterDirection == SceneCharacterDirection.RT)
         {
            sceneCharacterActionState = "standBack";
         }
         else if(sceneCharacterDirection == SceneCharacterDirection.LB || sceneCharacterDirection == SceneCharacterDirection.RB)
         {
            sceneCharacterActionState = "standFront";
         }
      }
      
      override public function dispose() : void
      {
         _playerAsset.removeEventListener("complete",__onPlayerAssetComplete);
         _playerAsset.dispose();
         super.dispose();
         _playerVO = null;
         _playerInfo = null;
         _playerAsset = null;
      }
   }
}
