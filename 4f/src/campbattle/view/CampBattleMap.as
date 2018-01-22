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
      
      public function CampBattleMap(param1:String, param2:String, param3:DictionaryData = null, param4:DictionaryData = null, param5:Array = null, param6:Bitmap = null){super();}
      
      private function loaderMap(param1:String) : void{}
      
      protected function onMapLoadError(param1:LoaderEvent) : void{}
      
      private function onMapLoadComplete(param1:LoaderEvent) : void{}
      
      private function initPlayerList() : void{}
      
      private function initMonstersList() : void{}
      
      private function __onMonsterTimerHander(param1:Event) : void{}
      
      private function __onMonsterTimerCompleteHander(param1:Event) : void{}
      
      private function checkRoleList() : void{}
      
      protected function initEvent() : void{}
      
      protected function __onSetSelfPlayerPos(param1:NewHallEvent) : void{}
      
      protected function __onAddMonsters(param1:DictionaryEvent) : void{}
      
      private function __onRemoveMonsters(param1:DictionaryEvent) : void{}
      
      public function getMonsterIndex(param1:int) : int{return 0;}
      
      private function __onPlayerClickHander(param1:MouseEvent) : void{}
      
      protected function initMouseMovie() : void{}
      
      private function removeEvent() : void{}
      
      public function setCenter(param1:SceneCharacterEvent = null, param2:Boolean = true, param3:Point = null) : void{}
      
      private function enterFrameHander(param1:Event) : void{}
      
      public function checkPonitDistance(param1:Point, param2:Function, param3:int = 0, param4:int = 0) : void{}
      
      private function getDesPoint(param1:Point, param2:Point, param3:int) : Point{return null;}
      
      private function roleDeepthSort() : void{}
      
      protected function __onAddPlayer(param1:DictionaryEvent) : void{}
      
      private function addRoleToMap(param1:RoleData) : void{}
      
      private function creatRole(param1:RoleData, param2:Function) : CampBattlePlayer{return null;}
      
      private function playerActionChange(param1:SceneCharacterEvent) : void{}
      
      public function setRoleState(param1:int, param2:int, param3:int) : void{}
      
      public function setMonsterState(param1:int, param2:int) : void{}
      
      private function deleAntoObjList(param1:Object) : void{}
      
      private function roleCallback(param1:CampBattlePlayer, param2:Boolean, param3:int = 1) : void{}
      
      private function otherRoleCallback(param1:CampBattlePlayer, param2:Boolean, param3:int = 1) : void{}
      
      public function hideRoles(param1:Boolean) : void{}
      
      protected function __onUpdatePlayerStatus(param1:DictionaryEvent) : void{}
      
      public function getCurrRole(param1:int, param2:int) : CampBattlePlayer{return null;}
      
      public function getMainRole() : CampBattlePlayer{return null;}
      
      protected function __onRemovePlayer(param1:DictionaryEvent) : void{}
      
      public function roleMoves(param1:int, param2:int, param3:Point) : void{}
      
      private function getRoleIndex(param1:String) : int{return 0;}
      
      private function initMap() : void{}
      
      private function initBtnList() : void{}
      
      private function clearBtnList() : void{}
      
      protected function initSceneScene() : void{}
      
      private function clearRoleList() : void{}
      
      private function clearMonstList() : void{}
      
      private function clearAntoObjList() : void{}
      
      public function dispose() : void{}
      
      public function get playerModel() : DictionaryData{return null;}
   }
}
