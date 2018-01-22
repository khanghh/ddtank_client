package roomLoading.view
{
   import com.pickgliss.loader.LoadResourceManager;
   import ddt.data.BallInfo;
   import ddt.loader.MapLoader;
   import ddt.loader.StartupResourceLoader;
   import ddt.loader.TrainerLoader;
   import ddt.manager.BallManager;
   import ddt.manager.IMManager;
   import ddt.manager.MapManager;
   import ddt.manager.PathManager;
   import ddt.manager.PetSkillManager;
   import ddt.manager.PlayerManager;
   import gameCommon.LoadBombManager;
   import gameCommon.model.GameInfo;
   import gameCommon.model.GameNeedPetSkillInfo;
   import gameCommon.model.Player;
   import pet.data.PetInfo;
   import pet.data.PetSkillTemplateInfo;
   import room.RoomManager;
   import room.model.RoomPlayer;
   import trainer.controller.NewHandGuideManager;
   
   public class CampBattleRoomLoadingView extends RoomLoadingView
   {
       
      
      public function CampBattleRoomLoadingView(param1:GameInfo)
      {
         super(param1);
      }
      
      override protected function initLoadingItems() : void
      {
         var _loc9_:int = 0;
         var _loc14_:int = 0;
         var _loc16_:* = null;
         var _loc11_:int = 0;
         var _loc13_:int = 0;
         var _loc4_:* = null;
         var _loc17_:* = null;
         var _loc6_:* = null;
         var _loc8_:* = null;
         var _loc15_:* = null;
         var _loc3_:* = null;
         var _loc12_:int = 0;
         var _loc10_:int = _gameInfo.roomPlayers.length;
         _loc16_ = _gameInfo.roomPlayers;
         LoadBombManager.Instance.loadFullRoomPlayersBomb(_loc16_);
         if(!StartupResourceLoader.firstEnterHall)
         {
            LoadBombManager.Instance.loadSpecialBomb();
         }
         var _loc19_:int = 0;
         var _loc18_:* = _loc16_;
         for each(var _loc1_ in _loc16_)
         {
            if(PlayerManager.Instance.Self.ID == _loc1_.playerInfo.ID)
            {
               _loc11_ = _loc1_.team;
            }
         }
         var _loc21_:int = 0;
         var _loc20_:* = _loc16_;
         for each(var _loc2_ in _loc16_)
         {
            if(!_loc2_.isViewer)
            {
               if(_loc2_.team == 1)
               {
                  _loc9_++;
                  §§push(_loc9_);
               }
               else
               {
                  _loc14_++;
                  §§push(int(_loc14_));
               }
               §§pop();
               if(!(RoomManager.Instance.current.type == 0 && _loc2_.team != _loc11_))
               {
                  IMManager.Instance.saveRecentContactsID(_loc2_.playerInfo.ID);
               }
            }
         }
         _loc13_ = 0;
         while(_loc13_ < _loc10_)
         {
            _loc4_ = _gameInfo.roomPlayers[_loc13_];
            _loc4_.addEventListener("progressChange",__onLoadingFinished);
            if(_loc4_.isViewer)
            {
               if(contains(_tipsItem))
               {
                  removeChild(_tipsItem);
               }
               addChild(_viewerItem);
            }
            else
            {
               _loc17_ = new RoomLoadingCharacterItem(_loc4_);
               initRoomItem(_loc17_);
               _loc6_ = _gameInfo.findLivingByPlayerID(_loc4_.playerInfo.ID,_loc4_.playerInfo.ZoneID);
               initCharacter(_loc6_,_loc17_);
               _loc8_ = _loc6_.playerInfo.currentPet;
               if(_loc8_)
               {
                  LoadResourceManager.Instance.creatAndStartLoad(PathManager.solvePetGameAssetUrl(_loc8_.GameAssetUrl),4);
                  var _loc23_:int = 0;
                  var _loc22_:* = _loc8_.equipdSkills;
                  for each(var _loc5_ in _loc8_.equipdSkills)
                  {
                     if(_loc5_ > 0)
                     {
                        _loc15_ = PetSkillManager.getSkillByID(_loc5_);
                        if(_loc15_.EffectPic)
                        {
                           LoadResourceManager.Instance.creatAndStartLoad(PathManager.solvePetSkillEffect(_loc15_.EffectPic),4);
                        }
                        if(_loc15_.NewBallID != -1)
                        {
                           _loc3_ = BallManager.instance.findBall(_loc15_.NewBallID);
                           _loc3_.loadBombAsset();
                           _loc3_.loadCraterBitmap();
                        }
                     }
                  }
               }
            }
            _loc13_++;
         }
         if(blueBig)
         {
            addChild(blueBig);
         }
         if(redBig)
         {
            addChild(redBig);
         }
         if(!StartupResourceLoader.firstEnterHall)
         {
            _loc12_ = 0;
            while(_loc12_ < _gameInfo.neededMovies.length)
            {
               if(_gameInfo.neededMovies[_loc12_].type == 1)
               {
                  _gameInfo.neededMovies[_loc12_].startLoad();
               }
               _loc12_++;
            }
            var _loc25_:int = 0;
            var _loc24_:* = _gameInfo.neededPetSkillResource;
            for each(var _loc7_ in _gameInfo.neededPetSkillResource)
            {
               _loc7_.startLoad();
            }
         }
         _gameInfo.loaderMap = new MapLoader(MapManager.getMapInfo(_gameInfo.mapIndex));
         _gameInfo.loaderMap.load();
         switch(int(NewHandGuideManager.Instance.mapID) - 111)
         {
            case 0:
               _trainerLoad = new TrainerLoader("1");
               break;
            case 1:
               _trainerLoad = new TrainerLoader("2");
               break;
            case 2:
               _trainerLoad = new TrainerLoader("3");
               break;
            case 3:
               _trainerLoad = new TrainerLoader("4");
               break;
            case 4:
               _trainerLoad = new TrainerLoader("5");
               break;
            case 5:
               _trainerLoad = new TrainerLoader("6");
         }
         if(_trainerLoad)
         {
            _trainerLoad.load();
         }
      }
   }
}
