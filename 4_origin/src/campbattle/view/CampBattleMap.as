package campbattle.view
{
   import campbattle.CampBattleControl;
   import campbattle.CampBattleManager;
   import campbattle.data.RoleData;
   import campbattle.view.roleView.CampBattleMonsterRole;
   import campbattle.view.roleView.CampBattleOtherRole;
   import campbattle.view.roleView.CampBattlePlayer;
   import campbattle.view.roleView.CampGameSmallEnemy;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import ddt.view.scenePathSearcher.PathMapHitTester;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import game.objects.GameLiving;
   import gameCommon.model.SmallEnemy;
   import hall.event.NewHallEvent;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class CampBattleMap extends Sprite
   {
      
      public static const GAME_WIDTH:int = 1000;
      
      public static const GAME_HEIGHT:int = 600;
      
      public static var MAP_SIZE:Array = [3208,2000];
       
      
      protected var _mapClassDefinition:String;
      
      protected var _playerModel:DictionaryData;
      
      protected var _monsterModel:DictionaryData;
      
      protected var _bgLayer:Sprite;
      
      protected var _articleLayer:Sprite;
      
      protected var _decorationLayer:Sprite;
      
      protected var _meshLayer:Sprite;
      
      protected var _sceneScene:SceneScene;
      
      private var _roleList:Array;
      
      private var _monsterList:Array;
      
      private var _isLoadMapComplete:Boolean;
      
      private var _targetRole:CampBattlePlayer;
      
      private var _mainRole:CampBattlePlayer;
      
      private var _actItemList:Array;
      
      private var _gameLiving:GameLiving;
      
      private var _sendMove:Function;
      
      private var _mouseMovie:MovieClip;
      
      private var _antoObjList:Array;
      
      private var _lastClick:Number = 0;
      
      private var _clickInterval:Number = 200;
      
      private var _addMonsterTimer:TimerJuggler;
      
      private var _mIndex:int;
      
      private var _mapResUrl:String;
      
      private var _smallMap:Bitmap;
      
      private var _flagPlayer:Boolean;
      
      public function CampBattleMap(param1:String, param2:String, param3:DictionaryData = null, param4:DictionaryData = null, param5:Array = null, param6:Bitmap = null)
      {
         super();
         _actItemList = param5;
         _mapClassDefinition = param1;
         _playerModel = new DictionaryData();
         _playerModel.setData(param3);
         _monsterModel = param4;
         _roleList = [];
         _monsterList = [];
         _antoObjList = [];
         _mapResUrl = param2;
         _smallMap = param6;
         if(_smallMap)
         {
            addChild(_smallMap);
         }
         loaderMap(param2);
      }
      
      private function loaderMap(param1:String) : void
      {
         var _loc2_:BaseLoader = LoadResourceManager.Instance.createLoader(param1,4);
         _loc2_.addEventListener("complete",onMapLoadComplete);
         _loc2_.addEventListener("loadError",onMapLoadError);
         LoadResourceManager.Instance.startLoad(_loc2_);
      }
      
      protected function onMapLoadError(param1:LoaderEvent) : void
      {
         ChatManager.Instance.sysChatRed("地图资源加载出错Url=" + _mapResUrl);
      }
      
      private function onMapLoadComplete(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener("complete",onMapLoadComplete);
         _isLoadMapComplete = true;
         initMap();
         initEvent();
         initSceneScene();
         initPlayerList();
         initMonstersList();
      }
      
      private function initPlayerList() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _playerModel.length)
         {
            addRoleToMap(_playerModel.list[_loc1_]);
            _loc1_++;
         }
      }
      
      private function initMonstersList() : void
      {
         if(_monsterModel.length > 0)
         {
            _addMonsterTimer = TimerManager.getInstance().addTimerJuggler(500);
            _addMonsterTimer.repeatCount = _monsterModel.length;
            _addMonsterTimer.start();
            _addMonsterTimer.addEventListener("timer",__onMonsterTimerHander);
            _addMonsterTimer.addEventListener("timerComplete",__onMonsterTimerCompleteHander);
         }
      }
      
      private function __onMonsterTimerHander(param1:Event) : void
      {
         var _loc3_:* = null;
         var _loc2_:SmallEnemy = _monsterModel.list[_mIndex] as SmallEnemy;
         if(_loc2_ != null)
         {
            _loc3_ = new CampGameSmallEnemy(_loc2_);
            PositionUtils.setPos(_loc3_,_loc2_.pos);
            _monsterList.push(_loc3_);
            _antoObjList.push(_loc3_);
            _articleLayer.addChild(_loc3_);
            _mIndex = Number(_mIndex) + 1;
         }
      }
      
      private function __onMonsterTimerCompleteHander(param1:Event) : void
      {
         _addMonsterTimer.stop();
         _addMonsterTimer.removeEventListener("timer",__onMonsterTimerHander);
         _addMonsterTimer.removeEventListener("timerComplete",__onMonsterTimerCompleteHander);
         TimerManager.getInstance().removeJugglerByTimer(_addMonsterTimer);
         _addMonsterTimer = null;
         _mIndex = 0;
      }
      
      private function checkRoleList() : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(_roleList.length != _playerModel.length)
         {
            return;
         }
         var _loc4_:int = _roleList.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = _roleList[_loc5_] as CampBattlePlayer;
            if(!(_loc3_.playerInfo.zoneID == PlayerManager.Instance.Self.ZoneID && _loc3_.playerInfo.ID == PlayerManager.Instance.Self.ID))
            {
               _loc2_ = Math.abs(_mainRole.x - _loc3_.x);
               _loc1_ = Math.abs(_mainRole.y - _loc3_.y);
               _loc3_.visible = _loc2_ > 500 || _loc1_ > 300?false:true;
            }
            _loc5_++;
         }
      }
      
      protected function initEvent() : void
      {
         addEventListener("click",__onPlayerClickHander);
         addEventListener("enterFrame",enterFrameHander);
         if(_monsterModel)
         {
            _monsterModel.addEventListener("add",__onAddMonsters);
            _monsterModel.addEventListener("remove",__onRemoveMonsters);
         }
         _playerModel.addEventListener("add",__onAddPlayer);
         _playerModel.addEventListener("remove",__onRemovePlayer);
         _playerModel.addEventListener("update",__onUpdatePlayerStatus);
         PlayerManager.Instance.addEventListener("setselfplayerpos",__onSetSelfPlayerPos);
      }
      
      protected function __onSetSelfPlayerPos(param1:NewHallEvent) : void
      {
         __onPlayerClickHander(param1.data[0]);
      }
      
      protected function __onAddMonsters(param1:DictionaryEvent) : void
      {
         var _loc2_:CampGameSmallEnemy = new CampGameSmallEnemy(param1.data as SmallEnemy);
         _loc2_.setStateType((param1.data as SmallEnemy).stateType);
         _monsterList.push(_loc2_);
         _articleLayer.addChild(_loc2_);
         _antoObjList.push(_loc2_);
      }
      
      private function __onRemoveMonsters(param1:DictionaryEvent) : void
      {
         var _loc3_:int = (param1.data as SmallEnemy).LivingID;
         var _loc4_:int = getMonsterIndex(_loc3_);
         if(!_monsterList[_loc4_])
         {
            return;
         }
         var _loc2_:CampGameSmallEnemy = _monsterList[_loc4_] as CampGameSmallEnemy;
         _monsterList.splice(_loc4_,1);
         deleAntoObjList(_loc2_);
         _loc2_.dispose();
         _loc2_.dispose();
         _loc2_ = null;
      }
      
      public function getMonsterIndex(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = _monsterList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(param1 == CampGameSmallEnemy(_monsterList[_loc3_]).info.LivingID)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return 0;
      }
      
      private function __onPlayerClickHander(param1:MouseEvent) : void
      {
         if(!_mainRole || _mainRole.playerInfo.stateType == 4)
         {
            return;
         }
         _targetRole = null;
         var _loc2_:Point = new Point(mouseX,mouseY);
         if(getTimer() - _lastClick > _clickInterval)
         {
            _lastClick = getTimer();
            if(!_sceneScene.hit(_loc2_))
            {
               _mainRole.walk(_loc2_);
               _mouseMovie.x = _loc2_.x;
               _mouseMovie.y = _loc2_.y;
               _mouseMovie.play();
               SocketManager.Instance.out.CampbattleRoleMove(_mainRole.playerInfo.zoneID,_mainRole.playerInfo.ID,_loc2_);
            }
         }
      }
      
      protected function initMouseMovie() : void
      {
         var _loc1_:Class = ClassUtils.uiSourceDomain.getDefinition("asset.campBattle.MouseClickMovie") as Class;
         _mouseMovie = new _loc1_() as MovieClip;
         _mouseMovie.mouseChildren = false;
         _mouseMovie.mouseEnabled = false;
         _mouseMovie.stop();
         _bgLayer.addChild(_mouseMovie);
      }
      
      private function removeEvent() : void
      {
         if(_mainRole)
         {
            _mainRole.removeEventListener("characterActionChange",playerActionChange);
         }
         removeEventListener("click",__onPlayerClickHander);
         removeEventListener("enterFrame",enterFrameHander);
         if(_monsterModel)
         {
            _monsterModel.removeEventListener("add",__onAddMonsters);
            _monsterModel.removeEventListener("remove",__onRemoveMonsters);
         }
         _playerModel.removeEventListener("add",__onAddPlayer);
         _playerModel.removeEventListener("remove",__onRemovePlayer);
         _playerModel.removeEventListener("update",__onUpdatePlayerStatus);
         PlayerManager.Instance.removeEventListener("setselfplayerpos",__onSetSelfPlayerPos);
      }
      
      public function setCenter(param1:SceneCharacterEvent = null, param2:Boolean = true, param3:Point = null) : void
      {
         var _loc6_:* = NaN;
         var _loc4_:* = NaN;
         var _loc5_:* = null;
         if(_mainRole)
         {
            _loc5_ = _mainRole.playerPoint;
         }
         else
         {
            _loc5_ = param3;
         }
         _loc6_ = Number(-(_loc5_.x - 1000 / 2));
         _loc4_ = Number(-(_loc5_.y - 600 / 2) + 50);
         if(_loc6_ > 0)
         {
            _loc6_ = 0;
         }
         if(_loc6_ < 1000 - MAP_SIZE[0])
         {
            _loc6_ = Number(1000 - MAP_SIZE[0]);
         }
         if(_loc4_ > 0)
         {
            _loc4_ = 0;
         }
         if(_loc4_ < 600 - MAP_SIZE[1])
         {
            _loc4_ = Number(600 - MAP_SIZE[1]);
         }
         x = _loc6_;
         y = _loc4_;
      }
      
      private function enterFrameHander(param1:Event) : void
      {
         roleDeepthSort();
         if(_mainRole)
         {
            setCenter(null,false,_mainRole.playerPoint);
            checkRoleList();
         }
      }
      
      public function checkPonitDistance(param1:Point, param2:Function, param3:int = 0, param4:int = 0) : void
      {
         var _loc7_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         if(_mainRole)
         {
            _loc7_ = new Point(_mainRole.x,_mainRole.y);
            _loc6_ = Math.abs(Point.distance(_loc7_,param1));
            if(_loc6_ > 100)
            {
               _loc5_ = getDesPoint(_loc7_,param1,_loc6_);
               _mouseMovie.x = _loc5_.x;
               _mouseMovie.y = _loc5_.y;
               _mouseMovie.play();
               SocketManager.Instance.out.CampbattleRoleMove(_mainRole.playerInfo.zoneID,_mainRole.playerInfo.ID,_loc5_);
               _mainRole.walk(_loc5_,param2,param3,param4);
            }
            else if(param3 != 0 && param4 != 0)
            {
               param2(param4,param3);
            }
            else if(param3 != 0)
            {
               param2(param3);
            }
            else
            {
               param2();
            }
         }
      }
      
      private function getDesPoint(param1:Point, param2:Point, param3:int) : Point
      {
         var _loc6_:int = param1.x - param2.x < 0?-1:1;
         var _loc5_:int = param1.y - param2.y < 0?-1:1;
         var _loc4_:Point = new Point(Math.abs(100 * (param1.x - param2.x) / param3) * _loc6_ + param2.x,Math.abs(100 * (param1.y - param2.y) / param3) * _loc5_ + param2.y);
         return _loc4_;
      }
      
      private function roleDeepthSort() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_antoObjList.length > 1)
         {
            _loc1_ = _antoObjList.length;
            _antoObjList.sortOn("y",16);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _articleLayer.addChild(_antoObjList[_loc2_]);
               _loc2_++;
            }
         }
      }
      
      protected function __onAddPlayer(param1:DictionaryEvent) : void
      {
         addRoleToMap(param1.data as RoleData);
      }
      
      private function addRoleToMap(param1:RoleData) : void
      {
         var _loc2_:* = null;
         if(!param1)
         {
            return;
         }
         if(param1.zoneID == PlayerManager.Instance.Self.ZoneID && param1.ID == PlayerManager.Instance.Self.ID)
         {
            _loc2_ = creatRole(param1,roleCallback);
            var _loc3_:Boolean = false;
            _loc2_.mouseEnabled = _loc3_;
            _loc2_.mouseChildren = _loc3_;
         }
         else
         {
            _loc2_ = creatRole(param1,otherRoleCallback);
            _loc2_.mouseEnabled = false;
         }
         if(CampBattleManager.instance.mapID == 0)
         {
            hideRoles(_flagPlayer);
         }
      }
      
      private function creatRole(param1:RoleData, param2:Function) : CampBattlePlayer
      {
         var _loc3_:* = null;
         switch(int(param1.type) - 1)
         {
            case 0:
               _loc3_ = new CampBattlePlayer(param1,param2);
               break;
            case 1:
               _loc3_ = new CampBattleOtherRole(param1,param2);
               break;
            case 2:
               _loc3_ = new CampBattleMonsterRole(param1,param2);
         }
         return _loc3_;
      }
      
      private function playerActionChange(param1:SceneCharacterEvent) : void
      {
         var _loc2_:String = param1.data.toString();
         if(_loc2_ == "naturalStandFront" || _loc2_ == "naturalStandBack")
         {
            if(_mouseMovie)
            {
               _mouseMovie.gotoAndStop(1);
            }
         }
      }
      
      public function setRoleState(param1:int, param2:int, param3:int) : void
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc5_:int = _roleList.length;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = _roleList[_loc6_] as CampBattlePlayer;
            if(_loc4_.playerInfo.zoneID == param1 && _loc4_.playerInfo.ID == param2)
            {
               _loc4_.setStateType(param3);
               break;
            }
            _loc6_++;
         }
         if(CampBattleManager.instance.mapID == 0)
         {
            hideRoles(_flagPlayer);
         }
      }
      
      public function setMonsterState(param1:int, param2:int) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = _monsterList.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = _monsterList[_loc5_] as CampGameSmallEnemy;
            if(_loc3_.info.LivingID == param1)
            {
               _loc3_.setStateType(param2);
               break;
            }
            _loc5_++;
         }
      }
      
      private function deleAntoObjList(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = _antoObjList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(param1 is CampBattlePlayer)
            {
               if(_antoObjList[_loc3_] is CampBattlePlayer)
               {
                  if(CampBattlePlayer(param1).playerInfo.zoneID == CampBattlePlayer(_antoObjList[_loc3_]).playerInfo.zoneID && CampBattlePlayer(param1).playerInfo.ID == CampBattlePlayer(_antoObjList[_loc3_]).playerInfo.ID)
                  {
                     _antoObjList.splice(_loc3_,1);
                     return;
                  }
               }
            }
            else if(param1 is CampGameSmallEnemy)
            {
               if(_antoObjList[_loc3_] is CampGameSmallEnemy)
               {
                  if(CampGameSmallEnemy(param1).LivingID == CampGameSmallEnemy(_antoObjList[_loc3_]).LivingID && CampGameSmallEnemy(param1).LivingID == CampGameSmallEnemy(_antoObjList[_loc3_]).LivingID)
                  {
                     _antoObjList.splice(_loc3_,1);
                     return;
                  }
               }
            }
            _loc3_++;
         }
      }
      
      private function roleCallback(param1:CampBattlePlayer, param2:Boolean, param3:int = 1) : void
      {
         if(param3 == 0)
         {
            if(param1)
            {
               _mainRole = param1;
               _mainRole.sceneCharacterStateType = "natural";
               _mainRole.update();
               _mainRole.scene = _sceneScene;
               _mainRole.addEventListener("characterActionChange",playerActionChange);
               try
               {
                  _articleLayer.addChild(_mainRole);
                  _roleList.push(_mainRole);
                  _antoObjList.push(param1);
                  setCenter(null,false,_mainRole.playerPoint);
                  return;
               }
               catch(error:Error)
               {
                  trace(error.message);
                  return;
               }
            }
         }
      }
      
      private function otherRoleCallback(param1:CampBattlePlayer, param2:Boolean, param3:int = 1) : void
      {
         if(!param1)
         {
            return;
         }
         if(param3 != 0)
         {
            return;
         }
         param1.sceneCharacterStateType = "natural";
         param1.update();
         param1.scene = _sceneScene;
         var _loc4_:Boolean = false;
         param1.mouseChildren = _loc4_;
         param1.mouseEnabled = _loc4_;
         if(param1.playerInfo.team != CampBattleControl.instance.model.myTeam)
         {
            param1.mouseChildren = true;
         }
         _articleLayer.addChild(param1);
         _roleList.push(param1);
         _antoObjList.push(param1);
      }
      
      public function hideRoles(param1:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         _flagPlayer = param1;
         var _loc3_:int = _roleList.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _roleList[_loc4_] as CampBattlePlayer;
            if(_loc2_.playerInfo.ID != PlayerManager.Instance.Self.ID)
            {
               _loc2_.IsShowPlayer(_flagPlayer);
            }
            _loc4_++;
         }
      }
      
      protected function __onUpdatePlayerStatus(param1:DictionaryEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:String = (param1.data as RoleData).zoneID + "_" + (param1.data as RoleData).ID;
         if(_playerModel[_loc3_])
         {
            _loc2_ = _playerModel[_loc3_] as RoleData;
         }
         if(CampBattleManager.instance.mapID == 0)
         {
            hideRoles(_flagPlayer);
         }
      }
      
      public function getCurrRole(param1:int, param2:int) : CampBattlePlayer
      {
         var _loc4_:String = param1 + "_" + param2;
         var _loc3_:int = getRoleIndex(_loc4_);
         return CampBattlePlayer(_roleList[_loc3_]);
      }
      
      public function getMainRole() : CampBattlePlayer
      {
         return _mainRole;
      }
      
      protected function __onRemovePlayer(param1:DictionaryEvent) : void
      {
         var _loc4_:String = (param1.data as RoleData).zoneID + "_" + (param1.data as RoleData).ID;
         var _loc2_:int = getRoleIndex(_loc4_);
         var _loc3_:CampBattlePlayer = _roleList[_loc2_] as CampBattlePlayer;
         _roleList.splice(_loc2_,1);
         deleAntoObjList(_loc3_);
         if(_loc3_ == _targetRole)
         {
            _targetRole = null;
         }
         if(_loc3_)
         {
            if(_loc3_.parent)
            {
               _loc3_.parent.removeChild(_loc3_);
            }
            _loc3_.dispose();
         }
         _loc3_ = null;
      }
      
      public function roleMoves(param1:int, param2:int, param3:Point) : void
      {
         var _loc5_:* = null;
         if(!_roleList)
         {
            return;
         }
         var _loc6_:String = param1 + "_" + param2;
         var _loc4_:int = getRoleIndex(_loc6_);
         if(_roleList[_loc4_])
         {
            _loc5_ = _roleList[_loc4_] as CampBattlePlayer;
            _loc5_.walk(param3);
         }
      }
      
      private function getRoleIndex(param1:String) : int
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = _roleList.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _roleList[_loc4_] as CampBattlePlayer;
            if(param1 == _loc2_.playerInfo.zoneID + "_" + _loc2_.playerInfo.ID)
            {
               return _loc4_;
            }
            _loc4_++;
         }
         return 0;
      }
      
      private function initMap() : void
      {
         var _loc4_:MovieClip = new (ClassUtils.uiSourceDomain.getDefinition(_mapClassDefinition) as Class)() as MovieClip;
         var _loc1_:Sprite = _loc4_.getChildByName("articleLayer") as Sprite;
         var _loc6_:Sprite = _loc4_.getChildByName("mesh") as Sprite;
         var _loc3_:Sprite = _loc4_.getChildByName("bg") as Sprite;
         var _loc5_:Sprite = _loc4_.getChildByName("bgSize") as Sprite;
         var _loc2_:Sprite = _loc4_.getChildByName("decoration") as Sprite;
         _bgLayer = _loc3_ == null?new Sprite():_loc3_;
         _articleLayer = _loc1_ == null?new Sprite():_loc1_;
         _decorationLayer = _loc2_ == null?new Sprite():_loc2_;
         var _loc7_:Boolean = false;
         this._decorationLayer.mouseEnabled = _loc7_;
         _decorationLayer.mouseChildren = _loc7_;
         _meshLayer = _loc6_ == null?new Sprite():_loc6_;
         _meshLayer.alpha = 0;
         _meshLayer.mouseChildren = false;
         _meshLayer.mouseEnabled = false;
         MAP_SIZE = [_loc3_.width,_loc3_.height];
         addChild(_bgLayer);
         addChild(_articleLayer);
         addChild(_decorationLayer);
         addChild(_meshLayer);
         initBtnList();
         initMouseMovie();
         if(_smallMap)
         {
            removeChild(_smallMap);
            _smallMap.bitmapData.dispose();
            _smallMap = null;
         }
      }
      
      private function initBtnList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = _actItemList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _articleLayer.addChild(_actItemList[_loc2_]);
            _loc2_++;
         }
      }
      
      private function clearBtnList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = _actItemList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            ObjectUtils.disposeObject(_actItemList[_loc2_]);
            _actItemList[_loc2_] = null;
            _loc2_++;
         }
      }
      
      protected function initSceneScene() : void
      {
         _sceneScene = new SceneScene();
         _sceneScene.setHitTester(new PathMapHitTester(_meshLayer));
      }
      
      private function clearRoleList() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:int = _roleList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _roleList[_loc3_];
            _loc1_.dispose();
            _loc1_ = null;
            _loc3_++;
         }
         _roleList = [];
      }
      
      private function clearMonstList() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:int = _monsterList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _monsterList[_loc3_];
            _loc1_.dispose();
            _loc1_ = null;
            _loc3_++;
         }
         _monsterList.length = 0;
      }
      
      private function clearAntoObjList() : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc3_:int = _antoObjList.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_antoObjList[_loc4_] is CampGameSmallEnemy)
            {
               _loc2_ = _antoObjList[_loc4_] as CampGameSmallEnemy;
               _loc2_.dispose();
               _loc2_ = null;
            }
            else if(_antoObjList[_loc4_] is CampBattlePlayer)
            {
               _loc1_ = _antoObjList[_loc4_] as CampBattlePlayer;
               _loc1_.dispose();
               _loc1_ = null;
            }
            _loc4_++;
         }
         _antoObjList.length = 0;
      }
      
      public function dispose() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(_smallMap)
         {
            removeChild(_smallMap);
            _smallMap.bitmapData.dispose();
            _smallMap = null;
         }
         if(_addMonsterTimer)
         {
            _addMonsterTimer.stop();
            _addMonsterTimer.removeEventListener("timer",__onMonsterTimerHander);
            _addMonsterTimer.removeEventListener("timerComplete",__onMonsterTimerCompleteHander);
            TimerManager.getInstance().removeJugglerByTimer(_addMonsterTimer);
            _addMonsterTimer = null;
         }
         removeEvent();
         clearRoleList();
         clearMonstList();
         clearBtnList();
         clearAntoObjList();
         while(_articleLayer.numChildren)
         {
            ObjectUtils.disposeObject(_articleLayer.getChildAt(0));
         }
         while(_bgLayer.numChildren)
         {
            if(_bgLayer.getChildAt(0) is DisplayObject)
            {
               _loc2_ = _bgLayer.getChildAt(0) as DisplayObject;
               _bgLayer.removeChild(_loc2_);
               _loc2_ = null;
            }
            else
            {
               ObjectUtils.disposeObject(_bgLayer.getChildAt(0));
            }
         }
         while(_meshLayer.numChildren)
         {
            ObjectUtils.disposeObject(_meshLayer.getChildAt(0));
         }
         while(_decorationLayer.numChildren)
         {
            if(_decorationLayer.getChildAt(0) is MovieClip)
            {
               _loc1_ = _decorationLayer.getChildAt(0) as MovieClip;
               _loc1_.stop();
               while(_loc1_.numChildren)
               {
                  ObjectUtils.disposeObject(_loc1_.getChildAt(0));
               }
               ObjectUtils.disposeObject(_loc1_);
               _loc1_ = null;
            }
            else
            {
               ObjectUtils.disposeObject(_decorationLayer.getChildAt(0));
            }
         }
         ObjectUtils.disposeObject(_mainRole);
         ObjectUtils.disposeObject(_mouseMovie);
         ObjectUtils.disposeObject(_bgLayer);
         ObjectUtils.disposeObject(_articleLayer);
         ObjectUtils.disposeObject(_decorationLayer);
         ObjectUtils.disposeObject(_meshLayer);
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         _monsterModel = null;
         _bgLayer = null;
         _articleLayer = null;
         _decorationLayer = null;
         _meshLayer = null;
         _roleList = null;
         _monsterList = null;
         _targetRole = null;
         _playerModel = null;
         _antoObjList = null;
         _mouseMovie = null;
         _mainRole = null;
      }
      
      public function get playerModel() : DictionaryData
      {
         return _playerModel;
      }
   }
}
