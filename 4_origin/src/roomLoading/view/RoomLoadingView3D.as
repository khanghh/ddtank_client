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
      
      public function RoomLoadingView3D($info:GameInfo)
      {
         super($info);
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
      
      private function __onLoaderBonesComplete(e:BonesLoaderEvent) : void
      {
         if(e.data as String == "gamebones")
         {
            BonesLoaderManager.instance.removeEventListener("bonesstylecompelete",__onLoaderBonesComplete);
            delayLoadingBombAsset();
         }
      }
      
      private function delayLoadingBombAsset() : void
      {
         var roomPlayers:Array = _gameInfo.roomPlayers;
         LoadBombManager.Instance.loadFullRoomPlayersBomb3D(roomPlayers);
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
      
      override protected function __countDownTick(evt:TimerEvent) : void
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
         var weaponId:int = 0;
         var weaponInfo:* = null;
         var deputyWeaponID:int = 0;
         _unloadedmsg = "";
         var total:int = 0;
         var finished:int = 0;
         var _loc10_:int = 0;
         var _loc9_:* = _gameInfo.roomPlayers;
         for each(var info in _gameInfo.roomPlayers)
         {
            if(!info.isViewer)
            {
               weaponId = info.playerInfo.WeaponID > 0?info.playerInfo.WeaponID:70016;
               weaponInfo = new WeaponInfo(ItemManager.Instance.getTemplateById(weaponId));
               if(LoadBombManager.Instance.getLoadBombComplete3D(weaponInfo))
               {
                  finished++;
               }
               else
               {
                  _unloadedmsg = _unloadedmsg + ("load bullet false id:" + weaponInfo.bombs[0] + "\n");
               }
               total++;
               if(!StartupResourceLoader.firstEnterHall)
               {
                  deputyWeaponID = info.playerInfo.DeputyWeaponID > 0?info.currentDeputyWeaponInfo.TemplateID:0;
                  if(LoadBombManager.SpecialAllBomb.indexOf(deputyWeaponID) != -1)
                  {
                     weaponInfo = new WeaponInfo(ItemManager.Instance.getTemplateById(deputyWeaponID));
                     if(LoadBombManager.Instance.getLoadBombComplete3D(weaponInfo))
                     {
                        finished++;
                     }
                     else
                     {
                        _unloadedmsg = _unloadedmsg + ("load bullet false id:" + weaponInfo.bombs[0] + "\n");
                     }
                     total++;
                  }
               }
            }
         }
         if(loadingOutBombsComplete())
         {
            finished++;
         }
         total++;
         if(_gameInfo.loaderMap.completed)
         {
            finished++;
         }
         else
         {
            _unloadedmsg = _unloadedmsg + ("loaderMap false,id:" + _gameInfo.loaderMap.info.ID + "\n");
         }
         total++;
         if(_isStarlingAssetComplete)
         {
            finished++;
         }
         total++;
         if(!StartupResourceLoader.firstEnterHall)
         {
            if(LoadBombManager.Instance.getLoadSpecialBombComplete3D())
            {
               finished++;
            }
            else
            {
               _unloadedmsg = _unloadedmsg + ("Load SpecialBomb false  id: " + LoadBombManager.Instance.getUnloadedSpecialBomb3DString() + " \n");
            }
            total++;
         }
         if(_gameInfo.roomType == 120 || _gameInfo.roomType == 123 || _gameInfo.roomType == 1 && _gameInfo.gameMode == 120)
         {
            if(checkBonesAssetComplete())
            {
               finished++;
            }
            else
            {
               _unloadedmsg = _unloadedmsg + "Load boneslist false \n";
            }
            total++;
         }
         var pro:* = Number(int(finished / total * 100));
         var res:* = total == finished;
         if(res && (!checkAnimationIsFinished() || !checkIsEnoughDelayTime()))
         {
            pro = 99;
            res = false;
         }
         GameInSocketOut.sendLoadingProgress(pro);
         RoomManager.Instance.current.selfRoomPlayer.progress = pro;
         return res;
      }
      
      private function loadingOutBombsComplete() : Boolean
      {
         var list:Array = _gameInfo.getOutBombsIdList();
         var _loc4_:int = 0;
         var _loc3_:* = list;
         for each(var outBombsId in list)
         {
            if(!BallManager.instance.hasBombAsset(BallManager.instance.findBall(outBombsId).craterID))
            {
               return false;
            }
         }
         return true;
      }
      
      override protected function loadingPetAsset(currentPet:PetInfo) : void
      {
      }
      
      override protected function initCharacter(gameplayer:Player, item:RoomLoadingCharacterItem) : void
      {
         var size:Rectangle = ComponentFactory.Instance.creatCustomObject("asset.roomloading.BigCharacterSize");
         var suitSize:Rectangle = ComponentFactory.Instance.creatCustomObject("asset.roomloading.SuitCharacterSize");
         item.info.claerMovie3D();
         gameplayer.movie = item.info.movie3D;
         gameplayer.character = item.info.character;
         gameplayer.character.showGun = false;
         gameplayer.character.showWing = false;
         if(item.info.team == 1)
         {
            if(gameplayer.isSelf || blueCharacterIndex == 1 && _gameInfo.selfGamePlayer.team != 1)
            {
               PositionUtils.setPos(item.displayMc,"asset.roomloading.BigCharacterBluePos");
               gameplayer.character.showWithSize(false,-1,size.width,size.height);
            }
            else
            {
               PositionUtils.setPos(item.displayMc,"asset.roomloading.SmallCharacterBluePos");
               gameplayer.character.show(false,-1);
            }
            item.appear(blueCharacterIndex.toString());
            item.index = blueCharacterIndex;
            blueCharacterIndex = Number(blueCharacterIndex) + 1;
         }
         else
         {
            if(gameplayer.isSelf || redCharacterIndex == 1 && _gameInfo.selfGamePlayer.team != 2)
            {
               gameplayer.character.showWithSize(false,-1,size.width,size.height);
               PositionUtils.setPos(item.displayMc,"asset.roomloading.BigCharacterRedPos");
            }
            else
            {
               PositionUtils.setPos(item.displayMc,"asset.roomloading.SmallCharacterRedPos");
               gameplayer.character.show(false,-1);
            }
            item.appear(redCharacterIndex.toString());
            item.index = redCharacterIndex;
            redCharacterIndex = Number(redCharacterIndex) + 1;
         }
         gameplayer.movie.show(true,-1);
      }
      
      override protected function loadingHorseAsset(horseSkillEquipList:Array) : void
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
         for each(var atlas in _loadBonesList)
         {
            BonesLoaderManager.instance.startLoaderByAtlas(atlas,"fighting3d");
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
         for each(var atlas in _loadBonesList)
         {
            if(!BoneMovieFactory.instance.checkTextureAtlas(atlas,0))
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
