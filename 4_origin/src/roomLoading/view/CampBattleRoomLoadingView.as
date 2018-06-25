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
       
      
      public function CampBattleRoomLoadingView($info:GameInfo)
      {
         super($info);
      }
      
      override protected function initLoadingItems() : void
      {
         var blueLen:int = 0;
         var redLen:int = 0;
         var roomPlayers:* = null;
         var team:int = 0;
         var i:int = 0;
         var roomPlayer:* = null;
         var item:* = null;
         var gameplayer:* = null;
         var currentPet:* = null;
         var skill:* = null;
         var ball:* = null;
         var j:int = 0;
         var len:int = _gameInfo.roomPlayers.length;
         roomPlayers = _gameInfo.roomPlayers;
         LoadBombManager.Instance.loadFullRoomPlayersBomb(roomPlayers);
         if(!StartupResourceLoader.firstEnterHall)
         {
            LoadBombManager.Instance.loadSpecialBomb();
         }
         var _loc19_:int = 0;
         var _loc18_:* = roomPlayers;
         for each(var rp1 in roomPlayers)
         {
            if(PlayerManager.Instance.Self.ID == rp1.playerInfo.ID)
            {
               team = rp1.team;
            }
         }
         var _loc21_:int = 0;
         var _loc20_:* = roomPlayers;
         for each(var rp in roomPlayers)
         {
            if(!rp.isViewer)
            {
               if(rp.team == 1)
               {
                  blueLen++;
                  §§push(blueLen);
               }
               else
               {
                  redLen++;
                  §§push(int(redLen));
               }
               §§pop();
               if(!(RoomManager.Instance.current.type == 0 && rp.team != team))
               {
                  IMManager.Instance.saveRecentContactsID(rp.playerInfo.ID);
               }
            }
         }
         for(i = 0; i < len; )
         {
            roomPlayer = _gameInfo.roomPlayers[i];
            roomPlayer.addEventListener("progressChange",__onLoadingFinished);
            if(roomPlayer.isViewer)
            {
               if(contains(_tipsItem))
               {
                  removeChild(_tipsItem);
               }
               addChild(_viewerItem);
            }
            else
            {
               item = new RoomLoadingCharacterItem(roomPlayer);
               initRoomItem(item);
               gameplayer = _gameInfo.findLivingByPlayerID(roomPlayer.playerInfo.ID,roomPlayer.playerInfo.ZoneID);
               initCharacter(gameplayer,item);
               currentPet = gameplayer.playerInfo.currentPet;
               if(currentPet)
               {
                  LoadResourceManager.Instance.creatAndStartLoad(PathManager.solvePetGameAssetUrl(currentPet.GameAssetUrl),4);
                  var _loc23_:int = 0;
                  var _loc22_:* = currentPet.equipdSkills;
                  for each(var skillid in currentPet.equipdSkills)
                  {
                     if(skillid > 0)
                     {
                        skill = PetSkillManager.getSkillByID(skillid);
                        if(skill.EffectPic)
                        {
                           LoadResourceManager.Instance.creatAndStartLoad(PathManager.solvePetSkillEffect(skill.EffectPic),4);
                        }
                        if(skill.NewBallID != -1)
                        {
                           ball = BallManager.instance.findBall(skill.NewBallID);
                           ball.loadBombAsset();
                           ball.loadCraterBitmap();
                        }
                     }
                  }
               }
            }
            i++;
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
            for(j = 0; j < _gameInfo.neededMovies.length; )
            {
               if(_gameInfo.neededMovies[j].type == 1)
               {
                  _gameInfo.neededMovies[j].startLoad();
               }
               j++;
            }
            var _loc25_:int = 0;
            var _loc24_:* = _gameInfo.neededPetSkillResource;
            for each(var skillRes in _gameInfo.neededPetSkillResource)
            {
               skillRes.startLoad();
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
