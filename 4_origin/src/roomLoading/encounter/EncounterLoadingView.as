package roomLoading.encounter
{
   import com.greensock.TweenMax;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BallInfo;
   import ddt.events.GameEvent;
   import ddt.loader.MapLoader;
   import ddt.loader.StartupResourceLoader;
   import ddt.loader.TrainerLoader;
   import ddt.manager.BallManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.IMManager;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.MapManager;
   import ddt.manager.PathManager;
   import ddt.manager.PetSkillManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import gameCommon.GameControl;
   import gameCommon.LoadBombManager;
   import gameCommon.model.GameInfo;
   import gameCommon.model.GameNeedPetSkillInfo;
   import gameCommon.model.Player;
   import pet.data.PetInfo;
   import pet.data.PetSkillTemplateInfo;
   import room.RoomManager;
   import room.model.RoomPlayer;
   import roomLoading.view.RoomLoadingCharacterItem;
   import roomLoading.view.RoomLoadingView;
   import trainer.controller.LevelRewardManager;
   import trainer.controller.NewHandGuideManager;
   
   public class EncounterLoadingView extends RoomLoadingView
   {
       
      
      protected var _playerItems:Vector.<EncounterLoadingCharacterItem>;
      
      protected var _love:MovieClip;
      
      protected var _loveII:MovieClip;
      
      protected var _selfItem:EncounterLoadingCharacterItem;
      
      protected var _showArrowComplete:Boolean = false;
      
      protected var _pairingComplete:Boolean = false;
      
      protected var boyIdx:int = 1;
      
      protected var girlIdx:int = 1;
      
      public function EncounterLoadingView($info:GameInfo)
      {
         super($info);
      }
      
      override protected function init() : void
      {
         if(NewHandGuideManager.Instance.mapID == 111)
         {
            _startTime = new Date().getTime();
         }
         TimeManager.Instance.enterFightTime = new Date().getTime();
         LevelRewardManager.Instance.hide();
         _playerItems = new Vector.<EncounterLoadingCharacterItem>();
         KeyboardShortcutsManager.Instance.forbiddenFull();
         _bg = UICreatShortcut.creatAndAdd("asset.EncounterLoadingView.Bg",this);
         _countDownTxt = ComponentFactory.Instance.creatCustomObject("roomLoading.CountDownItem");
         _battleField = ComponentFactory.Instance.creatCustomObject("roomLoading.BattleFieldItem",[_gameInfo.mapIndex]);
         _tipsItem = ComponentFactory.Instance.creatCustomObject("roomLoading.TipsItem");
         _viewerItem = ComponentFactory.Instance.creatCustomObject("roomLoading.ViewerItem");
         _chatViewBg = ComponentFactory.Instance.creatComponentByStylename("roomloading.ChatViewBg");
         _love = UICreatShortcut.creatAndAdd("ddtroomLoading.EncounterLoadingView.love",this);
         _loveII = UICreatShortcut.creatAndAdd("ddtroomLoading.EncounterLoadingView.loveII",this);
         _loveII.visible = false;
         if(_gameInfo.gameMode == 7 || _gameInfo.gameMode == 8 || _gameInfo.gameMode == 10 || _gameInfo.gameMode == 17)
         {
            _dungeonMapItem = ComponentFactory.Instance.creatCustomObject("roomLoading.DungeonMapItem");
         }
         _selfFinish = false;
         addChild(_chatViewBg);
         addChild(_countDownTxt);
         addChild(_battleField);
         addChild(_tipsItem);
         initLoadingItems();
         if(_dungeonMapItem)
         {
            addChild(_dungeonMapItem);
         }
         var time:int = RoomManager.Instance.current.type == 4 || RoomManager.Instance.current.type == 11 || RoomManager.Instance.current.type == 123?94:64;
         _countDownTimer = new Timer(1000,time);
         _countDownTimer.addEventListener("timer",__countDownTick);
         _countDownTimer.addEventListener("timerComplete",__countDownComplete);
         _countDownTimer.start();
         StateManager.currentStateType = "gameLoading";
         GameControl.Instance.addEventListener("selectComplete",__pairingComplete);
      }
      
      protected function __pairingComplete(event:GameEvent) : void
      {
         var timer:* = null;
         if(!_showArrowComplete)
         {
            showArrow();
            timer = new Timer(1000,2);
            timer.start();
            timer.addEventListener("timerComplete",__showPairing);
            _showArrowComplete = true;
         }
      }
      
      protected function __showPairing(event:TimerEvent) : void
      {
         hideArrow();
         var boyItem1:EncounterLoadingCharacterItem = getItemByTeam(1,true);
         var grilItem1:EncounterLoadingCharacterItem = getItemByTeam(1,false);
         var boyItem2:EncounterLoadingCharacterItem = getItemByTeam(2,true);
         var grilItem2:EncounterLoadingCharacterItem = getItemByTeam(2,false);
         var pos1:Point = PositionUtils.creatPoint("asset.roomLoading.EncounterLoadingCharacterItemBoyPos_1");
         var pos2:Point = PositionUtils.creatPoint("asset.roomLoading.EncounterLoadingCharacterItemGirlPos_1");
         var pos3:Point = PositionUtils.creatPoint("asset.roomLoading.EncounterLoadingCharacterItemBoyToPos_1");
         var pos4:Point = PositionUtils.creatPoint("asset.roomLoading.EncounterLoadingCharacterItemBoyToPos_2");
         var pos5:Point = PositionUtils.creatPoint("ddtroomLoading.EncounterLoadingView.lovePos");
         var pos6:Point = PositionUtils.creatPoint("ddtroomLoading.EncounterLoadingView.lovePos1");
         if(boyItem1)
         {
            TweenMax.to(boyItem1,2,{
               "x":pos1.x,
               "y":pos1.y
            });
         }
         if(grilItem1)
         {
            TweenMax.to(grilItem1,2,{
               "x":pos3.x,
               "y":pos3.y
            });
         }
         if(boyItem2)
         {
            TweenMax.to(boyItem2,2,{
               "x":pos4.x,
               "y":pos4.y
            });
         }
         if(grilItem2)
         {
            TweenMax.to(grilItem2,2,{
               "x":pos2.x,
               "y":pos2.y,
               "onComplete":pairingComplete
            });
         }
         if(_selfItem.info.team == 1)
         {
            TweenMax.to(_love,2,{
               "x":pos5.x,
               "y":pos5.y
            });
            _loveII.x = pos5.x;
            _loveII.y = pos5.y;
         }
         else
         {
            TweenMax.to(_love,2,{
               "x":pos6.x,
               "y":pos6.y
            });
            _loveII.x = pos6.x;
            _loveII.y = pos6.y;
         }
         _loveII.visible = true;
      }
      
      protected function pairingComplete() : void
      {
         _pairingComplete = true;
      }
      
      protected function hideArrow() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _playerItems;
         for each(var i in _playerItems)
         {
            if(i)
            {
               i.arrowVisible = false;
               i.buttonMode = false;
            }
         }
      }
      
      protected function showArrow() : void
      {
         var item1:* = null;
         var item2:* = null;
         var pos1:int = 0;
         var pos2:int = 0;
         var selectList:Array = GameControl.Instance.selectList;
         var _loc8_:int = 0;
         var _loc7_:* = selectList;
         for each(var i in selectList)
         {
            if(i["selectID"] != -1)
            {
               item1 = getItem(i["id"],i["zoneID"]);
               item2 = getItem(i["selectID"],i["selectZoneID"]);
               pos1 = getPosition(i["id"],i["zoneID"]);
               pos2 = getPosition(i["selectID"],i["selectZoneID"]);
            }
            else
            {
               item1 = getItem(i["id"],i["zoneID"]);
               item2 = getItem(getTeammateID(item1),getTeammateZoneID(item1));
               pos1 = getPosition(i["id"],i["zoneID"]);
               pos2 = getPosition(getTeammateID(item1),getTeammateZoneID(item1));
            }
            item1.selectObject = getArrowType(pos1,pos2);
         }
      }
      
      protected function getTeammateID(item:RoomLoadingCharacterItem) : int
      {
         var i:int = 0;
         var players:Array = GameControl.Instance.Current.roomPlayers;
         for(i = 0; i < players.length; )
         {
            if(players[i].team == item.info.team && players[i].playerInfo.ID != item.info.playerInfo.ID)
            {
               return players[i].playerInfo.ID;
            }
            i++;
         }
         return -1;
      }
      
      protected function getTeammateZoneID(item:RoomLoadingCharacterItem) : int
      {
         var i:int = 0;
         var players:Array = GameControl.Instance.Current.roomPlayers;
         for(i = 0; i < players.length; )
         {
            if(players[i].team == item.info.team && players[i].playerInfo.ID != item.info.playerInfo.ID && players[i].playerInfo.ZoneID != item.info.playerInfo.ZoneID)
            {
               return players[i].playerInfo.ZoneID;
            }
            i++;
         }
         return -1;
      }
      
      protected function getArrowType(pos1:int, pos2:int) : int
      {
         if(Math.abs(pos1 - pos2) == 2)
         {
            return 1;
         }
         if(pos1 - pos2 == 3)
         {
            return 2;
         }
         if(pos1 - pos2 == 1)
         {
            return 3;
         }
         if(pos1 - pos2 == -3)
         {
            return 3;
         }
         if(pos1 - pos2 == -1)
         {
            return 2;
         }
         return -1;
      }
      
      protected function getPosition(id:int, zoneID:int) : int
      {
         var item:RoomLoadingCharacterItem = getItem(id,zoneID);
         if(item && item.info.playerInfo.Sex)
         {
            if(item.index == 1)
            {
               return 1;
            }
            return 2;
         }
         if(item && !item.info.playerInfo.Sex)
         {
            if(item.index == 1)
            {
               return 3;
            }
            return 4;
         }
         return -1;
      }
      
      protected function getItemByTeam(team:int, sex:Boolean) : EncounterLoadingCharacterItem
      {
         var i:int = 0;
         for(i = 0; i < _playerItems.length; )
         {
            if(_playerItems[i].info.team == team && _playerItems[i].info.playerInfo.Sex == sex)
            {
               return _playerItems[i];
            }
            i++;
         }
         return null;
      }
      
      protected function getItem(id:int, zoneID:int) : EncounterLoadingCharacterItem
      {
         var i:int = 0;
         for(i = 0; i < _playerItems.length; )
         {
            if(_playerItems[i].info.playerInfo.ID == id && _playerItems[i].info.playerInfo.ZoneID == zoneID)
            {
               return _playerItems[i];
            }
            i++;
         }
         return null;
      }
      
      override protected function initLoadingItems() : void
      {
         var blueLen:int = 0;
         var redLen:int = 0;
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
         var roomPlayers:Array = _gameInfo.roomPlayers;
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
               item = new EncounterLoadingCharacterItem(roomPlayer);
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
               _gameInfo.neededMovies[j].startLoad();
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
      
      override protected function initRoomItem(item:RoomLoadingCharacterItem) : void
      {
         var fromPos:* = null;
         if(item.info.playerInfo.Sex)
         {
            if(boyIdx == 1)
            {
               PositionUtils.setPos(item,"asset.roomLoading.EncounterLoadingCharacterItemBoyPos_" + boyIdx.toString());
               fromPos = ComponentFactory.Instance.creatCustomObject("asset.roomLoading.EncounterLoadingCharacterItemBoyToPos_" + boyIdx.toString());
               blueBig = item;
               boyIdx = Number(boyIdx) + 1;
            }
            else
            {
               PositionUtils.setPos(item,"asset.roomLoading.EncounterLoadingCharacterItemBoyPos_" + boyIdx.toString());
               fromPos = ComponentFactory.Instance.creatCustomObject("asset.roomLoading.EncounterLoadingCharacterItemBoyToPos_" + boyIdx.toString());
            }
         }
         else if(girlIdx == 1)
         {
            PositionUtils.setPos(item,"asset.roomLoading.EncounterLoadingCharacterItemGirlPos_" + girlIdx.toString());
            fromPos = ComponentFactory.Instance.creatCustomObject("asset.roomLoading.EncounterLoadingCharacterItemGirlToPos_" + girlIdx.toString());
            redBig = item;
            girlIdx = Number(girlIdx) + 1;
         }
         else
         {
            PositionUtils.setPos(item,"asset.roomLoading.EncounterLoadingCharacterItemGirlPos_" + girlIdx.toString());
            fromPos = ComponentFactory.Instance.creatCustomObject("asset.roomLoading.EncounterLoadingCharacterItemGirlToPos_" + girlIdx.toString());
         }
         _playerItems.push(item);
         addChild(item);
         if(!item.info.playerInfo.isSelf && item.info.playerInfo.Sex != PlayerManager.Instance.Self.Sex)
         {
            item.buttonMode = true;
            item.addEventListener("click",__onSelectObject);
         }
         if(item.info.playerInfo.isSelf)
         {
            _selfItem = item as EncounterLoadingCharacterItem;
         }
      }
      
      protected function __onSelectObject(event:MouseEvent) : void
      {
         var item:EncounterLoadingCharacterItem = event.currentTarget as EncounterLoadingCharacterItem;
         item.buttonMode = false;
         item.removeEventListener("click",__onSelectObject);
         item.bubbleVisible = false;
         GameInSocketOut.sendSelectObject(item.info.playerInfo.ID,item.info.playerInfo.ZoneID);
         var _loc5_:int = 0;
         var _loc4_:* = _playerItems;
         for each(var i in _playerItems)
         {
            if(i)
            {
               i.buttonMode = false;
               i.bubbleVisible = false;
            }
         }
      }
      
      override protected function initCharacter(gameplayer:Player, item:RoomLoadingCharacterItem) : void
      {
         var size:Rectangle = ComponentFactory.Instance.creatCustomObject("asset.roomloading.BigCharacterSize");
         var suitSize:Rectangle = ComponentFactory.Instance.creatCustomObject("asset.roomloading.SuitCharacterSize");
         gameplayer.movie = item.info.movie;
         gameplayer.character = item.info.character;
         if(item.info.playerInfo.Sex)
         {
            gameplayer.character.showWithSize(false,-1,size.width,size.height);
            PositionUtils.setPos(gameplayer.character,"roomLoading.encounter.characterPos");
            item.index = blueCharacterIndex;
            blueCharacterIndex = Number(blueCharacterIndex) + 1;
         }
         else
         {
            gameplayer.character.showWithSize(false,1,size.width,size.height);
            PositionUtils.setPos(gameplayer.character,"roomLoading.encounter.characterPos1");
            item.index = redCharacterIndex;
            redCharacterIndex = Number(redCharacterIndex) + 1;
         }
         gameplayer.movie.show(true,-1);
      }
      
      override protected function checkProgress() : Boolean
      {
         var gameplayer:* = null;
         var currentPet:* = null;
         var skill:* = null;
         var ball:* = null;
         var i:int = 0;
         _unloadedmsg = "";
         var total:int = 0;
         var finished:int = 0;
         var _loc16_:int = 0;
         var _loc15_:* = _gameInfo.roomPlayers;
         for each(var info in _gameInfo.roomPlayers)
         {
            if(!info.isViewer)
            {
               if(!_pairingComplete)
               {
                  total++;
               }
               gameplayer = _gameInfo.findLivingByPlayerID(info.playerInfo.ID,info.playerInfo.ZoneID);
               if(gameplayer.character.completed)
               {
                  finished++;
               }
               else
               {
                  _unloadedmsg = _unloadedmsg + (info.playerInfo.NickName + "gameplayer.character.completed false\n");
                  _unloadedmsg = _unloadedmsg + gameplayer.character.getCharacterLoadLog();
               }
               total++;
               if(gameplayer.movie.completed)
               {
                  finished++;
               }
               else
               {
                  _unloadedmsg = _unloadedmsg + (info.playerInfo.NickName + "gameplayer.movie.completed false\n");
               }
               total++;
               if(LoadBombManager.Instance.getLoadBombComplete(info.currentWeapInfo))
               {
                  finished++;
               }
               else
               {
                  _unloadedmsg = _unloadedmsg + ("LoadBombManager.getLoadBombComplete(info.currentWeapInfo) false" + LoadBombManager.Instance.getUnloadedBombString(info.currentWeapInfo) + "\n");
               }
               total++;
               currentPet = gameplayer.playerInfo.currentPet;
               if(currentPet)
               {
                  if(currentPet.assetReady)
                  {
                     finished++;
                  }
                  total++;
                  var _loc14_:int = 0;
                  var _loc13_:* = currentPet.equipdSkills;
                  for each(var skillid in currentPet.equipdSkills)
                  {
                     if(skillid > 0)
                     {
                        skill = PetSkillManager.getSkillByID(skillid);
                        if(skill.EffectPic)
                        {
                           if(ModuleLoader.hasDefinition(skill.EffectClassLink))
                           {
                              finished++;
                           }
                           else
                           {
                              _unloadedmsg = _unloadedmsg + ("ModuleLoader.hasDefinition(skill.EffectClassLink):" + skill.EffectClassLink + " false\n");
                           }
                           total++;
                        }
                        if(skill.NewBallID != -1)
                        {
                           ball = BallManager.instance.findBall(skill.NewBallID);
                           if(ball.isComplete())
                           {
                              finished++;
                           }
                           else
                           {
                              _unloadedmsg = _unloadedmsg + ("BallManager.findBall(skill.NewBallID):" + skill.NewBallID + "false\n");
                           }
                           total++;
                        }
                     }
                  }
                  continue;
               }
               continue;
            }
         }
         for(i = 0; i < _gameInfo.neededMovies.length; )
         {
            if(_gameInfo.neededMovies[i].type == 2)
            {
               if(ModuleLoader.hasDefinition(_gameInfo.neededMovies[i].classPath))
               {
                  finished++;
               }
               else
               {
                  _unloadedmsg = _unloadedmsg + ("ModuleLoader.hasDefinition(_gameInfo.neededMovies[i].classPath):" + _gameInfo.neededMovies[i].classPath + " false\n");
               }
               total++;
            }
            else if(_gameInfo.neededMovies[i].type == 1)
            {
               if(LoadBombManager.Instance.getLivingBombComplete(_gameInfo.neededMovies[i].bombId))
               {
                  finished++;
               }
               else
               {
                  _unloadedmsg = _unloadedmsg + ("LoadBombManager.getLivingBombComplete(_gameInfo.neededMovies[i].bombId):" + _gameInfo.neededMovies[i].bombId + " false\n");
               }
               total++;
            }
            i++;
         }
         var _loc18_:int = 0;
         var _loc17_:* = _gameInfo.neededPetSkillResource;
         for each(var skillRes in _gameInfo.neededPetSkillResource)
         {
            if(skillRes.effect)
            {
               if(ModuleLoader.hasDefinition(skillRes.effectClassLink))
               {
                  finished++;
               }
               else
               {
                  _unloadedmsg = _unloadedmsg + ("ModuleLoader.hasDefinition(" + skillRes.effectClassLink + ") false\n");
               }
               total++;
            }
         }
         if(_gameInfo.loaderMap.completed)
         {
            finished++;
         }
         else
         {
            _unloadedmsg = _unloadedmsg + ("_gameInfo.loaderMap.completed false,pic: " + _gameInfo.loaderMap.info.Pic + "id:" + _gameInfo.loaderMap.info.ID + "\n");
         }
         total++;
         if(!StartupResourceLoader.firstEnterHall)
         {
            if(LoadBombManager.Instance.getLoadSpecialBombComplete())
            {
               finished++;
            }
            else
            {
               _unloadedmsg = _unloadedmsg + ("LoadBombManager.getLoadSpecialBombComplete() false  " + LoadBombManager.Instance.getUnloadedSpecialBombString() + "\n");
            }
            total++;
         }
         if(_trainerLoad)
         {
            if(_trainerLoad.completed)
            {
               finished++;
            }
            else
            {
               _unloadedmsg = _unloadedmsg + "_trainerLoad.completed false\n";
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
      
      override protected function leave() : void
      {
      }
      
      override protected function checkAnimationIsFinished() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = _characterItems;
         for each(var item in _characterItems)
         {
            if(!item.isAnimationFinished)
            {
               return false;
            }
         }
         if(_delayBeginTime <= 0)
         {
            _delayBeginTime = new Date().time;
         }
         return true;
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         GameControl.Instance.removeEventListener("selectComplete",__pairingComplete);
         KeyboardShortcutsManager.Instance.cancelForbidden();
         _countDownTimer.removeEventListener("timer",__countDownTick);
         _countDownTimer.removeEventListener("timerComplete",__countDownComplete);
         _countDownTimer.stop();
         _countDownTimer = null;
         ObjectUtils.disposeObject(_trainerLoad);
         ObjectUtils.disposeObject(_bg);
         ObjectUtils.disposeObject(_chatViewBg);
         ObjectUtils.disposeObject(_versus);
         ObjectUtils.disposeObject(_countDownTxt);
         ObjectUtils.disposeObject(_battleField);
         ObjectUtils.disposeObject(_tipsItem);
         ObjectUtils.disposeObject(_viewerItem);
         var _loc4_:int = 0;
         var _loc3_:* = _gameInfo.roomPlayers;
         for each(var rp in _gameInfo.roomPlayers)
         {
            rp.removeEventListener("progressChange",__onLoadingFinished);
         }
         TweenMax.killAll(false,false,false);
         for(i = 0; i < _playerItems.length; )
         {
            TweenMax.killTweensOf(_playerItems[i]);
            _playerItems[i].removeEventListener("click",__onSelectObject);
            _playerItems[i].dispose();
            _playerItems[i] = null;
            i++;
         }
         if(_love)
         {
            TweenMax.killTweensOf(_love);
            ObjectUtils.disposeObject(_love);
            _love = null;
         }
         ObjectUtils.disposeObject(_dungeonMapItem);
         _dungeonMapItem = null;
         _characterItems = null;
         _trainerLoad = null;
         _bg = null;
         _chatViewBg = null;
         _gameInfo = null;
         _versus = null;
         _countDownTxt = null;
         _battleField = null;
         _tipsItem = null;
         _countDownTimer = null;
         _viewerItem = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
