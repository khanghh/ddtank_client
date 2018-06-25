package campbattle.view{   import campbattle.CampBattleControl;   import campbattle.CampBattleManager;   import campbattle.data.RoleData;   import campbattle.view.roleView.CampBattleMonsterRole;   import campbattle.view.roleView.CampBattleOtherRole;   import campbattle.view.roleView.CampBattlePlayer;   import campbattle.view.roleView.CampGameSmallEnemy;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.SceneCharacterEvent;   import ddt.manager.ChatManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.utils.PositionUtils;   import ddt.view.scenePathSearcher.PathMapHitTester;   import ddt.view.scenePathSearcher.SceneScene;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.utils.getTimer;   import game.objects.GameLiving;   import gameCommon.model.SmallEnemy;   import hall.event.NewHallEvent;   import road7th.data.DictionaryData;   import road7th.data.DictionaryEvent;   import times.utils.timerManager.TimerJuggler;   import times.utils.timerManager.TimerManager;      public class CampBattleMap extends Sprite   {            public static const GAME_WIDTH:int = 1000;            public static const GAME_HEIGHT:int = 600;            public static var MAP_SIZE:Array = [3208,2000];                   protected var _mapClassDefinition:String;            protected var _playerModel:DictionaryData;            protected var _monsterModel:DictionaryData;            protected var _bgLayer:Sprite;            protected var _articleLayer:Sprite;            protected var _decorationLayer:Sprite;            protected var _meshLayer:Sprite;            protected var _sceneScene:SceneScene;            private var _roleList:Array;            private var _monsterList:Array;            private var _isLoadMapComplete:Boolean;            private var _targetRole:CampBattlePlayer;            private var _mainRole:CampBattlePlayer;            private var _actItemList:Array;            private var _gameLiving:GameLiving;            private var _sendMove:Function;            private var _mouseMovie:MovieClip;            private var _antoObjList:Array;            private var _lastClick:Number = 0;            private var _clickInterval:Number = 200;            private var _addMonsterTimer:TimerJuggler;            private var _mIndex:int;            private var _mapResUrl:String;            private var _smallMap:Bitmap;            private var _flagPlayer:Boolean;            public function CampBattleMap(mapClassDefinition:String, mapResUrl:String, playerModel:DictionaryData = null, monsterModel:DictionaryData = null, actItemList:Array = null, smallMap:Bitmap = null) { super(); }
            private function loaderMap(str:String) : void { }
            protected function onMapLoadError(event:LoaderEvent) : void { }
            private function onMapLoadComplete(event:LoaderEvent) : void { }
            private function initPlayerList() : void { }
            private function initMonstersList() : void { }
            private function __onMonsterTimerHander(e:Event) : void { }
            private function __onMonsterTimerCompleteHander(event:Event) : void { }
            private function checkRoleList() : void { }
            protected function initEvent() : void { }
            protected function __onSetSelfPlayerPos(event:NewHallEvent) : void { }
            protected function __onAddMonsters(event:DictionaryEvent) : void { }
            private function __onRemoveMonsters(event:DictionaryEvent) : void { }
            public function getMonsterIndex(id:int) : int { return 0; }
            private function __onPlayerClickHander(e:MouseEvent) : void { }
            protected function initMouseMovie() : void { }
            private function removeEvent() : void { }
            public function setCenter(event:SceneCharacterEvent = null, isReturn:Boolean = true, pos:Point = null) : void { }
            private function enterFrameHander(e:Event) : void { }
            public function checkPonitDistance(p:Point, fun:Function, id:int = 0, zoneID:int = 0) : void { }
            private function getDesPoint(fp:Point, p:Point, dis:int) : Point { return null; }
            private function roleDeepthSort() : void { }
            protected function __onAddPlayer(event:DictionaryEvent) : void { }
            private function addRoleToMap(data:RoleData) : void { }
            private function creatRole(roleData:RoleData, fun:Function) : CampBattlePlayer { return null; }
            private function playerActionChange(evt:SceneCharacterEvent) : void { }
            public function setRoleState(zoneID:int, userID:int, stateType:int) : void { }
            public function setMonsterState(ID:int, stateType:int) : void { }
            private function deleAntoObjList(obj:Object) : void { }
            private function roleCallback(role:CampBattlePlayer, isLoadSucceed:Boolean, vFlag:int = 1) : void { }
            private function otherRoleCallback(role:CampBattlePlayer, isLoadSucceed:Boolean, vFlag:int = 1) : void { }
            public function hideRoles(bool:Boolean) : void { }
            protected function __onUpdatePlayerStatus(event:DictionaryEvent) : void { }
            public function getCurrRole(zoneID:int, userID:int) : CampBattlePlayer { return null; }
            public function getMainRole() : CampBattlePlayer { return null; }
            protected function __onRemovePlayer(event:DictionaryEvent) : void { }
            public function roleMoves(zoneID:int, userID:int, p:Point) : void { }
            private function getRoleIndex(id:String) : int { return 0; }
            private function initMap() : void { }
            private function initBtnList() : void { }
            private function clearBtnList() : void { }
            protected function initSceneScene() : void { }
            private function clearRoleList() : void { }
            private function clearMonstList() : void { }
            private function clearAntoObjList() : void { }
            public function dispose() : void { }
            public function get playerModel() : DictionaryData { return null; }
   }}