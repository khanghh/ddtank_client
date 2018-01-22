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
      
      public function EncounterLoadingView(param1:GameInfo)
      {
         super(param1);
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
         var _loc1_:int = RoomManager.Instance.current.type == 4 || RoomManager.Instance.current.type == 11 || RoomManager.Instance.current.type == 123?94:64;
         _countDownTimer = new Timer(1000,_loc1_);
         _countDownTimer.addEventListener("timer",__countDownTick);
         _countDownTimer.addEventListener("timerComplete",__countDownComplete);
         _countDownTimer.start();
         StateManager.currentStateType = "gameLoading";
         GameControl.Instance.addEventListener("selectComplete",__pairingComplete);
      }
      
      protected function __pairingComplete(param1:GameEvent) : void
      {
         var _loc2_:* = null;
         if(!_showArrowComplete)
         {
            showArrow();
            _loc2_ = new Timer(1000,2);
            _loc2_.start();
            _loc2_.addEventListener("timerComplete",__showPairing);
            _showArrowComplete = true;
         }
      }
      
      protected function __showPairing(param1:TimerEvent) : void
      {
         hideArrow();
         var _loc6_:EncounterLoadingCharacterItem = getItemByTeam(1,true);
         var _loc5_:EncounterLoadingCharacterItem = getItemByTeam(1,false);
         var _loc8_:EncounterLoadingCharacterItem = getItemByTeam(2,true);
         var _loc7_:EncounterLoadingCharacterItem = getItemByTeam(2,false);
         var _loc2_:Point = PositionUtils.creatPoint("asset.roomLoading.EncounterLoadingCharacterItemBoyPos_1");
         var _loc4_:Point = PositionUtils.creatPoint("asset.roomLoading.EncounterLoadingCharacterItemGirlPos_1");
         var _loc3_:Point = PositionUtils.creatPoint("asset.roomLoading.EncounterLoadingCharacterItemBoyToPos_1");
         var _loc10_:Point = PositionUtils.creatPoint("asset.roomLoading.EncounterLoadingCharacterItemBoyToPos_2");
         var _loc11_:Point = PositionUtils.creatPoint("ddtroomLoading.EncounterLoadingView.lovePos");
         var _loc9_:Point = PositionUtils.creatPoint("ddtroomLoading.EncounterLoadingView.lovePos1");
         if(_loc6_)
         {
            TweenMax.to(_loc6_,2,{
               "x":_loc2_.x,
               "y":_loc2_.y
            });
         }
         if(_loc5_)
         {
            TweenMax.to(_loc5_,2,{
               "x":_loc3_.x,
               "y":_loc3_.y
            });
         }
         if(_loc8_)
         {
            TweenMax.to(_loc8_,2,{
               "x":_loc10_.x,
               "y":_loc10_.y
            });
         }
         if(_loc7_)
         {
            TweenMax.to(_loc7_,2,{
               "x":_loc4_.x,
               "y":_loc4_.y,
               "onComplete":pairingComplete
            });
         }
         if(_selfItem.info.team == 1)
         {
            TweenMax.to(_love,2,{
               "x":_loc11_.x,
               "y":_loc11_.y
            });
            _loveII.x = _loc11_.x;
            _loveII.y = _loc11_.y;
         }
         else
         {
            TweenMax.to(_love,2,{
               "x":_loc9_.x,
               "y":_loc9_.y
            });
            _loveII.x = _loc9_.x;
            _loveII.y = _loc9_.y;
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
         for each(var _loc1_ in _playerItems)
         {
            if(_loc1_)
            {
               _loc1_.arrowVisible = false;
               _loc1_.buttonMode = false;
            }
         }
      }
      
      protected function showArrow() : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Array = GameControl.Instance.selectList;
         var _loc8_:int = 0;
         var _loc7_:* = _loc5_;
         for each(var _loc6_ in _loc5_)
         {
            if(_loc6_["selectID"] != -1)
            {
               _loc3_ = getItem(_loc6_["id"],_loc6_["zoneID"]);
               _loc2_ = getItem(_loc6_["selectID"],_loc6_["selectZoneID"]);
               _loc1_ = getPosition(_loc6_["id"],_loc6_["zoneID"]);
               _loc4_ = getPosition(_loc6_["selectID"],_loc6_["selectZoneID"]);
            }
            else
            {
               _loc3_ = getItem(_loc6_["id"],_loc6_["zoneID"]);
               _loc2_ = getItem(getTeammateID(_loc3_),getTeammateZoneID(_loc3_));
               _loc1_ = getPosition(_loc6_["id"],_loc6_["zoneID"]);
               _loc4_ = getPosition(getTeammateID(_loc3_),getTeammateZoneID(_loc3_));
            }
            _loc3_.selectObject = getArrowType(_loc1_,_loc4_);
         }
      }
      
      protected function getTeammateID(param1:RoomLoadingCharacterItem) : int
      {
         var _loc3_:int = 0;
         var _loc2_:Array = GameControl.Instance.Current.roomPlayers;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_].team == param1.info.team && _loc2_[_loc3_].playerInfo.ID != param1.info.playerInfo.ID)
            {
               return _loc2_[_loc3_].playerInfo.ID;
            }
            _loc3_++;
         }
         return -1;
      }
      
      protected function getTeammateZoneID(param1:RoomLoadingCharacterItem) : int
      {
         var _loc3_:int = 0;
         var _loc2_:Array = GameControl.Instance.Current.roomPlayers;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_].team == param1.info.team && _loc2_[_loc3_].playerInfo.ID != param1.info.playerInfo.ID && _loc2_[_loc3_].playerInfo.ZoneID != param1.info.playerInfo.ZoneID)
            {
               return _loc2_[_loc3_].playerInfo.ZoneID;
            }
            _loc3_++;
         }
         return -1;
      }
      
      protected function getArrowType(param1:int, param2:int) : int
      {
         if(Math.abs(param1 - param2) == 2)
         {
            return 1;
         }
         if(param1 - param2 == 3)
         {
            return 2;
         }
         if(param1 - param2 == 1)
         {
            return 3;
         }
         if(param1 - param2 == -3)
         {
            return 3;
         }
         if(param1 - param2 == -1)
         {
            return 2;
         }
         return -1;
      }
      
      protected function getPosition(param1:int, param2:int) : int
      {
         var _loc3_:RoomLoadingCharacterItem = getItem(param1,param2);
         if(_loc3_ && _loc3_.info.playerInfo.Sex)
         {
            if(_loc3_.index == 1)
            {
               return 1;
            }
            return 2;
         }
         if(_loc3_ && !_loc3_.info.playerInfo.Sex)
         {
            if(_loc3_.index == 1)
            {
               return 3;
            }
            return 4;
         }
         return -1;
      }
      
      protected function getItemByTeam(param1:int, param2:Boolean) : EncounterLoadingCharacterItem
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _playerItems.length)
         {
            if(_playerItems[_loc3_].info.team == param1 && _playerItems[_loc3_].info.playerInfo.Sex == param2)
            {
               return _playerItems[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      protected function getItem(param1:int, param2:int) : EncounterLoadingCharacterItem
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _playerItems.length)
         {
            if(_playerItems[_loc3_].info.playerInfo.ID == param1 && _playerItems[_loc3_].info.playerInfo.ZoneID == param2)
            {
               return _playerItems[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      override protected function initLoadingItems() : void
      {
         var _loc9_:int = 0;
         var _loc14_:int = 0;
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
         var _loc16_:Array = _gameInfo.roomPlayers;
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
               _loc17_ = new EncounterLoadingCharacterItem(_loc4_);
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
               _gameInfo.neededMovies[_loc12_].startLoad();
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
      
      override protected function initRoomItem(param1:RoomLoadingCharacterItem) : void
      {
         var _loc2_:* = null;
         if(param1.info.playerInfo.Sex)
         {
            if(boyIdx == 1)
            {
               PositionUtils.setPos(param1,"asset.roomLoading.EncounterLoadingCharacterItemBoyPos_" + boyIdx.toString());
               _loc2_ = ComponentFactory.Instance.creatCustomObject("asset.roomLoading.EncounterLoadingCharacterItemBoyToPos_" + boyIdx.toString());
               blueBig = param1;
               boyIdx = Number(boyIdx) + 1;
            }
            else
            {
               PositionUtils.setPos(param1,"asset.roomLoading.EncounterLoadingCharacterItemBoyPos_" + boyIdx.toString());
               _loc2_ = ComponentFactory.Instance.creatCustomObject("asset.roomLoading.EncounterLoadingCharacterItemBoyToPos_" + boyIdx.toString());
            }
         }
         else if(girlIdx == 1)
         {
            PositionUtils.setPos(param1,"asset.roomLoading.EncounterLoadingCharacterItemGirlPos_" + girlIdx.toString());
            _loc2_ = ComponentFactory.Instance.creatCustomObject("asset.roomLoading.EncounterLoadingCharacterItemGirlToPos_" + girlIdx.toString());
            redBig = param1;
            girlIdx = Number(girlIdx) + 1;
         }
         else
         {
            PositionUtils.setPos(param1,"asset.roomLoading.EncounterLoadingCharacterItemGirlPos_" + girlIdx.toString());
            _loc2_ = ComponentFactory.Instance.creatCustomObject("asset.roomLoading.EncounterLoadingCharacterItemGirlToPos_" + girlIdx.toString());
         }
         _playerItems.push(param1);
         addChild(param1);
         if(!param1.info.playerInfo.isSelf && param1.info.playerInfo.Sex != PlayerManager.Instance.Self.Sex)
         {
            param1.buttonMode = true;
            param1.addEventListener("click",__onSelectObject);
         }
         if(param1.info.playerInfo.isSelf)
         {
            _selfItem = param1 as EncounterLoadingCharacterItem;
         }
      }
      
      protected function __onSelectObject(param1:MouseEvent) : void
      {
         var _loc2_:EncounterLoadingCharacterItem = param1.currentTarget as EncounterLoadingCharacterItem;
         _loc2_.buttonMode = false;
         _loc2_.removeEventListener("click",__onSelectObject);
         _loc2_.bubbleVisible = false;
         GameInSocketOut.sendSelectObject(_loc2_.info.playerInfo.ID,_loc2_.info.playerInfo.ZoneID);
         var _loc5_:int = 0;
         var _loc4_:* = _playerItems;
         for each(var _loc3_ in _playerItems)
         {
            if(_loc3_)
            {
               _loc3_.buttonMode = false;
               _loc3_.bubbleVisible = false;
            }
         }
      }
      
      override protected function initCharacter(param1:Player, param2:RoomLoadingCharacterItem) : void
      {
         var _loc4_:Rectangle = ComponentFactory.Instance.creatCustomObject("asset.roomloading.BigCharacterSize");
         var _loc3_:Rectangle = ComponentFactory.Instance.creatCustomObject("asset.roomloading.SuitCharacterSize");
         param1.movie = param2.info.movie;
         param1.character = param2.info.character;
         if(param2.info.playerInfo.Sex)
         {
            param1.character.showWithSize(false,-1,_loc4_.width,_loc4_.height);
            PositionUtils.setPos(param1.character,"roomLoading.encounter.characterPos");
            param2.index = blueCharacterIndex;
            blueCharacterIndex = Number(blueCharacterIndex) + 1;
         }
         else
         {
            param1.character.showWithSize(false,1,_loc4_.width,_loc4_.height);
            PositionUtils.setPos(param1.character,"roomLoading.encounter.characterPos1");
            param2.index = redCharacterIndex;
            redCharacterIndex = Number(redCharacterIndex) + 1;
         }
         param1.movie.show(true,-1);
      }
      
      override protected function checkProgress() : Boolean
      {
         var _loc6_:* = null;
         var _loc9_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc11_:int = 0;
         _unloadedmsg = "";
         var _loc1_:int = 0;
         var _loc10_:int = 0;
         var _loc16_:int = 0;
         var _loc15_:* = _gameInfo.roomPlayers;
         for each(var _loc12_ in _gameInfo.roomPlayers)
         {
            if(!_loc12_.isViewer)
            {
               if(!_pairingComplete)
               {
                  _loc1_++;
               }
               _loc6_ = _gameInfo.findLivingByPlayerID(_loc12_.playerInfo.ID,_loc12_.playerInfo.ZoneID);
               if(_loc6_.character.completed)
               {
                  _loc10_++;
               }
               else
               {
                  _unloadedmsg = _unloadedmsg + (_loc12_.playerInfo.NickName + "gameplayer.character.completed false\n");
                  _unloadedmsg = _unloadedmsg + _loc6_.character.getCharacterLoadLog();
               }
               _loc1_++;
               if(_loc6_.movie.completed)
               {
                  _loc10_++;
               }
               else
               {
                  _unloadedmsg = _unloadedmsg + (_loc12_.playerInfo.NickName + "gameplayer.movie.completed false\n");
               }
               _loc1_++;
               if(LoadBombManager.Instance.getLoadBombComplete(_loc12_.currentWeapInfo))
               {
                  _loc10_++;
               }
               else
               {
                  _unloadedmsg = _unloadedmsg + ("LoadBombManager.getLoadBombComplete(info.currentWeapInfo) false" + LoadBombManager.Instance.getUnloadedBombString(_loc12_.currentWeapInfo) + "\n");
               }
               _loc1_++;
               _loc9_ = _loc6_.playerInfo.currentPet;
               if(_loc9_)
               {
                  if(_loc9_.assetReady)
                  {
                     _loc10_++;
                  }
                  _loc1_++;
                  var _loc14_:int = 0;
                  var _loc13_:* = _loc9_.equipdSkills;
                  for each(var _loc5_ in _loc9_.equipdSkills)
                  {
                     if(_loc5_ > 0)
                     {
                        _loc4_ = PetSkillManager.getSkillByID(_loc5_);
                        if(_loc4_.EffectPic)
                        {
                           if(ModuleLoader.hasDefinition(_loc4_.EffectClassLink))
                           {
                              _loc10_++;
                           }
                           else
                           {
                              _unloadedmsg = _unloadedmsg + ("ModuleLoader.hasDefinition(skill.EffectClassLink):" + _loc4_.EffectClassLink + " false\n");
                           }
                           _loc1_++;
                        }
                        if(_loc4_.NewBallID != -1)
                        {
                           _loc3_ = BallManager.instance.findBall(_loc4_.NewBallID);
                           if(_loc3_.isComplete())
                           {
                              _loc10_++;
                           }
                           else
                           {
                              _unloadedmsg = _unloadedmsg + ("BallManager.findBall(skill.NewBallID):" + _loc4_.NewBallID + "false\n");
                           }
                           _loc1_++;
                        }
                     }
                  }
                  continue;
               }
               continue;
            }
         }
         _loc11_ = 0;
         while(_loc11_ < _gameInfo.neededMovies.length)
         {
            if(_gameInfo.neededMovies[_loc11_].type == 2)
            {
               if(ModuleLoader.hasDefinition(_gameInfo.neededMovies[_loc11_].classPath))
               {
                  _loc10_++;
               }
               else
               {
                  _unloadedmsg = _unloadedmsg + ("ModuleLoader.hasDefinition(_gameInfo.neededMovies[i].classPath):" + _gameInfo.neededMovies[_loc11_].classPath + " false\n");
               }
               _loc1_++;
            }
            else if(_gameInfo.neededMovies[_loc11_].type == 1)
            {
               if(LoadBombManager.Instance.getLivingBombComplete(_gameInfo.neededMovies[_loc11_].bombId))
               {
                  _loc10_++;
               }
               else
               {
                  _unloadedmsg = _unloadedmsg + ("LoadBombManager.getLivingBombComplete(_gameInfo.neededMovies[i].bombId):" + _gameInfo.neededMovies[_loc11_].bombId + " false\n");
               }
               _loc1_++;
            }
            _loc11_++;
         }
         var _loc18_:int = 0;
         var _loc17_:* = _gameInfo.neededPetSkillResource;
         for each(var _loc8_ in _gameInfo.neededPetSkillResource)
         {
            if(_loc8_.effect)
            {
               if(ModuleLoader.hasDefinition(_loc8_.effectClassLink))
               {
                  _loc10_++;
               }
               else
               {
                  _unloadedmsg = _unloadedmsg + ("ModuleLoader.hasDefinition(" + _loc8_.effectClassLink + ") false\n");
               }
               _loc1_++;
            }
         }
         if(_gameInfo.loaderMap.completed)
         {
            _loc10_++;
         }
         else
         {
            _unloadedmsg = _unloadedmsg + ("_gameInfo.loaderMap.completed false,pic: " + _gameInfo.loaderMap.info.Pic + "id:" + _gameInfo.loaderMap.info.ID + "\n");
         }
         _loc1_++;
         if(!StartupResourceLoader.firstEnterHall)
         {
            if(LoadBombManager.Instance.getLoadSpecialBombComplete())
            {
               _loc10_++;
            }
            else
            {
               _unloadedmsg = _unloadedmsg + ("LoadBombManager.getLoadSpecialBombComplete() false  " + LoadBombManager.Instance.getUnloadedSpecialBombString() + "\n");
            }
            _loc1_++;
         }
         if(_trainerLoad)
         {
            if(_trainerLoad.completed)
            {
               _loc10_++;
            }
            else
            {
               _unloadedmsg = _unloadedmsg + "_trainerLoad.completed false\n";
            }
            _loc1_++;
         }
         var _loc7_:* = Number(int(_loc10_ / _loc1_ * 100));
         var _loc2_:* = _loc1_ == _loc10_;
         if(_loc2_ && (!checkAnimationIsFinished() || !checkIsEnoughDelayTime()))
         {
            _loc7_ = 99;
            _loc2_ = false;
         }
         GameInSocketOut.sendLoadingProgress(_loc7_);
         RoomManager.Instance.current.selfRoomPlayer.progress = _loc7_;
         return _loc2_;
      }
      
      override protected function leave() : void
      {
      }
      
      override protected function checkAnimationIsFinished() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = _characterItems;
         for each(var _loc1_ in _characterItems)
         {
            if(!_loc1_.isAnimationFinished)
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
         var _loc2_:int = 0;
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
         for each(var _loc1_ in _gameInfo.roomPlayers)
         {
            _loc1_.removeEventListener("progressChange",__onLoadingFinished);
         }
         TweenMax.killAll(false,false,false);
         _loc2_ = 0;
         while(_loc2_ < _playerItems.length)
         {
            TweenMax.killTweensOf(_playerItems[_loc2_]);
            _playerItems[_loc2_].removeEventListener("click",__onSelectObject);
            _playerItems[_loc2_].dispose();
            _playerItems[_loc2_] = null;
            _loc2_++;
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
