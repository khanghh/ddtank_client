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
      
      public function HallPlayerBase(param1:PlayerVO)
      {
         _playerVO = param1;
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
         var _loc1_:Image = StarlingMain.instance.createImage("image_deafult_player");
         _loc1_.x = 35;
         _loc1_.y = 30;
         _characterPlayer.addChild(_loc1_);
         _isDefaultCharacter = true;
      }
      
      protected function __onStyleChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["Style"] || param1.changedProperties["Colors"])
         {
            _sceneCharacterState.removeTexture("head");
            _playerAsset.resetLoader();
            _playerAsset.loadHead();
         }
         if(param1.changedProperties["mountsType"])
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
      
      private function __onPlayerAssetComplete(param1:Event) : void
      {
         _isDefaultCharacter = false;
         resetPlayerAsset();
      }
      
      protected function resetPlayerAsset() : void
      {
         var _loc4_:* = null;
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
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
               _loc4_ = new SceneCharacterTextureItem("head",_playerAsset.headAssetName,3,1,3,120,150,0);
               _sceneCharacterState.updateTexture(_loc4_);
            }
            if(_playerAsset.isResetByAssetName(_playerAsset.bodyAssetName))
            {
               _loc1_ = new SceneCharacterTextureItem("body",_playerAsset.bodyAssetName,17,3,7,120,175,4);
               _sceneCharacterState.updateTexture(_loc1_);
            }
            if(_playerAsset.isResetByAssetName(_playerAsset.mountsAssetName))
            {
               _loc2_ = new SceneCharacterTextureItem("mount",_playerAsset.mountsAssetName,7,0,0,500,400,2,1);
               _sceneCharacterState.updateTexture(_loc2_);
               _loc3_ = _sceneCharacterState.setSceneCharacterActionState;
               if(_loc3_ == "walkRide" || _loc3_ == "walkSit" || _loc3_ == "standRide" || _loc3_ == "standSit")
               {
                  setSceneCharacterAction(_loc3_);
                  setSceneCharacterActionPoint(_loc3_);
               }
               sceneCharacterActionState = _sceneCharacterState.setSceneCharacterActionState;
            }
            _sceneCharacterState.resetSceneCharacterDraw();
         }
      }
      
      protected function setCharacterData() : void
      {
         var _loc5_:SceneCharacterActionSet = getSceneCharacterActionSet();
         var _loc3_:SceneCharacterActionPointSet = getSceneCharacterActionPointSet();
         var _loc1_:SceneCharacterTextureSet = getSceneCharacterTextureSet();
         var _loc2_:HallPlayerDraw = new HallPlayerDraw(_playerInfo);
         var _loc4_:SceneCharacterState = new SceneCharacterState(_loc1_,_loc5_,_loc3_,_loc2_);
         this.sceneCharacterState = _loc4_;
      }
      
      protected function getSceneCharacterActionSet() : SceneCharacterActionSet
      {
         var _loc1_:SceneCharacterActionSet = new SceneCharacterActionSet();
         _loc1_.push(SceneCharacterActionType.ACTION_HEAD_STAND_FRONT);
         _loc1_.push(SceneCharacterActionType.ACTION_BODY_STAND_FRONT);
         _loc1_.push(SceneCharacterActionType.ACTION_STAND_BACK_ACTION);
         _loc1_.push(SceneCharacterActionType.ACTION_BODY_STAND_BACK);
         _loc1_.push(SceneCharacterActionType.ACTION_HEAD_WALK_FRONT);
         _loc1_.push(SceneCharacterActionType.ACTION_BODY_WALK_FRONT);
         _loc1_.push(SceneCharacterActionType.ACTION_HEAD_WALK_BACK);
         _loc1_.push(SceneCharacterActionType.ACTION_BODY_WALK_BACK);
         return _loc1_;
      }
      
      protected function getSceneCharacterActionPointSet() : SceneCharacterActionPointSet
      {
         var _loc1_:SceneCharacterActionPointSet = new SceneCharacterActionPointSet();
         return _loc1_;
      }
      
      protected function getSceneCharacterTextureSet() : SceneCharacterTextureSet
      {
         var _loc3_:* = null;
         var _loc2_:SceneCharacterTextureSet = new SceneCharacterTextureSet();
         var _loc4_:SceneCharacterTextureItem = new SceneCharacterTextureItem("head",_playerAsset.headAssetName,3,1,3,120,150,0);
         var _loc1_:SceneCharacterTextureItem = new SceneCharacterTextureItem("body",_playerAsset.bodyAssetName,17,3,7,120,175,4);
         _loc2_.push(_loc4_);
         _loc2_.push(_loc1_);
         if(_playerInfo.IsMounts)
         {
            _loc3_ = new SceneCharacterTextureItem("mount",_playerAsset.mountsAssetName,7,0,0,500,400,2,1);
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      override public function set sceneCharacterActionState(param1:String) : void
      {
         var _loc2_:* = param1;
         if(_playerVO.playerInfo.IsMounts)
         {
            if(HorseManager.instance.getIsSit(_playerVO.playerInfo.MountsType))
            {
               if(param1 == "walkBack" || param1 == "walkFront" || param1 == "walkRide" || param1 == "walkSit")
               {
                  _loc2_ = "walkSit";
               }
               else
               {
                  _loc2_ = "standSit";
               }
            }
            else if(param1 == "walkBack" || param1 == "walkFront" || param1 == "walkSit" || param1 == "walkRide")
            {
               _loc2_ = "walkRide";
            }
            else
            {
               _loc2_ = "standRide";
            }
         }
         else
         {
            if(param1 == "walkSit" || param1 == "walkRide")
            {
               characterDirectionChange(true);
               return;
            }
            if(param1 == "standSit" || param1 == "standRide")
            {
               characterDirectionChange(false);
               return;
            }
         }
         sceneCharacterDefaultActionState = _loc2_;
         if(!_sceneCharacterState || _sceneCharacterState.setSceneCharacterActionState == _loc2_)
         {
            return;
         }
         setSceneCharacterAction(_loc2_);
         setSceneCharacterActionPoint(_loc2_);
         _sceneCharacterState.setSceneCharacterActionState = _loc2_;
         dispatchEvent(new SceneCharacterEvent("characterActionChange",_loc2_));
      }
      
      private function setSceneCharacterActionPoint(param1:String) : void
      {
         var _loc3_:String = "POINT_MOUNT_" + _playerInfo.MountsType;
         var _loc2_:String = "POINT_MOUNT_" + _playerInfo.MountsType + "_BODY";
         var _loc5_:String = "POINT_MOUNT_" + _playerInfo.MountsType + "_BODY_BACK";
         var _loc4_:String = "POINT_MOUNT_" + _playerInfo.MountsType + "_SADDLE";
         var _loc6_:String = "POINT_MOUNT_" + _playerInfo.MountsType + "_HEAD";
         _sceneCharacterState.sceneCharacterActionPointSet.reset();
         var _loc7_:* = param1;
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
                     if(SceneCharacterActionType[_loc6_])
                     {
                        _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType[_loc6_]);
                     }
                     if(SceneCharacterActionType[_loc2_])
                     {
                        _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType[_loc2_]);
                        _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType[_loc5_]);
                     }
                     else if(SceneCharacterActionType[_loc6_])
                     {
                        _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType.getCopyActionPointItem(SceneCharacterActionType[_loc6_],"body"));
                        _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType.getCopyActionPointItem(SceneCharacterActionType[_loc6_],"bodyBack"));
                     }
                     if(SceneCharacterActionType[_loc3_])
                     {
                        _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType[_loc3_]);
                     }
                     if(SceneCharacterActionType[_loc4_])
                     {
                        _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType[_loc4_]);
                     }
                  }
               }
               if(SceneCharacterActionType[_loc3_])
               {
                  _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType[_loc3_]);
               }
               if(SceneCharacterActionType[_loc4_ + "_STAND"])
               {
                  _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType[_loc4_ + "_STAND"]);
               }
               else if(SceneCharacterActionType[_loc4_])
               {
                  _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType[_loc4_]);
               }
               _loc6_ = _loc6_ + "_STAND";
               if(HorseManager.instance.getIsShakeRide(_playerInfo.MountsType) && SceneCharacterActionType[_loc6_])
               {
                  _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType[_loc6_]);
                  _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType.getCopyActionPointItem(SceneCharacterActionType[_loc6_],"body"));
                  _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType.getCopyActionPointItem(SceneCharacterActionType[_loc6_],"bodyBack"));
               }
            }
            addr227:
            return;
         }
         _sceneCharacterState.sceneCharacterActionPointSet.push(SceneCharacterActionType.POINT_HEAD_WALK);
         §§goto(addr227);
      }
      
      private function setSceneCharacterAction(param1:String) : void
      {
         if(param1 == "standSit" || param1 == "standRide")
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
         else if(param1 == "walkRide" || param1 == "walkSit")
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
      
      public function set setSceneCharacterDirectionDefault(param1:SceneCharacterDirection) : void
      {
         if(param1 == SceneCharacterDirection.LT || param1 == SceneCharacterDirection.RT)
         {
            sceneCharacterActionState = "standBack";
         }
         else if(param1 == SceneCharacterDirection.LB || param1 == SceneCharacterDirection.RB)
         {
            sceneCharacterActionState = "standFront";
         }
      }
      
      protected function characterDirectionChange(param1:Boolean) : void
      {
         if(_playerVO)
         {
            _playerVO.scenePlayerDirection = sceneCharacterDirection;
         }
         if(param1)
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
