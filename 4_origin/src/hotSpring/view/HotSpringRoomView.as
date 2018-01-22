package hotSpring.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.BossBoxManager;
   import ddt.manager.ChatManager;
   import ddt.manager.HotSpringManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import ddt.view.MainToolBar;
   import ddt.view.bossbox.SmallBoxButton;
   import ddt.view.chat.ChatView;
   import ddt.view.common.GradeContainer;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import ddt.view.scenePathSearcher.PathMapHitTester;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import hotSpring.controller.HotSpringRoomManager;
   import hotSpring.event.HotSpringRoomEvent;
   import hotSpring.model.HotSpringRoomModel;
   import hotSpring.player.HotSpringPlayer;
   import hotSpring.vo.MapVO;
   import hotSpring.vo.PlayerVO;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import uiModeManager.bombUI.HappyLittleGameManager;
   
   public class HotSpringRoomView extends Sprite
   {
      
      private static var _waterArea:MovieClip;
       
      
      private var _model:HotSpringRoomModel;
      
      private var _controller:HotSpringRoomManager;
      
      private var _hotSpringViewAsset:MovieClip;
      
      private var _mapVO:MapVO;
      
      private var _playerLayer:MovieClip;
      
      private var _defaultPoint:Point;
      
      private var _selfPlayer:HotSpringPlayer;
      
      private var _mouseMovie:MovieClip;
      
      private var _waterAreaPointPixel:uint = 0;
      
      private var _playerWalkPath:Array;
      
      private var _sceneScene:SceneScene;
      
      private var _lastClick:Number = 0;
      
      private var _clickInterval:Number = 200;
      
      private var _chatFrame:ChatView;
      
      private var _roomMenuView:RoomMenuView;
      
      private var _isShowName:Boolean = true;
      
      private var _isChatBall:Boolean = true;
      
      private var _isShowPalyer:Boolean = true;
      
      private var _sysDateTime:Date;
      
      private var _grade:GradeContainer;
      
      private var _sceneFront:MovieClip;
      
      private var _sceneFront2:MovieClip;
      
      private var _sceneBack:Bitmap;
      
      private var _sceneFrontNight:MovieClip;
      
      private var _sceneFrontNight2:MovieClip;
      
      private var _sceneBackNight:Bitmap;
      
      private var _sceneBackBox:Sprite;
      
      private var _playerList:DictionaryData;
      
      private var _playerListFailure:DictionaryData;
      
      private var _playerListCellLoadCount:DictionaryData;
      
      private var _isPlayerListLoading:Boolean = false;
      
      private var _boxButton:SmallBoxButton;
      
      private var _hotSpringPlayerList:DictionaryData;
      
      private var _expUpAsset:Bitmap;
      
      private var _expUpText:FilterFrameText;
      
      private var _expUpBox:Sprite;
      
      private var _currentLoadingPlayer:HotSpringPlayer;
      
      private var _SceneType:int = 0;
      
      private var _dayStart:Date;
      
      private var _dayEnd:Date;
      
      private var _nightStart:Date;
      
      private var _nightEnd:Date;
      
      private var _ShowNameBtn:ScaleFrameImage;
      
      private var _ShowPaoBtn:ScaleFrameImage;
      
      private var _ShowPlayerBtn:ScaleFrameImage;
      
      private var _countDown:ScaleFrameImage;
      
      private var _energy:ScaleFrameImage;
      
      private var _roomNum:Bitmap;
      
      private var _countDownTxt:FilterFrameText;
      
      private var _energyTxt:FilterFrameText;
      
      private var _roomNumTxt:FilterFrameText;
      
      private var _HpLittleGameNpc:MovieClip;
      
      private var _emailShine:IEffect;
      
      public function HotSpringRoomView(param1:HotSpringRoomManager, param2:HotSpringRoomModel)
      {
         _defaultPoint = new Point(480,560);
         _playerList = new DictionaryData();
         _playerListFailure = new DictionaryData();
         _playerListCellLoadCount = new DictionaryData();
         _hotSpringPlayerList = new DictionaryData();
         super();
         _controller = param1;
         _model = param2;
         initialize();
      }
      
      public static function getCurrentAreaType(param1:int, param2:int) : int
      {
         var _loc3_:Point = _waterArea.localToGlobal(new Point(param1,param2));
         if(_waterArea.hitTestPoint(_loc3_.x,_loc3_.y,true))
         {
            return 2;
         }
         return 1;
      }
      
      protected function initialize() : void
      {
         CacheSysManager.lock("alertInHotSpring");
         _sysDateTime = HotSpringManager.instance.playerEnterRoomTime;
         _mapVO = new MapVO();
         MainToolBar.Instance.hide();
         SoundManager.instance.playMusic("3004");
         _sceneBackBox = new Sprite();
         addChild(_sceneBackBox);
         _hotSpringViewAsset = ClassUtils.CreatInstance("asset.hotSpring.HotSpringViewAsset") as MovieClip;
         if(_hotSpringViewAsset)
         {
            _hotSpringViewAsset.x = 0;
            _hotSpringViewAsset.y = -210;
            addChild(_hotSpringViewAsset);
            _hotSpringViewAsset.maskPath.visible = false;
            _hotSpringViewAsset.layerWater.visible = false;
            _waterArea = _hotSpringViewAsset.layerWater;
            _sceneScene = new SceneScene();
            _sceneScene.setHitTester(new PathMapHitTester(_hotSpringViewAsset.maskPath));
            _playerLayer = _hotSpringViewAsset.playerLayer;
         }
         sysDateTimeScene(_sysDateTime);
         _mouseMovie = ClassUtils.CreatInstance("asset.hotSpring.MouseClickMovie");
         if(_mouseMovie)
         {
            _mouseMovie.mouseChildren = false;
            _mouseMovie.mouseEnabled = false;
            _mouseMovie.stop();
            if(_hotSpringViewAsset)
            {
               _hotSpringViewAsset.addChild(_mouseMovie);
            }
         }
         _roomMenuView = new RoomMenuView(_controller,_model);
         PositionUtils.setPos(_roomMenuView,"asset.hotSpring.RoomMenuViewPos");
         addChild(_roomMenuView);
         _ShowNameBtn = ComponentFactory.Instance.creatComponentByStylename("asset.hotSpring.showNameBtn");
         if(_ShowNameBtn)
         {
            _ShowNameBtn.setFrame(1);
            _ShowNameBtn.buttonMode = true;
            addChild(_ShowNameBtn);
         }
         _ShowPaoBtn = ComponentFactory.Instance.creatComponentByStylename("asset.hotSpring.showPaoBtn");
         if(_ShowPaoBtn)
         {
            _ShowPaoBtn.setFrame(1);
            _ShowPaoBtn.buttonMode = true;
            addChild(_ShowPaoBtn);
         }
         _ShowPlayerBtn = ComponentFactory.Instance.creatComponentByStylename("asset.hotSpring.showPlayerBtn");
         if(_ShowPlayerBtn)
         {
            _ShowPlayerBtn.setFrame(1);
            _ShowPlayerBtn.buttonMode = true;
            addChild(_ShowPlayerBtn);
         }
         _countDown = ComponentFactory.Instance.creatComponentByStylename("asset.hotSpring.countDownIMG");
         addChild(_countDown);
         _energy = ComponentFactory.Instance.creatComponentByStylename("asset.hotSpring.energyIMG");
         addChild(_energy);
         _roomNum = ComponentFactory.Instance.creatBitmap("asset.hotSpring.roomNum");
         addChild(_roomNum);
         _countDownTxt = ComponentFactory.Instance.creat("asset.hotSpring.countDownTxt");
         addChild(_countDownTxt);
         _roomNumTxt = ComponentFactory.Instance.creat("asset.hotSpring.roomNumTxt");
         addChild(_roomNumTxt);
         _energyTxt = ComponentFactory.Instance.creat("asset.hotSpring.energyTxt");
         addChild(_energyTxt);
         if(HotSpringManager.instance.roomCurrently)
         {
            if(HotSpringManager.instance.roomCurrently.roomType == 1 || HotSpringManager.instance.roomCurrently.roomType == 2)
            {
               _countDown.setFrame(2);
               _countDownTxt.text = HotSpringManager.instance.playerEffectiveTime + LanguageMgr.GetTranslation("tank.hotSpring.room.time.minute");
               _energy.setFrame(2);
               _energyTxt.text = HotSpringManager.instance.energyTotal.toString();
            }
            else
            {
               _countDown.setFrame(1);
               _countDownTxt.text = HotSpringManager.instance.roomCurrently.effectiveTime + LanguageMgr.GetTranslation("tank.hotSpring.room.time.minute");
               _energy.setFrame(1);
               _energyTxt.text = HotSpringManager.instance.energyTotal.toString();
            }
            _roomNumTxt.text = HotSpringManager.instance.roomCurrently.roomNumber.toString();
         }
         if(BossBoxManager.instance.isShowBoxButton())
         {
            _boxButton = new SmallBoxButton(6);
            addChild(_boxButton);
         }
         _HpLittleGameNpc = ClassUtils.CreatInstance("asset.hotSpring.npc");
         PositionUtils.setPos(_HpLittleGameNpc,"asset.hotSpring.RoomNPCPos");
         _playerLayer.addChild(_HpLittleGameNpc);
         setEvent();
         if(!_hotSpringViewAsset && !this.contains(_hotSpringViewAsset))
         {
            _controller.roomPlayerRemoveSend(LanguageMgr.GetTranslation("tank.hotSpring.room.load.error"));
            return;
         }
         ChatManager.Instance.state = 19;
         _chatFrame = ChatManager.Instance.view;
         _chatFrame.output.isLock = true;
         addChild(_chatFrame);
         var _loc1_:Object = {};
         _loc1_["blurWidth"] = 6;
         _loc1_["color"] = "yellow";
      }
      
      private function __onStageAddInitMapPath(param1:Event) : void
      {
         removeEventListener("addedToStage",__onStageAddInitMapPath);
         _hotSpringViewAsset.maskPath.mouseEnabled = false;
         _hotSpringViewAsset.layerWater.mouseEnabled = false;
         stage.addChild(_hotSpringViewAsset.maskPath);
         stage.addChild(_hotSpringViewAsset.layerWater);
      }
      
      private function setEvent() : void
      {
         _ShowNameBtn.addEventListener("click",roomToolMenu);
         _ShowPaoBtn.addEventListener("click",roomToolMenu);
         _ShowPlayerBtn.addEventListener("click",roomToolMenu);
         HotSpringManager.instance.addEventListener("roomPlayerRemove",removePlayer);
         _model.addEventListener("roomPlayerAdd",addPlayer);
         _model.addEventListener("roomPlayerRemove",removePlayer);
         _hotSpringViewAsset.addEventListener("click",onMouseClick);
         SocketManager.Instance.addEventListener(PkgEvent.format(191,7),roomTimeUpdate);
         addEventListener("addedToStage",__onStageAddInitMapPath);
         SocketManager.Instance.out.sendHotSpringRoomEnterView(0);
         addEventListener("enterFrame",onEnterFrame);
         _HpLittleGameNpc.addEventListener("click",__npcClickHander);
         _HpLittleGameNpc.addEventListener("mouseOver",__npcOverHander);
         _HpLittleGameNpc.addEventListener("mouseOut",__npcOutHandler);
      }
      
      private function __npcOutHandler(param1:MouseEvent) : void
      {
         if(_HpLittleGameNpc)
         {
            _HpLittleGameNpc.buttonMode = false;
            _HpLittleGameNpc.filters = null;
         }
      }
      
      private function __npcOverHander(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         if(_HpLittleGameNpc)
         {
            _HpLittleGameNpc.buttonMode = true;
            _loc2_ = new GlowFilter();
            _loc2_.blurX = 10;
            _loc2_.blurY = 10;
            _loc2_.color = 16776960;
            _loc2_.quality = 2;
            _HpLittleGameNpc.filters = [_loc2_];
         }
      }
      
      private function __npcClickHander(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         HappyLittleGameManager.instance.show();
      }
      
      private function playerLoad() : void
      {
         if(_playerList && _playerList.list && _playerList.length > 0)
         {
            _isPlayerListLoading = true;
            playerLoadEnter(_playerList.list[0]);
         }
         else if(_playerListFailure && _playerListFailure.list && _playerListFailure.length > 0)
         {
            _isPlayerListLoading = true;
            playerLoadEnter(_playerListFailure.list[0]);
         }
      }
      
      private function playerLoadEnter(param1:PlayerVO) : void
      {
         var _loc2_:int = 0;
         if(_playerListCellLoadCount && _playerListCellLoadCount.length > 0)
         {
            _loc2_ = !!_playerListCellLoadCount[param1.playerInfo.ID]?int(_playerListCellLoadCount[param1.playerInfo.ID]):0;
            if(_loc2_ >= 3)
            {
               _controller.roomPlayerRemoveSend(LanguageMgr.GetTranslation("tank.hotSpring.room.load.error"));
               return;
            }
         }
         _playerListCellLoadCount.add(param1.playerInfo.ID,_loc2_ + 1);
         _currentLoadingPlayer = new HotSpringPlayer(param1,addPlayerCallBack);
      }
      
      private function addPlayerCallBack(param1:HotSpringPlayer, param2:Boolean, param3:int = 0) : void
      {
         var _loc4_:* = null;
         _currentLoadingPlayer = null;
         if(!param2)
         {
            _loc4_ = param1.playerVO.clone();
            _playerList.remove(_loc4_.playerInfo.ID);
            _playerListFailure.add(_loc4_.playerInfo.ID,_loc4_);
            if(param1)
            {
               param1.dispose();
            }
            param1 = null;
            _isPlayerListLoading = false;
            return;
         }
         param1.playerPoint = param1.playerVO.playerPos;
         param1.sceneScene = _sceneScene;
         var _loc5_:* = param1.playerVO.scenePlayerDirection;
         param1.sceneCharacterDirection = _loc5_;
         param1.setSceneCharacterDirectionDefault = _loc5_;
         param1.playerVO.currentlyArea = getCurrentAreaType(param1.playerVO.playerPos.x,param1.playerVO.playerPos.y);
         if(!_selfPlayer && param1.playerVO.playerInfo.ID == PlayerManager.Instance.Self.ID)
         {
            _selfPlayer = param1;
            _playerLayer.addChild(_selfPlayer);
            setCenter();
            _selfPlayer.addEventListener("characterMovement",setCenter);
            _selfPlayer.addEventListener("characterActionChange",playerActionChange);
            PlayerManager.Instance.Self.addEventListener("propertychange",playerPropChanged);
         }
         else
         {
            _playerLayer.addChild(param1);
         }
         _hotSpringPlayerList.add(param1.playerVO.playerInfo.ID,param1);
         _playerList.remove(param1.playerVO.playerInfo.ID);
         _playerListFailure.remove(param1.playerVO.playerInfo.ID);
         _playerListCellLoadCount.remove(param1.playerVO.playerInfo.ID);
         _isPlayerListLoading = false;
         param1.isShowName = _isShowName;
         param1.isChatBall = _isChatBall;
         param1.isShowPlayer = _isShowPalyer;
      }
      
      private function roomTimeUp(param1:int, param2:Boolean = false) : void
      {
         expUpPlayer(param1);
         _sysDateTime.seconds = _sysDateTime.seconds + 60;
         sysDateTimeScene(_sysDateTime);
      }
      
      private function playerPropChanged(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["Grade"] && PlayerManager.Instance.Self.IsUpGrade)
         {
            _grade = new GradeContainer(true);
            _grade.y = -122;
            _grade.x = -40;
            _grade.playerGrade();
            _selfPlayer.addChild(_grade);
            PlayerManager.Instance.Self.IsUpGrade = false;
         }
      }
      
      private function roomTimeUpdate(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc4_:int = _loc2_.readInt();
         var _loc3_:int = _loc2_.readInt();
         var _loc5_:int = _loc2_.readInt();
         HotSpringManager.instance.roomCurrently.effectiveTime = _loc4_;
         HotSpringManager.instance.playerEffectiveTime = _loc4_;
         if(HotSpringManager.instance.roomCurrently.roomType == 1 || HotSpringManager.instance.roomCurrently.roomType == 2)
         {
            _countDown.setFrame(2);
            _countDownTxt.text = _loc4_ + LanguageMgr.GetTranslation("tank.hotSpring.room.time.minute");
            _energy.setFrame(2);
            _energyTxt.text = _loc5_.toString();
         }
         else
         {
            _countDown.setFrame(1);
            _countDownTxt.text = _loc4_ + LanguageMgr.GetTranslation("tank.hotSpring.room.time.minute");
            _energy.setFrame(1);
            _energyTxt.text = _loc5_.toString();
         }
      }
      
      private function sysDateTimeScene(param1:Date) : void
      {
         _sysDateTime = param1;
         var _loc2_:int = _sysDateTime.getHours();
         var _loc3_:int = _sysDateTime.getUTCMinutes();
         _dayStart = new Date(_sysDateTime.getFullYear(),_sysDateTime.getMonth(),_sysDateTime.getDate(),5,30);
         _dayEnd = new Date(_sysDateTime.getFullYear(),_sysDateTime.getMonth(),_sysDateTime.getDate(),6,30);
         _nightStart = new Date(_sysDateTime.getFullYear(),_sysDateTime.getMonth(),_sysDateTime.getDate(),17,30);
         _nightEnd = new Date(_sysDateTime.getFullYear(),_sysDateTime.getMonth(),_sysDateTime.getDate(),18,30);
         if(_sysDateTime >= _dayEnd && _sysDateTime <= _nightStart)
         {
            if(_SceneType == 1)
            {
               return;
            }
            _SceneType = 1;
            removeSceneNight();
            addSceneDay();
         }
         else if(_sysDateTime >= _nightEnd || _sysDateTime < _dayStart)
         {
            if(_SceneType == 2)
            {
               return;
            }
            _SceneType = 2;
            removeSceneDay();
            addSceneNight();
         }
         else
         {
            if(_SceneType != 3)
            {
               removeSceneDay();
               removeSceneNight();
            }
            _SceneType = 3;
            dayAndNight();
         }
      }
      
      private function addSceneDay() : void
      {
         if(!_sceneFront)
         {
            _sceneFront = ClassUtils.CreatInstance("asset.hotSpring.HotSpringDaySceneFrontAsset");
         }
         if(!_sceneFront2)
         {
            _sceneFront2 = ClassUtils.CreatInstance("asset.hotSpring.HotSpringDaySceneFront2Asset");
         }
         if(!_sceneBack)
         {
            _sceneBack = ComponentFactory.Instance.creatBitmap("asset.hotSpring.HotSpringDaySceneBackAsset");
         }
         if(_playerLayer.house.dayHouse && !_playerLayer.house.contains(_playerLayer.house.dayHouse))
         {
            _playerLayer.house.addChild(_playerLayer.house.dayHouse);
         }
         if(_playerLayer.tree.dayTree && !_playerLayer.tree.contains(_playerLayer.tree.dayTree))
         {
            _playerLayer.tree.addChild(_playerLayer.tree.dayTree);
         }
         if(_playerLayer.stove.dayStove && !_playerLayer.stove.contains(_playerLayer.stove.dayStove))
         {
            _playerLayer.stove.addChild(_playerLayer.stove.dayStove);
         }
         if(!_sceneBackBox.contains(_sceneBack))
         {
            _sceneBackBox.addChild(_sceneBack);
         }
         if(!_hotSpringViewAsset.contains(_sceneFront))
         {
            _hotSpringViewAsset.addChildAt(_sceneFront,0);
         }
         _sceneFront2.x = 0.1;
         _sceneFront2.y = 81.7;
         if(!_hotSpringViewAsset.contains(_sceneFront2))
         {
            _hotSpringViewAsset.addChild(_sceneFront2);
         }
      }
      
      private function removeSceneDay() : void
      {
         if(_sceneFront && _sceneFront.parent)
         {
            _sceneFront.parent.removeChild(_sceneFront);
         }
         _sceneFront = null;
         if(_sceneFront2 && _sceneFront2.parent)
         {
            _sceneFront2.parent.removeChild(_sceneFront2);
         }
         _sceneFront2 = null;
         if(_sceneBack && _sceneBack.parent)
         {
            _sceneBack.parent.removeChild(_sceneBack);
         }
         _sceneBack = null;
         if(_playerLayer.house.dayHouse && _playerLayer.house.dayHouse.parent)
         {
            _playerLayer.house.dayHouse.parent.removeChild(_playerLayer.house.dayHouse);
         }
         if(_playerLayer.tree.dayTree && _playerLayer.tree.dayTree.parent)
         {
            _playerLayer.tree.dayTree.parent.removeChild(_playerLayer.tree.dayTree);
         }
         if(_playerLayer.stove.dayStove && _playerLayer.stove.dayStove.parent)
         {
            _playerLayer.stove.dayStove.parent.removeChild(_playerLayer.stove.dayStove);
         }
      }
      
      private function addSceneNight() : void
      {
         if(!_sceneFront)
         {
            _sceneFront = ClassUtils.CreatInstance("asset.hotSpring.HotSpringNightSceneFrontAsset");
         }
         if(!_sceneFront2)
         {
            _sceneFront2 = ClassUtils.CreatInstance("asset.hotSpring.HotSpringNightSceneFront2Asset");
         }
         if(!_sceneBack)
         {
            _sceneBack = ComponentFactory.Instance.creatBitmap("asset.hotSpring.HotSpringNightSceneBackAsset");
         }
         if(_playerLayer.house.nightHouse && !_playerLayer.house.contains(_playerLayer.house.nightHouse))
         {
            _playerLayer.house.addChild(_playerLayer.house.nightHouse);
         }
         if(_playerLayer.tree.nightTree && !_playerLayer.tree.contains(_playerLayer.tree.nightTree))
         {
            _playerLayer.tree.addChild(_playerLayer.tree.nightTree);
         }
         if(_playerLayer.stove.nightStove && !_playerLayer.stove.contains(_playerLayer.stove.nightStove))
         {
            _playerLayer.stove.addChild(_playerLayer.stove.nightStove);
         }
         if(!_sceneBackBox.contains(_sceneBack))
         {
            _sceneBackBox.addChild(_sceneBack);
         }
         if(!_hotSpringViewAsset.contains(_sceneFront))
         {
            _hotSpringViewAsset.addChildAt(_sceneFront,0);
         }
         _sceneFront2.x = 0.1;
         _sceneFront2.y = 81.7;
         if(!_hotSpringViewAsset.contains(_sceneFront2))
         {
            _hotSpringViewAsset.addChild(_sceneFront2);
         }
      }
      
      private function removeSceneNight() : void
      {
         if(_sceneFrontNight && _sceneFrontNight.parent)
         {
            _sceneFrontNight.parent.removeChild(_sceneFrontNight);
         }
         _sceneFrontNight = null;
         if(_sceneFrontNight2 && _sceneFrontNight2.parent)
         {
            _sceneFrontNight2.parent.removeChild(_sceneFrontNight2);
         }
         _sceneFrontNight2 = null;
         if(_sceneBackNight && _sceneBackNight.parent)
         {
            _sceneBackNight.parent.removeChild(_sceneBackNight);
         }
         _sceneBackNight = null;
         if(_playerLayer.house.nightHouse && _playerLayer.house.nightHouse.parent)
         {
            _playerLayer.house.nightHouse.parent.removeChild(_playerLayer.house.nightHouse);
         }
         if(_playerLayer.tree.nightTree && _playerLayer.tree.nightTree.parent)
         {
            _playerLayer.tree.nightTree.parent.removeChild(_playerLayer.tree.nightTree);
         }
         if(_playerLayer.stove.nightStove && _playerLayer.stove.nightStove.parent)
         {
            _playerLayer.stove.nightStove.parent.removeChild(_playerLayer.stove.nightStove);
         }
      }
      
      private function dayAndNight() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(!_sceneFront)
         {
            _sceneFront = ClassUtils.CreatInstance("asset.hotSpring.HotSpringDaySceneFrontAsset");
         }
         if(!_sceneFront2)
         {
            _sceneFront2 = ClassUtils.CreatInstance("asset.hotSpring.HotSpringDaySceneFront2Asset");
         }
         if(!_sceneBack)
         {
            _sceneBack = ComponentFactory.Instance.creatBitmap("asset.hotSpring.HotSpringDaySceneBackAsset");
         }
         if(!_sceneFrontNight)
         {
            _sceneFrontNight = ClassUtils.CreatInstance("asset.hotSpring.HotSpringNightSceneFrontAsset");
         }
         if(!_sceneFrontNight2)
         {
            _sceneFrontNight2 = ClassUtils.CreatInstance("asset.hotSpring.HotSpringNightSceneFront2Asset");
         }
         if(!_sceneBackNight)
         {
            _sceneBackNight = ComponentFactory.Instance.creatBitmap("asset.hotSpring.HotSpringNightSceneBackAsset");
         }
         var _loc4_:* = 0.1;
         _sceneFrontNight2.x = _loc4_;
         _sceneFront2.x = _loc4_;
         _loc4_ = 81.7;
         _sceneFrontNight2.y = _loc4_;
         _sceneFront2.y = _loc4_;
         var _loc3_:* = 60;
         if(_sysDateTime >= _dayStart && _sysDateTime <= _dayEnd)
         {
            if(!_sceneBackBox.contains(_sceneBackNight))
            {
               _sceneBackBox.addChild(_sceneBackNight);
            }
            if(!_hotSpringViewAsset.contains(_sceneFrontNight))
            {
               _hotSpringViewAsset.addChildAt(_sceneFrontNight,0);
            }
            if(!_hotSpringViewAsset.contains(_sceneFrontNight2))
            {
               _hotSpringViewAsset.addChild(_sceneFrontNight2);
            }
            if(!_sceneBackBox.contains(_sceneBack))
            {
               _sceneBackBox.addChild(_sceneBack);
            }
            if(!_hotSpringViewAsset.contains(_sceneFront))
            {
               _hotSpringViewAsset.addChildAt(_sceneFront,1);
            }
            if(!_hotSpringViewAsset.contains(_sceneFront2))
            {
               _hotSpringViewAsset.addChild(_sceneFront2);
            }
            if(_playerLayer.house.nightHouse && !_playerLayer.house.contains(_playerLayer.house.nightHouse))
            {
               _playerLayer.house.addChild(_playerLayer.house.nightHouse);
            }
            if(_playerLayer.tree.nightTree && !_playerLayer.tree.contains(_playerLayer.tree.nightTree))
            {
               _playerLayer.tree.addChild(_playerLayer.tree.nightTree);
            }
            if(_playerLayer.stove.nightStove && !_playerLayer.stove.contains(_playerLayer.stove.nightStove))
            {
               _playerLayer.stove.addChild(_playerLayer.stove.nightStove);
            }
            _playerLayer.house.dayHouse.y = _playerLayer.house.dayHouse.y - 1;
            _playerLayer.house.nightHouse.y = _playerLayer.house.nightHouse.y + 1;
            if(_playerLayer.house.dayHouse && !_playerLayer.house.contains(_playerLayer.house.dayHouse))
            {
               _playerLayer.house.addChild(_playerLayer.house.dayHouse);
            }
            if(_playerLayer.tree.dayTree && !_playerLayer.tree.contains(_playerLayer.tree.dayTree))
            {
               _playerLayer.tree.addChild(_playerLayer.tree.dayTree);
            }
            if(_playerLayer.stove.dayStove && !_playerLayer.stove.contains(_playerLayer.stove.dayStove))
            {
               _playerLayer.stove.addChild(_playerLayer.stove.dayStove);
            }
            _loc1_ = (_sysDateTime.getHours() - 5) * 60 - 30 + _sysDateTime.minutes;
            _loc2_ = (_loc1_ / _loc3_ * 100).toFixed(2);
            if(_sceneFront2.daySun && _sceneFront2.daySun.parent)
            {
               _sceneFront2.daySun.parent.removeChild(_sceneFront2.daySun);
            }
            _sceneFront2.daySun = null;
            if(_sceneFront2.dayFlower && _sceneFront2.dayFlower.parent)
            {
               _sceneFront2.dayFlower.parent.removeChild(_sceneFront2.dayFlower);
            }
            _sceneFront2.dayFlower = null;
            _loc4_ = _loc2_ / 100;
            _playerLayer.stove.dayStove.alpha = _loc4_;
            _loc4_ = _loc4_;
            _playerLayer.tree.dayTree.alpha = _loc4_;
            _loc4_ = _loc4_;
            _playerLayer.house.dayHouse.alpha = _loc4_;
            _loc4_ = _loc4_;
            _sceneBack.alpha = _loc4_;
            _loc4_ = _loc4_;
            _sceneFront2.alpha = _loc4_;
            _sceneFront.alpha = _loc4_;
            _sceneFrontNight2.nightFirefly.alpha = 1 - _loc2_ / 100;
            if(_loc2_ / 100 >= 1)
            {
               removeSceneNight();
            }
         }
         else if(_sysDateTime >= _nightStart && _sysDateTime <= _nightEnd)
         {
            if(!_sceneBackBox.contains(_sceneBack))
            {
               _sceneBackBox.addChild(_sceneBack);
            }
            if(!_hotSpringViewAsset.contains(_sceneFront))
            {
               _hotSpringViewAsset.addChildAt(_sceneFront,0);
            }
            if(!_hotSpringViewAsset.contains(_sceneFront2))
            {
               _hotSpringViewAsset.addChild(_sceneFront2);
            }
            if(!_sceneBackBox.contains(_sceneBackNight))
            {
               _sceneBackBox.addChild(_sceneBackNight);
            }
            if(!_hotSpringViewAsset.contains(_sceneFrontNight))
            {
               _hotSpringViewAsset.addChildAt(_sceneFrontNight,1);
            }
            if(!_hotSpringViewAsset.contains(_sceneFrontNight2))
            {
               _hotSpringViewAsset.addChild(_sceneFrontNight2);
            }
            if(_playerLayer.house.dayHouse && !_playerLayer.house.contains(_playerLayer.house.dayHouse))
            {
               _playerLayer.house.addChild(_playerLayer.house.dayHouse);
            }
            if(_playerLayer.tree.dayTree && !_playerLayer.tree.contains(_playerLayer.tree.dayTree))
            {
               _playerLayer.tree.addChild(_playerLayer.tree.dayTree);
            }
            if(_playerLayer.stove.dayStove && !_playerLayer.stove.contains(_playerLayer.stove.dayStove))
            {
               _playerLayer.stove.addChild(_playerLayer.stove.dayStove);
            }
            if(_playerLayer.house.nightHouse && !_playerLayer.house.contains(_playerLayer.house.nightHouse))
            {
               _playerLayer.house.addChild(_playerLayer.house.nightHouse);
            }
            if(_playerLayer.tree.nightTree && !_playerLayer.tree.contains(_playerLayer.tree.nightTree))
            {
               _playerLayer.tree.addChild(_playerLayer.tree.nightTree);
            }
            if(_playerLayer.stove.nightStove && !_playerLayer.stove.contains(_playerLayer.stove.nightStove))
            {
               _playerLayer.stove.addChild(_playerLayer.stove.nightStove);
            }
            _loc1_ = (_sysDateTime.getHours() - 17) * 60 - 30 + _sysDateTime.minutes;
            _loc2_ = (_loc1_ / _loc3_ * 100).toFixed(2);
            if(_sceneFront2.daySun && _sceneFront2.daySun.parent)
            {
               _sceneFront2.daySun.parent.removeChild(_sceneFront2.daySun);
            }
            _sceneFront2.daySun = null;
            if(_sceneFrontNight2.nightFirefly && _sceneFrontNight2.nightFirefly.parent)
            {
               _sceneFrontNight2.nightFirefly.parent.removeChild(_sceneFrontNight2.nightFirefly);
            }
            _sceneFrontNight2.nightFirefly = null;
            _loc4_ = _loc2_ / 100;
            _playerLayer.stove.nightStove.alpha = _loc4_;
            _loc4_ = _loc4_;
            _playerLayer.tree.nightTree.alpha = _loc4_;
            _loc4_ = _loc4_;
            _playerLayer.house.nightHouse.alpha = _loc4_;
            _loc4_ = _loc4_;
            _sceneBackNight.alpha = _loc4_;
            _loc4_ = _loc4_;
            _sceneFrontNight2.alpha = _loc4_;
            _sceneFrontNight.alpha = _loc4_;
            _sceneFront2.dayFlower.alpha = 1 - _loc2_ / 100;
            if(_loc2_ / 100 >= 1)
            {
               removeSceneDay();
            }
         }
      }
      
      private function roomToolMenu(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = param1.currentTarget;
         if(_ShowNameBtn !== _loc2_)
         {
            if(_ShowPaoBtn !== _loc2_)
            {
               if(_ShowPlayerBtn === _loc2_)
               {
                  _isShowPalyer = !_isShowPalyer;
                  _ShowPlayerBtn.setFrame(!!_isShowPalyer?1:2);
               }
            }
            else
            {
               _isChatBall = !_isChatBall;
               _ShowPaoBtn.setFrame(!!_isChatBall?1:2);
            }
         }
         else
         {
            _isShowName = !_isShowName;
            _ShowNameBtn.setFrame(!!_isShowName?1:2);
         }
         setPlayerShowItem();
      }
      
      private function setPlayerShowItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < _playerLayer.numChildren)
         {
            _loc1_ = _playerLayer.getChildAt(_loc2_) as HotSpringPlayer;
            if(_loc1_)
            {
               _loc1_.isShowName = _isShowName;
               _loc1_.isChatBall = _isChatBall;
               _loc1_.isShowPlayer = _isShowPalyer;
               if(_loc1_.playerVO.playerInfo.ID != PlayerManager.Instance.Self.ID)
               {
                  _loc1_.character.visible = _isShowPalyer;
               }
               _loc1_.visible = _loc1_.playerVO.playerInfo.ID != PlayerManager.Instance.Self.ID?_isShowPalyer:true;
            }
            _loc2_++;
         }
      }
      
      private function addPlayer(param1:HotSpringRoomEvent) : void
      {
         var _loc2_:PlayerVO = param1.data as PlayerVO;
         _playerList.add(_loc2_.playerInfo.ID,_loc2_);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(!_isPlayerListLoading)
         {
            playerLoad();
         }
         if(!_hotSpringPlayerList || _hotSpringPlayerList.length <= 0)
         {
            return;
         }
         var _loc4_:int = 0;
         var _loc3_:* = _hotSpringPlayerList.list;
         for each(var _loc2_ in _hotSpringPlayerList.list)
         {
            _loc2_.updatePlayer();
         }
         BuildEntityDepth();
      }
      
      private function getPointDepth(param1:Number, param2:Number) : Number
      {
         return _mapVO.mapWidth * param2 + param1;
      }
      
      private function BuildEntityDepth() : void
      {
         var _loc9_:int = 0;
         var _loc4_:* = null;
         var _loc8_:Number = NaN;
         var _loc7_:* = 0;
         var _loc5_:* = NaN;
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc1_:Number = NaN;
         var _loc2_:int = _playerLayer.numChildren;
         _loc9_ = 0;
         while(_loc9_ < _loc2_ - 1)
         {
            _loc4_ = _playerLayer.getChildAt(_loc9_);
            _loc8_ = this.getPointDepth(_loc4_.x,_loc4_.y);
            _loc5_ = 1.79769313486232e308;
            _loc6_ = _loc9_ + 1;
            while(_loc6_ < _loc2_)
            {
               _loc3_ = _playerLayer.getChildAt(_loc6_);
               _loc1_ = this.getPointDepth(_loc3_.x,_loc3_.y);
               if(_loc1_ < _loc5_)
               {
                  _loc7_ = _loc6_;
                  _loc5_ = _loc1_;
               }
               _loc6_++;
            }
            if(_loc8_ > _loc5_)
            {
               _playerLayer.swapChildrenAt(_loc9_,_loc7_);
            }
            _loc9_++;
         }
      }
      
      private function removePlayer(param1:HotSpringRoomEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = param1.data;
         var _loc3_:HotSpringPlayer = _hotSpringPlayerList[_loc2_] as HotSpringPlayer;
         _hotSpringPlayerList.remove(_loc2_);
         if(_playerList)
         {
            _playerList.remove(_loc2_);
         }
         if(_playerListFailure)
         {
            _playerListFailure.remove(_loc2_);
         }
         if(_playerListCellLoadCount)
         {
            _playerListCellLoadCount.remove(_loc2_);
         }
         if(!_loc3_)
         {
            _loc4_ = 0;
            while(_loc4_ < _playerLayer.numChildren)
            {
               _loc3_ = _playerLayer.getChildAt(_loc4_) as HotSpringPlayer;
               if(_loc3_ && _loc3_.playerVO.playerInfo.ID == _loc2_)
               {
                  _loc3_.removeEventListener("characterActionChange",playerActionChange);
                  if(_loc3_.parent)
                  {
                     _loc3_.parent.removeChild(_loc3_);
                  }
                  _loc3_.dispose();
                  _loc3_ = null;
                  break;
               }
               _loc4_++;
            }
         }
         if(_loc3_)
         {
            _loc3_.removeEventListener("characterActionChange",playerActionChange);
            if(_loc3_.parent)
            {
               _loc3_.parent.removeChild(_loc3_);
            }
            _loc3_.dispose();
            _loc3_ = null;
         }
         if(_loc2_ == PlayerManager.Instance.Self.ID)
         {
            _selfPlayer.removeEventListener("characterMovement",setCenter);
            PlayerManager.Instance.Self.removeEventListener("propertychange",playerPropChanged);
            StateManager.setState("hotSpringRoomList");
         }
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         if(!_selfPlayer)
         {
            return;
         }
         var _loc2_:Point = _hotSpringViewAsset.globalToLocal(new Point(param1.stageX,param1.stageY));
         if(getTimer() - _lastClick > _clickInterval)
         {
            _lastClick = getTimer();
            if(!_sceneScene.hit(_loc2_))
            {
               _selfPlayer.playerVO.walkPath = _sceneScene.searchPath(_selfPlayer.playerPoint,_loc2_);
               _selfPlayer.playerVO.walkPath.shift();
               _selfPlayer.playerVO.scenePlayerDirection = SceneCharacterDirection.getDirection(_selfPlayer.playerPoint,_selfPlayer.playerVO.walkPath[0]);
               _selfPlayer.playerVO.currentWalkStartPoint = _selfPlayer.currentWalkStartPoint;
               _controller.roomPlayerTargetPointSend(_selfPlayer.playerVO);
               _mouseMovie.x = _loc2_.x;
               _mouseMovie.y = _loc2_.y;
               _mouseMovie.play();
            }
         }
      }
      
      private function setCenter(param1:SceneCharacterEvent = null) : void
      {
         if(!stage || !_model || !_model.mapVO)
         {
            return;
         }
         var _loc3_:* = Number(-(_selfPlayer.x - stage.stageWidth / 2));
         var _loc2_:* = Number(-(_selfPlayer.y - stage.stageHeight / 2) + 50);
         if(_loc3_ > 0)
         {
            _loc3_ = 0;
         }
         if(_loc3_ < stage.stageWidth - _model.mapVO.mapWidth)
         {
            _loc3_ = Number(stage.stageWidth - _model.mapVO.mapWidth);
         }
         if(_loc2_ > 0)
         {
            _loc2_ = 0;
         }
         if(_loc2_ < stage.stageHeight - _model.mapVO.mapHeight)
         {
            _loc2_ = Number(stage.stageHeight - _model.mapVO.mapHeight);
         }
         if(_loc3_ > 0)
         {
            _loc3_ = 0;
         }
         if(_loc2_ > 0)
         {
            _loc2_ = 0;
         }
         _hotSpringViewAsset.x = _loc3_;
         _hotSpringViewAsset.y = _loc2_;
         _sceneBackBox.x = _loc3_ * 0.6 - 40;
         _sceneBackBox.y = _loc2_ * 0.6 - 10;
      }
      
      private function playerActionChange(param1:SceneCharacterEvent) : void
      {
         var _loc2_:String = param1.data.toString();
         if(_loc2_ == "naturalStandFront" || _loc2_ == "naturalStandBack" || _loc2_ == "waterFrontEyes" || _loc2_ == "waterStandBack")
         {
            _mouseMovie.gotoAndStop(1);
         }
      }
      
      public function expUpPlayer(param1:int) : void
      {
         if(!_selfPlayer || !_selfPlayer.playerVO)
         {
            return;
         }
         if(!_expUpBox)
         {
            _expUpBox = new Sprite();
         }
         if(!_expUpAsset)
         {
            _expUpAsset = ComponentFactory.Instance.creatBitmap("asset.hotSpring.iconExpUPAsset");
         }
         if(!_expUpText)
         {
            _expUpText = ComponentFactory.Instance.creatComponentByStylename("hotSpring.room.txtExpUPAsset");
         }
         _expUpBox.addChild(_expUpAsset);
         _expUpBox.addChild(_expUpText);
         _expUpBox.x = (_selfPlayer.playerWitdh - 75) / 2 - _selfPlayer.playerWitdh / 2;
         _expUpBox.y = _selfPlayer.playerVO.currentlyArea == 1?-_selfPlayer.playerHeight - 30:Number(-_selfPlayer.playerHeight + 33);
         _selfPlayer.addChild(_expUpBox);
         _expUpText.text = "điểm hoạt bát +" + param1.toString();
         expUpMoviePlayer();
      }
      
      private function expUpMoviePlayer() : void
      {
         _expUpText.y = 22;
         _expUpText.alpha = 0;
         TweenLite.to(_expUpText,0.4,{
            "y":0,
            "alpha":1,
            "onComplete":onOut
         });
         _expUpAsset.y = 40;
         _expUpAsset.alpha = 0;
         TweenLite.to(_expUpAsset,0.4,{
            "y":26,
            "alpha":1,
            "delay":0.2,
            "onComplete":onOut1
         });
      }
      
      private function onOut() : void
      {
         TweenLite.to(_expUpText,0.4,{
            "y":-20,
            "alpha":0,
            "delay":1
         });
      }
      
      private function onOut1() : void
      {
         TweenLite.to(_expUpAsset,0.4,{
            "y":0,
            "alpha":0,
            "delay":0.9,
            "onComplete":removeExpUpMovie
         });
      }
      
      private function removeExpUpMovie() : void
      {
         if(_expUpBox && _expUpBox.parent)
         {
            _expUpBox.parent.removeChild(_expUpBox);
         }
      }
      
      public function show() : void
      {
         _controller.addChild(this);
      }
      
      public function hide() : void
      {
         _controller.removeChild(this);
      }
      
      public function dispose() : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc2_:* = null;
         TweenLite.killTweensOf(_expUpText);
         TweenLite.killTweensOf(_expUpAsset);
         removeEventListener("enterFrame",onEnterFrame);
         removeEventListener("click",onMouseClick);
         _ShowNameBtn.removeEventListener("click",roomToolMenu);
         _ShowPaoBtn.removeEventListener("click",roomToolMenu);
         _ShowPlayerBtn.removeEventListener("click",roomToolMenu);
         if(_selfPlayer)
         {
            _selfPlayer.removeEventListener("characterMovement",setCenter);
         }
         if(_selfPlayer)
         {
            _selfPlayer.removeEventListener("characterActionChange",playerActionChange);
         }
         _model.removeEventListener("roomPlayerAdd",addPlayer);
         _model.removeEventListener("roomPlayerRemove",removePlayer);
         HotSpringManager.instance.removeEventListener("roomPlayerRemove",removePlayer);
         PlayerManager.Instance.Self.removeEventListener("propertychange",playerPropChanged);
         SocketManager.Instance.removeEventListener(PkgEvent.format(191,7),roomTimeUpdate);
         removeEventListener("addedToStage",__onStageAddInitMapPath);
         _HpLittleGameNpc.removeEventListener("click",__npcClickHander);
         _HpLittleGameNpc.removeEventListener("mouseOver",__npcOverHander);
         _HpLittleGameNpc.removeEventListener("mouseOut",__npcOutHandler);
         _playerListFailure.clear();
         _playerListFailure = null;
         _playerListCellLoadCount.clear();
         _playerListCellLoadCount = null;
         if(_ShowNameBtn)
         {
            ObjectUtils.disposeObject(_ShowNameBtn);
         }
         _ShowNameBtn = null;
         if(_ShowPaoBtn)
         {
            ObjectUtils.disposeObject(_ShowPaoBtn);
         }
         _ShowPaoBtn = null;
         if(_ShowPlayerBtn)
         {
            ObjectUtils.disposeObject(_ShowPlayerBtn);
         }
         _ShowPlayerBtn = null;
         if(_countDown)
         {
            ObjectUtils.disposeObject(_countDown);
         }
         _countDown = null;
         if(_energy)
         {
            ObjectUtils.disposeObject(_energy);
         }
         _energy = null;
         if(_countDownTxt)
         {
            ObjectUtils.disposeObject(_countDownTxt);
         }
         _countDownTxt = null;
         if(_energyTxt)
         {
            ObjectUtils.disposeObject(_energyTxt);
         }
         _energyTxt = null;
         if(_roomNumTxt)
         {
            ObjectUtils.disposeObject(_roomNumTxt);
         }
         _roomNumTxt = null;
         ObjectUtils.disposeObject(_grade);
         _grade = null;
         ObjectUtils.disposeObject(_waterArea);
         _waterArea = null;
         ObjectUtils.disposeObject(_roomNum);
         _roomNum = null;
         if(_sceneScene)
         {
            _sceneScene.dispose();
         }
         _sceneScene = null;
         ObjectUtils.disposeObject(_HpLittleGameNpc);
         _HpLittleGameNpc = null;
         if(_roomMenuView)
         {
            if(_roomMenuView.parent)
            {
               _roomMenuView.parent.removeChild(_roomMenuView);
            }
            _roomMenuView.dispose();
         }
         _roomMenuView = null;
         if(_chatFrame && _chatFrame.parent)
         {
            _chatFrame.parent.removeChild(_chatFrame);
         }
         _chatFrame = null;
         if(_sceneFront && _sceneFront.parent)
         {
            _sceneFront.parent.removeChild(_sceneFront);
         }
         _sceneFront = null;
         if(_sceneFront2 && _sceneFront2.parent)
         {
            _sceneFront2.parent.removeChild(_sceneFront2);
         }
         _sceneFront2 = null;
         ObjectUtils.disposeObject(_sceneBack);
         _sceneBack = null;
         if(_sceneFrontNight && _sceneFrontNight.parent)
         {
            _sceneFrontNight.parent.removeChild(_sceneFrontNight);
         }
         _sceneFrontNight = null;
         if(_sceneFrontNight2 && _sceneFrontNight2.parent)
         {
            _sceneFrontNight2.parent.removeChild(_sceneFrontNight2);
         }
         _sceneFrontNight2 = null;
         ObjectUtils.disposeObject(_sceneBackNight);
         _sceneBackNight = null;
         if(_hotSpringViewAsset.maskPath && _hotSpringViewAsset.maskPath.parent)
         {
            _hotSpringViewAsset.maskPath.parent.removeChild(_hotSpringViewAsset.maskPath);
         }
         if(_hotSpringViewAsset.layerWater && _hotSpringViewAsset.layerWater.parent)
         {
            _hotSpringViewAsset.layerWater.parent.removeChild(_hotSpringViewAsset.layerWater);
         }
         if(_sceneBackBox && _sceneBackBox.parent)
         {
            _sceneBackBox.parent.removeChild(_sceneBackBox);
         }
         _sceneBackBox = null;
         if(_mouseMovie && _mouseMovie.parent)
         {
            _mouseMovie.parent.removeChild(_mouseMovie);
         }
         _mouseMovie = null;
         while(_model.roomPlayerList && _model.roomPlayerList.list.length > 0)
         {
            _loc4_ = _model.roomPlayerList.list[0] as PlayerVO;
            if(_loc4_)
            {
               _loc4_.dispose();
            }
            _loc4_ = null;
            _model.roomPlayerList.list.shift();
         }
         if(_model.roomPlayerList)
         {
            _model.roomPlayerList.clear();
         }
         while(_playerList && _playerList.length > 0)
         {
            _loc3_ = _playerList.list[0] as PlayerVO;
            if(_loc3_)
            {
               _loc3_.dispose();
            }
            _loc3_ = null;
            _playerList.list.shift();
         }
         _playerList.clear();
         _playerList = null;
         if(_selfPlayer)
         {
            if(_selfPlayer.parent)
            {
               _selfPlayer.parent.removeChild(_selfPlayer);
            }
            _selfPlayer.dispose();
         }
         _selfPlayer = null;
         if(_hotSpringPlayerList)
         {
            while(_hotSpringPlayerList.length > 0)
            {
               _loc1_ = _hotSpringPlayerList.list[0] as HotSpringPlayer;
               if(_loc1_)
               {
                  _loc1_.dispose();
               }
               _loc1_ = null;
               _hotSpringPlayerList.list.shift();
            }
            _hotSpringPlayerList.clear();
         }
         _hotSpringPlayerList = null;
         if(_playerLayer)
         {
            while(_playerLayer.numChildren > 0)
            {
               _loc2_ = _playerLayer.getChildAt(0) as HotSpringPlayer;
               if(_loc2_)
               {
                  _loc2_.dispose();
               }
               _loc2_ = null;
               _playerLayer.removeChildAt(0);
            }
         }
         if(_playerLayer && _playerLayer.parent)
         {
            _playerLayer.parent.removeChild(_playerLayer);
         }
         _playerLayer = null;
         if(_boxButton)
         {
            ObjectUtils.disposeObject(_boxButton);
         }
         _boxButton = null;
         while(_playerWalkPath && _playerWalkPath.length > 0)
         {
            _playerWalkPath[0] = null;
            _playerWalkPath.shift();
         }
         _playerWalkPath = null;
         if(_currentLoadingPlayer)
         {
            _currentLoadingPlayer.dispose();
         }
         _currentLoadingPlayer = null;
         ObjectUtils.disposeObject(_expUpBox);
         _expUpBox = null;
         ObjectUtils.disposeObject(_expUpAsset);
         _expUpAsset = null;
         ObjectUtils.disposeObject(_expUpText);
         _expUpText = null;
         if(_hotSpringViewAsset && _hotSpringViewAsset.parent)
         {
            _hotSpringViewAsset.parent.removeChild(_hotSpringViewAsset);
         }
         _hotSpringViewAsset = null;
         _defaultPoint = null;
         _mapVO = null;
         CacheSysManager.unlock("alertInHotSpring");
         CacheSysManager.getInstance().release("alertInHotSpring");
      }
   }
}
