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
      
      public function CampBattleMap(mapClassDefinition:String, mapResUrl:String, playerModel:DictionaryData = null, monsterModel:DictionaryData = null, actItemList:Array = null, smallMap:Bitmap = null)
      {
         super();
         _actItemList = actItemList;
         _mapClassDefinition = mapClassDefinition;
         _playerModel = new DictionaryData();
         _playerModel.setData(playerModel);
         _monsterModel = monsterModel;
         _roleList = [];
         _monsterList = [];
         _antoObjList = [];
         _mapResUrl = mapResUrl;
         _smallMap = smallMap;
         if(_smallMap)
         {
            addChild(_smallMap);
         }
         loaderMap(mapResUrl);
      }
      
      private function loaderMap(str:String) : void
      {
         var mapLoader:BaseLoader = LoadResourceManager.Instance.createLoader(str,4);
         mapLoader.addEventListener("complete",onMapLoadComplete);
         mapLoader.addEventListener("loadError",onMapLoadError);
         LoadResourceManager.Instance.startLoad(mapLoader);
      }
      
      protected function onMapLoadError(event:LoaderEvent) : void
      {
         ChatManager.Instance.sysChatRed("地图资源加载出错Url=" + _mapResUrl);
      }
      
      private function onMapLoadComplete(event:LoaderEvent) : void
      {
         event.loader.removeEventListener("complete",onMapLoadComplete);
         _isLoadMapComplete = true;
         initMap();
         initEvent();
         initSceneScene();
         initPlayerList();
         initMonstersList();
      }
      
      private function initPlayerList() : void
      {
         var i:int = 0;
         for(i = 0; i < _playerModel.length; )
         {
            addRoleToMap(_playerModel.list[i]);
            i++;
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
      
      private function __onMonsterTimerHander(e:Event) : void
      {
         var sEnemy:* = null;
         var eData:SmallEnemy = _monsterModel.list[_mIndex] as SmallEnemy;
         if(eData != null)
         {
            sEnemy = new CampGameSmallEnemy(eData);
            PositionUtils.setPos(sEnemy,eData.pos);
            _monsterList.push(sEnemy);
            _antoObjList.push(sEnemy);
            _articleLayer.addChild(sEnemy);
            _mIndex = Number(_mIndex) + 1;
         }
      }
      
      private function __onMonsterTimerCompleteHander(event:Event) : void
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
         var i:int = 0;
         var role:* = null;
         var disX:int = 0;
         var disY:int = 0;
         if(_roleList.length != _playerModel.length)
         {
            return;
         }
         var len:int = _roleList.length;
         for(i = 0; i < len; )
         {
            role = _roleList[i] as CampBattlePlayer;
            if(!(role.playerInfo.zoneID == PlayerManager.Instance.Self.ZoneID && role.playerInfo.ID == PlayerManager.Instance.Self.ID))
            {
               disX = Math.abs(_mainRole.x - role.x);
               disY = Math.abs(_mainRole.y - role.y);
               role.visible = disX > 500 || disY > 300?false:true;
            }
            i++;
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
      
      protected function __onSetSelfPlayerPos(event:NewHallEvent) : void
      {
         __onPlayerClickHander(event.data[0]);
      }
      
      protected function __onAddMonsters(event:DictionaryEvent) : void
      {
         var enemy:CampGameSmallEnemy = new CampGameSmallEnemy(event.data as SmallEnemy);
         enemy.setStateType((event.data as SmallEnemy).stateType);
         _monsterList.push(enemy);
         _articleLayer.addChild(enemy);
         _antoObjList.push(enemy);
      }
      
      private function __onRemoveMonsters(event:DictionaryEvent) : void
      {
         var id:int = (event.data as SmallEnemy).LivingID;
         var index:int = getMonsterIndex(id);
         if(!_monsterList[index])
         {
            return;
         }
         var enemy:CampGameSmallEnemy = _monsterList[index] as CampGameSmallEnemy;
         _monsterList.splice(index,1);
         deleAntoObjList(enemy);
         enemy.dispose();
         enemy.dispose();
         enemy = null;
      }
      
      public function getMonsterIndex(id:int) : int
      {
         var i:int = 0;
         var len:int = _monsterList.length;
         for(i = 0; i < len; )
         {
            if(id == CampGameSmallEnemy(_monsterList[i]).info.LivingID)
            {
               return i;
            }
            i++;
         }
         return 0;
      }
      
      private function __onPlayerClickHander(e:MouseEvent) : void
      {
         if(!_mainRole || _mainRole.playerInfo.stateType == 4)
         {
            return;
         }
         _targetRole = null;
         var targetPoint:Point = new Point(mouseX,mouseY);
         if(getTimer() - _lastClick > _clickInterval)
         {
            _lastClick = getTimer();
            if(!_sceneScene.hit(targetPoint))
            {
               _mainRole.walk(targetPoint);
               _mouseMovie.x = targetPoint.x;
               _mouseMovie.y = targetPoint.y;
               _mouseMovie.play();
               SocketManager.Instance.out.CampbattleRoleMove(_mainRole.playerInfo.zoneID,_mainRole.playerInfo.ID,targetPoint);
            }
         }
      }
      
      protected function initMouseMovie() : void
      {
         var mvClass:Class = ClassUtils.uiSourceDomain.getDefinition("asset.campBattle.MouseClickMovie") as Class;
         _mouseMovie = new mvClass() as MovieClip;
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
      
      public function setCenter(event:SceneCharacterEvent = null, isReturn:Boolean = true, pos:Point = null) : void
      {
         var xf:* = NaN;
         var yf:* = NaN;
         var tmpPos:* = null;
         if(_mainRole)
         {
            tmpPos = _mainRole.playerPoint;
         }
         else
         {
            tmpPos = pos;
         }
         xf = Number(-(tmpPos.x - 1000 / 2));
         yf = Number(-(tmpPos.y - 600 / 2) + 50);
         if(xf > 0)
         {
            xf = 0;
         }
         if(xf < 1000 - MAP_SIZE[0])
         {
            xf = Number(1000 - MAP_SIZE[0]);
         }
         if(yf > 0)
         {
            yf = 0;
         }
         if(yf < 600 - MAP_SIZE[1])
         {
            yf = Number(600 - MAP_SIZE[1]);
         }
         x = xf;
         y = yf;
      }
      
      private function enterFrameHander(e:Event) : void
      {
         roleDeepthSort();
         if(_mainRole)
         {
            setCenter(null,false,_mainRole.playerPoint);
            checkRoleList();
         }
      }
      
      public function checkPonitDistance(p:Point, fun:Function, id:int = 0, zoneID:int = 0) : void
      {
         var fp:* = null;
         var dis:int = 0;
         var desPoint:* = null;
         if(_mainRole)
         {
            fp = new Point(_mainRole.x,_mainRole.y);
            dis = Math.abs(Point.distance(fp,p));
            if(dis > 100)
            {
               desPoint = getDesPoint(fp,p,dis);
               _mouseMovie.x = desPoint.x;
               _mouseMovie.y = desPoint.y;
               _mouseMovie.play();
               SocketManager.Instance.out.CampbattleRoleMove(_mainRole.playerInfo.zoneID,_mainRole.playerInfo.ID,desPoint);
               _mainRole.walk(desPoint,fun,id,zoneID);
            }
            else if(id != 0 && zoneID != 0)
            {
               fun(zoneID,id);
            }
            else if(id != 0)
            {
               fun(id);
            }
            else
            {
               fun();
            }
         }
      }
      
      private function getDesPoint(fp:Point, p:Point, dis:int) : Point
      {
         var xOff:int = fp.x - p.x < 0?-1:1;
         var yOff:int = fp.y - p.y < 0?-1:1;
         var desPoint:Point = new Point(Math.abs(100 * (fp.x - p.x) / dis) * xOff + p.x,Math.abs(100 * (fp.y - p.y) / dis) * yOff + p.y);
         return desPoint;
      }
      
      private function roleDeepthSort() : void
      {
         var len:int = 0;
         var i:int = 0;
         if(_antoObjList.length > 1)
         {
            len = _antoObjList.length;
            _antoObjList.sortOn("y",16);
            for(i = 0; i < len; )
            {
               _articleLayer.addChild(_antoObjList[i]);
               i++;
            }
         }
      }
      
      protected function __onAddPlayer(event:DictionaryEvent) : void
      {
         addRoleToMap(event.data as RoleData);
      }
      
      private function addRoleToMap(data:RoleData) : void
      {
         var role:* = null;
         if(!data)
         {
            return;
         }
         if(data.zoneID == PlayerManager.Instance.Self.ZoneID && data.ID == PlayerManager.Instance.Self.ID)
         {
            role = creatRole(data,roleCallback);
            var _loc3_:Boolean = false;
            role.mouseEnabled = _loc3_;
            role.mouseChildren = _loc3_;
         }
         else
         {
            role = creatRole(data,otherRoleCallback);
            role.mouseEnabled = false;
         }
         if(CampBattleManager.instance.mapID == 0)
         {
            hideRoles(_flagPlayer);
         }
      }
      
      private function creatRole(roleData:RoleData, fun:Function) : CampBattlePlayer
      {
         var role:* = null;
         switch(int(roleData.type) - 1)
         {
            case 0:
               role = new CampBattlePlayer(roleData,fun);
               break;
            case 1:
               role = new CampBattleOtherRole(roleData,fun);
               break;
            case 2:
               role = new CampBattleMonsterRole(roleData,fun);
         }
         return role;
      }
      
      private function playerActionChange(evt:SceneCharacterEvent) : void
      {
         var type:String = evt.data.toString();
         if(type == "naturalStandFront" || type == "naturalStandBack")
         {
            if(_mouseMovie)
            {
               _mouseMovie.gotoAndStop(1);
            }
         }
      }
      
      public function setRoleState(zoneID:int, userID:int, stateType:int) : void
      {
         var i:int = 0;
         var role:* = null;
         var len:int = _roleList.length;
         for(i = 0; i < len; )
         {
            role = _roleList[i] as CampBattlePlayer;
            if(role.playerInfo.zoneID == zoneID && role.playerInfo.ID == userID)
            {
               role.setStateType(stateType);
               break;
            }
            i++;
         }
         if(CampBattleManager.instance.mapID == 0)
         {
            hideRoles(_flagPlayer);
         }
      }
      
      public function setMonsterState(ID:int, stateType:int) : void
      {
         var i:int = 0;
         var enemy:* = null;
         var len:int = _monsterList.length;
         for(i = 0; i < len; )
         {
            enemy = _monsterList[i] as CampGameSmallEnemy;
            if(enemy.info.LivingID == ID)
            {
               enemy.setStateType(stateType);
               break;
            }
            i++;
         }
      }
      
      private function deleAntoObjList(obj:Object) : void
      {
         var i:int = 0;
         var len:int = _antoObjList.length;
         for(i = 0; i < len; )
         {
            if(obj is CampBattlePlayer)
            {
               if(_antoObjList[i] is CampBattlePlayer)
               {
                  if(CampBattlePlayer(obj).playerInfo.zoneID == CampBattlePlayer(_antoObjList[i]).playerInfo.zoneID && CampBattlePlayer(obj).playerInfo.ID == CampBattlePlayer(_antoObjList[i]).playerInfo.ID)
                  {
                     _antoObjList.splice(i,1);
                     return;
                  }
               }
            }
            else if(obj is CampGameSmallEnemy)
            {
               if(_antoObjList[i] is CampGameSmallEnemy)
               {
                  if(CampGameSmallEnemy(obj).LivingID == CampGameSmallEnemy(_antoObjList[i]).LivingID && CampGameSmallEnemy(obj).LivingID == CampGameSmallEnemy(_antoObjList[i]).LivingID)
                  {
                     _antoObjList.splice(i,1);
                     return;
                  }
               }
            }
            i++;
         }
      }
      
      private function roleCallback(role:CampBattlePlayer, isLoadSucceed:Boolean, vFlag:int = 1) : void
      {
         if(vFlag == 0)
         {
            if(role)
            {
               _mainRole = role;
               _mainRole.sceneCharacterStateType = "natural";
               _mainRole.update();
               _mainRole.scene = _sceneScene;
               _mainRole.addEventListener("characterActionChange",playerActionChange);
               try
               {
                  _articleLayer.addChild(_mainRole);
                  _roleList.push(_mainRole);
                  _antoObjList.push(role);
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
      
      private function otherRoleCallback(role:CampBattlePlayer, isLoadSucceed:Boolean, vFlag:int = 1) : void
      {
         if(!role)
         {
            return;
         }
         if(vFlag != 0)
         {
            return;
         }
         role.sceneCharacterStateType = "natural";
         role.update();
         role.scene = _sceneScene;
         var _loc4_:Boolean = false;
         role.mouseChildren = _loc4_;
         role.mouseEnabled = _loc4_;
         if(role.playerInfo.team != CampBattleControl.instance.model.myTeam)
         {
            role.mouseChildren = true;
         }
         _articleLayer.addChild(role);
         _roleList.push(role);
         _antoObjList.push(role);
      }
      
      public function hideRoles(bool:Boolean) : void
      {
         var i:int = 0;
         var role:* = null;
         _flagPlayer = bool;
         var len:int = _roleList.length;
         for(i = 0; i < len; )
         {
            role = _roleList[i] as CampBattlePlayer;
            if(role.playerInfo.ID != PlayerManager.Instance.Self.ID)
            {
               role.IsShowPlayer(_flagPlayer);
            }
            i++;
         }
      }
      
      protected function __onUpdatePlayerStatus(event:DictionaryEvent) : void
      {
         var player:* = null;
         var key:String = (event.data as RoleData).zoneID + "_" + (event.data as RoleData).ID;
         if(_playerModel[key])
         {
            player = _playerModel[key] as RoleData;
         }
         if(CampBattleManager.instance.mapID == 0)
         {
            hideRoles(_flagPlayer);
         }
      }
      
      public function getCurrRole(zoneID:int, userID:int) : CampBattlePlayer
      {
         var key:String = zoneID + "_" + userID;
         var index:int = getRoleIndex(key);
         return CampBattlePlayer(_roleList[index]);
      }
      
      public function getMainRole() : CampBattlePlayer
      {
         return _mainRole;
      }
      
      protected function __onRemovePlayer(event:DictionaryEvent) : void
      {
         var key:String = (event.data as RoleData).zoneID + "_" + (event.data as RoleData).ID;
         var index:int = getRoleIndex(key);
         var player:CampBattlePlayer = _roleList[index] as CampBattlePlayer;
         _roleList.splice(index,1);
         deleAntoObjList(player);
         if(player == _targetRole)
         {
            _targetRole = null;
         }
         if(player)
         {
            if(player.parent)
            {
               player.parent.removeChild(player);
            }
            player.dispose();
         }
         player = null;
      }
      
      public function roleMoves(zoneID:int, userID:int, p:Point) : void
      {
         var role:* = null;
         if(!_roleList)
         {
            return;
         }
         var key:String = zoneID + "_" + userID;
         var index:int = getRoleIndex(key);
         if(_roleList[index])
         {
            role = _roleList[index] as CampBattlePlayer;
            role.walk(p);
         }
      }
      
      private function getRoleIndex(id:String) : int
      {
         var i:int = 0;
         var role:* = null;
         var len:int = _roleList.length;
         for(i = 0; i < len; )
         {
            role = _roleList[i] as CampBattlePlayer;
            if(id == role.playerInfo.zoneID + "_" + role.playerInfo.ID)
            {
               return i;
            }
            i++;
         }
         return 0;
      }
      
      private function initMap() : void
      {
         var mapRes:MovieClip = new (ClassUtils.uiSourceDomain.getDefinition(_mapClassDefinition) as Class)() as MovieClip;
         var acticle:Sprite = mapRes.getChildByName("articleLayer") as Sprite;
         var mesh:Sprite = mapRes.getChildByName("mesh") as Sprite;
         var bg:Sprite = mapRes.getChildByName("bg") as Sprite;
         var bgSize:Sprite = mapRes.getChildByName("bgSize") as Sprite;
         var decoration:Sprite = mapRes.getChildByName("decoration") as Sprite;
         _bgLayer = bg == null?new Sprite():bg;
         _articleLayer = acticle == null?new Sprite():acticle;
         _decorationLayer = decoration == null?new Sprite():decoration;
         var _loc7_:Boolean = false;
         this._decorationLayer.mouseEnabled = _loc7_;
         _decorationLayer.mouseChildren = _loc7_;
         _meshLayer = mesh == null?new Sprite():mesh;
         _meshLayer.alpha = 0;
         _meshLayer.mouseChildren = false;
         _meshLayer.mouseEnabled = false;
         MAP_SIZE = [bg.width,bg.height];
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
         var i:int = 0;
         var len:int = _actItemList.length;
         for(i = 0; i < len; )
         {
            _articleLayer.addChild(_actItemList[i]);
            i++;
         }
      }
      
      private function clearBtnList() : void
      {
         var i:int = 0;
         var len:int = _actItemList.length;
         for(i = 0; i < len; )
         {
            ObjectUtils.disposeObject(_actItemList[i]);
            _actItemList[i] = null;
            i++;
         }
      }
      
      protected function initSceneScene() : void
      {
         _sceneScene = new SceneScene();
         _sceneScene.setHitTester(new PathMapHitTester(_meshLayer));
      }
      
      private function clearRoleList() : void
      {
         var i:int = 0;
         var role:* = null;
         var len:int = _roleList.length;
         for(i = 0; i < len; )
         {
            role = _roleList[i];
            role.dispose();
            role = null;
            i++;
         }
         _roleList = [];
      }
      
      private function clearMonstList() : void
      {
         var i:int = 0;
         var em:* = null;
         var len:int = _monsterList.length;
         for(i = 0; i < len; )
         {
            em = _monsterList[i];
            em.dispose();
            em = null;
            i++;
         }
         _monsterList.length = 0;
      }
      
      private function clearAntoObjList() : void
      {
         var i:int = 0;
         var em:* = null;
         var role:* = null;
         var len:int = _antoObjList.length;
         for(i = 0; i < len; )
         {
            if(_antoObjList[i] is CampGameSmallEnemy)
            {
               em = _antoObjList[i] as CampGameSmallEnemy;
               em.dispose();
               em = null;
            }
            else if(_antoObjList[i] is CampBattlePlayer)
            {
               role = _antoObjList[i] as CampBattlePlayer;
               role.dispose();
               role = null;
            }
            i++;
         }
         _antoObjList.length = 0;
      }
      
      public function dispose() : void
      {
         var disp:* = null;
         var mc:* = null;
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
               disp = _bgLayer.getChildAt(0) as DisplayObject;
               _bgLayer.removeChild(disp);
               disp = null;
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
               mc = _decorationLayer.getChildAt(0) as MovieClip;
               mc.stop();
               while(mc.numChildren)
               {
                  ObjectUtils.disposeObject(mc.getChildAt(0));
               }
               ObjectUtils.disposeObject(mc);
               mc = null;
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
