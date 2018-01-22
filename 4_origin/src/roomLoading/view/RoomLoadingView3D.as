package roomLoading.view
{
   import bones.BoneMovieFactory;
   import bones.loader.BonesLoaderEvent;
   import bones.loader.BonesLoaderManager;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.loader.StartupResourceLoader;
   import ddt.loader.StateLoader;
   import ddt.manager.BallManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ItemManager;
   import ddt.manager.PathManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import gameCommon.GameControl;
   import gameCommon.LoadBombManager;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Player;
   import pet.data.PetInfo;
   import road7th.DDTAssetManager;
   import room.RoomManager;
   import room.model.RoomPlayer;
   import room.model.WeaponInfo;
   import starling.loader.StarlingQueueLoader;
   import trainer.controller.NewHandGuideManager;
   import trainer.controller.WeakGuildManager;
   
   public class RoomLoadingView3D extends RoomLoadingView
   {
       
      
      private var _loadBonesList:Array;
      
      private var _starlingLoader:StarlingQueueLoader;
      
      private var _isStarlingAssetComplete:Boolean;
      
      public function RoomLoadingView3D(param1:GameInfo)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
      }
      
      override protected function initLoadingItems() : void
      {
         super.initLoadingItems();
         addBonesAsset();
         addStarlingAsset();
      }
      
      override protected function loadingBombAsset() : void
      {
         if(BoneMovieFactory.instance.model.hasLoadingBones("gamebones"))
         {
            delayLoadingBombAsset();
         }
         else
         {
            BonesLoaderManager.instance.addEventListener("bonesstylecompelete",__onLoaderBonesComplete);
            BonesLoaderManager.instance.loadBonesStyle("gamebones",PathManager.getBonesPath("gamebones"));
         }
      }
      
      private function __onLoaderBonesComplete(param1:BonesLoaderEvent) : void
      {
         if(param1.data as String == "gamebones")
         {
            BonesLoaderManager.instance.removeEventListener("bonesstylecompelete",__onLoaderBonesComplete);
            delayLoadingBombAsset();
         }
      }
      
      private function delayLoadingBombAsset() : void
      {
         var _loc1_:Array = _gameInfo.roomPlayers;
         LoadBombManager.Instance.loadFullRoomPlayersBomb3D(_loc1_);
         LoadBombManager.Instance.loadOutBomb3D(_gameInfo.getOutBombsIdList());
         if(!StartupResourceLoader.firstEnterHall)
         {
            LoadBombManager.Instance.loadSpecialBomb3D();
         }
         if(_gameInfo.roomType == 120 || _gameInfo.roomType == 123 || _gameInfo.roomType == 1 && _gameInfo.gameMode == 120)
         {
            LoadBombManager.Instance.loadSceneEffectBomb3D();
         }
      }
      
      override protected function __countDownTick(param1:TimerEvent) : void
      {
         _selfFinish = checkProgress();
         _countDownTxt.updateNum();
         if(_selfFinish)
         {
            dispatchEvent(new Event("complete"));
            if(NewHandGuideManager.Instance.mapID == 111)
            {
               WeakGuildManager.Instance.timeStatistics(1,_startTime);
            }
         }
      }
      
      override protected function checkProgress() : Boolean
      {
         var _loc1_:int = 0;
         var _loc7_:* = null;
         var _loc4_:int = 0;
         _unloadedmsg = "";
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc10_:int = 0;
         var _loc9_:* = _gameInfo.roomPlayers;
         for each(var _loc8_ in _gameInfo.roomPlayers)
         {
            if(!_loc8_.isViewer)
            {
               _loc1_ = _loc8_.playerInfo.WeaponID > 0?_loc8_.playerInfo.WeaponID:70016;
               _loc7_ = new WeaponInfo(ItemManager.Instance.getTemplateById(_loc1_));
               if(LoadBombManager.Instance.getLoadBombComplete3D(_loc7_))
               {
                  _loc6_++;
               }
               else
               {
                  _unloadedmsg = _unloadedmsg + ("load bullet false id:" + _loc7_.bombs[0] + "\n");
               }
               _loc2_++;
               if(!StartupResourceLoader.firstEnterHall)
               {
                  _loc4_ = _loc8_.playerInfo.DeputyWeaponID > 0?_loc8_.currentDeputyWeaponInfo.TemplateID:0;
                  if(LoadBombManager.SpecialAllBomb.indexOf(_loc4_) != -1)
                  {
                     _loc7_ = new WeaponInfo(ItemManager.Instance.getTemplateById(_loc4_));
                     if(LoadBombManager.Instance.getLoadBombComplete3D(_loc7_))
                     {
                        _loc6_++;
                     }
                     else
                     {
                        _unloadedmsg = _unloadedmsg + ("load bullet false id:" + _loc7_.bombs[0] + "\n");
                     }
                     _loc2_++;
                  }
               }
            }
         }
         if(loadingOutBombsComplete())
         {
            _loc6_++;
         }
         _loc2_++;
         if(_gameInfo.loaderMap.completed)
         {
            _loc6_++;
         }
         else
         {
            _unloadedmsg = _unloadedmsg + ("loaderMap false,id:" + _gameInfo.loaderMap.info.ID + "\n");
         }
         _loc2_++;
         if(_isStarlingAssetComplete)
         {
            _loc6_++;
         }
         _loc2_++;
         if(!StartupResourceLoader.firstEnterHall)
         {
            if(LoadBombManager.Instance.getLoadSpecialBombComplete3D())
            {
               _loc6_++;
            }
            else
            {
               _unloadedmsg = _unloadedmsg + ("Load SpecialBomb false  id: " + LoadBombManager.Instance.getUnloadedSpecialBomb3DString() + " \n");
            }
            _loc2_++;
         }
         if(_gameInfo.roomType == 120 || _gameInfo.roomType == 123 || _gameInfo.roomType == 1 && _gameInfo.gameMode == 120)
         {
            if(checkBonesAssetComplete())
            {
               _loc6_++;
            }
            else
            {
               _unloadedmsg = _unloadedmsg + "Load boneslist false \n";
            }
            _loc2_++;
         }
         var _loc5_:* = Number(int(_loc6_ / _loc2_ * 100));
         var _loc3_:* = _loc2_ == _loc6_;
         if(_loc3_ && (!checkAnimationIsFinished() || !checkIsEnoughDelayTime()))
         {
            _loc5_ = 99;
            _loc3_ = false;
         }
         GameInSocketOut.sendLoadingProgress(_loc5_);
         RoomManager.Instance.current.selfRoomPlayer.progress = _loc5_;
         return _loc3_;
      }
      
      private function loadingOutBombsComplete() : Boolean
      {
         var _loc2_:Array = _gameInfo.getOutBombsIdList();
         var _loc4_:int = 0;
         var _loc3_:* = _loc2_;
         for each(var _loc1_ in _loc2_)
         {
            if(!BallManager.instance.hasBombAsset(BallManager.instance.findBall(_loc1_).craterID))
            {
               return false;
            }
         }
         return true;
      }
      
      override protected function loadingPetAsset(param1:PetInfo) : void
      {
      }
      
      override protected function initCharacter(param1:Player, param2:RoomLoadingCharacterItem) : void
      {
         var _loc4_:Rectangle = ComponentFactory.Instance.creatCustomObject("asset.roomloading.BigCharacterSize");
         var _loc3_:Rectangle = ComponentFactory.Instance.creatCustomObject("asset.roomloading.SuitCharacterSize");
         param2.info.claerMovie3D();
         param1.movie = param2.info.movie3D;
         param1.character = param2.info.character;
         param1.character.showGun = false;
         param1.character.showWing = false;
         if(param2.info.team == 1)
         {
            if(param1.isSelf || blueCharacterIndex == 1 && _gameInfo.selfGamePlayer.team != 1)
            {
               PositionUtils.setPos(param2.displayMc,"asset.roomloading.BigCharacterBluePos");
               param1.character.showWithSize(false,-1,_loc4_.width,_loc4_.height);
            }
            else
            {
               PositionUtils.setPos(param2.displayMc,"asset.roomloading.SmallCharacterBluePos");
               param1.character.show(false,-1);
            }
            param2.appear(blueCharacterIndex.toString());
            param2.index = blueCharacterIndex;
            blueCharacterIndex = Number(blueCharacterIndex) + 1;
         }
         else
         {
            if(param1.isSelf || redCharacterIndex == 1 && _gameInfo.selfGamePlayer.team != 2)
            {
               param1.character.showWithSize(false,-1,_loc4_.width,_loc4_.height);
               PositionUtils.setPos(param2.displayMc,"asset.roomloading.BigCharacterRedPos");
            }
            else
            {
               PositionUtils.setPos(param2.displayMc,"asset.roomloading.SmallCharacterRedPos");
               param1.character.show(false,-1);
            }
            param2.appear(redCharacterIndex.toString());
            param2.index = redCharacterIndex;
            redCharacterIndex = Number(redCharacterIndex) + 1;
         }
         param1.movie.show(true,-1);
      }
      
      override protected function loadingHorseAsset(param1:Array) : void
      {
      }
      
      override protected function loadingPetSkillAsset() : void
      {
      }
      
      override protected function laodingTrainer() : void
      {
      }
      
      private function addBonesAsset() : void
      {
         _loadBonesList = [];
         if(_gameInfo.roomType == 120 || _gameInfo.roomType == 1 && _gameInfo.gameMode == 120)
         {
            _loadBonesList.push("game1");
            _loadBonesList.push("gameSpecialSkill" + GameControl.Instance.specialSkillType);
            _loadBonesList.push("bones_game_battle_1");
            _loadBonesList.push("bones_game_battle_2");
         }
         else if(_gameInfo.roomType == 123)
         {
            _loadBonesList.push("game1");
            _loadBonesList.push("game2");
            _loadBonesList.push("gameSpecialSkill" + GameControl.Instance.specialSkillType);
         }
         var _loc3_:int = 0;
         var _loc2_:* = _loadBonesList;
         for each(var _loc1_ in _loadBonesList)
         {
            BonesLoaderManager.instance.startLoaderByAtlas(_loc1_,"fighting3d");
         }
      }
      
      private function checkBonesAssetComplete() : Boolean
      {
         if(_loadBonesList == null || _loadBonesList.length == 0)
         {
            return true;
         }
         var _loc3_:int = 0;
         var _loc2_:* = _loadBonesList;
         for each(var _loc1_ in _loadBonesList)
         {
            if(!BoneMovieFactory.instance.checkTextureAtlas(_loc1_,0))
            {
               return false;
            }
         }
         return true;
      }
      
      private function addStarlingAsset() : void
      {
         _isStarlingAssetComplete = false;
         var list:Array = StateLoader.getStarlingSceneResource("fighting3d");
         var loadArr:Array = [];
         var _loc3_:int = 0;
         var _loc2_:* = list;
         for each(assetInfo in list)
         {
            var matches:Array = StarlingQueueLoader.NAME_REGEX.exec(assetInfo.url);
            var useType:int = !!assetInfo.hasOwnProperty("useType")?assetInfo.useType:0;
            if(!DDTAssetManager.instance.changeModule(matches[1],"fighting3d",useType))
            {
               loadArr.push(assetInfo);
            }
         }
         if(loadArr.length > 0)
         {
            _starlingLoader = new StarlingQueueLoader();
            _starlingLoader.load(loadArr,function():void
            {
               _starlingLoader.dispose();
               _starlingLoader = null;
               _isStarlingAssetComplete = true;
            },"fighting3d");
         }
         else
         {
            _isStarlingAssetComplete = true;
         }
      }
   }
}
