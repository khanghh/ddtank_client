package consortionBattle.view
{
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import consortionBattle.ConsortiaBattleController;
   import consortionBattle.ConsortiaBattleManager;
   import consortionBattle.event.ConsBatEvent;
   import consortionBattle.player.ConsortiaBattlePlayer;
   import consortionBattle.player.ConsortiaBattlePlayerInfo;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import ddt.view.scenePathSearcher.PathMapHitTester;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import hall.event.NewHallEvent;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   
   public class ConsortiaBattleMapView extends Sprite implements Disposeable
   {
      
      public static const MAP_SIZE:Array = [3208,2000];
       
      
      protected var _mapClassDefinition:String;
      
      protected var _playerModel:DictionaryData;
      
      protected var _bgLayer:Sprite;
      
      protected var _articleLayer:Sprite;
      
      protected var _decorationLayer:Sprite;
      
      protected var _meshLayer:Sprite;
      
      protected var _sceneScene:SceneScene;
      
      protected var _selfPlayer:ConsortiaBattlePlayer;
      
      protected var _lastClick:Number = 0;
      
      protected var _clickInterval:Number = 200;
      
      protected var _mouseMovie:MovieClip;
      
      protected var _characters:DictionaryData;
      
      protected var _clickEnemy:ConsortiaBattlePlayer;
      
      protected var _judgeCreateCount:int = 0;
      
      public function ConsortiaBattleMapView(param1:String, param2:DictionaryData){super();}
      
      private function initBeforeTimeView() : void{}
      
      protected function initData() : void{}
      
      protected function initMap() : void{}
      
      protected function initMouseMovie() : void{}
      
      protected function initSceneScene() : void{}
      
      protected function initEvent() : void{}
      
      protected function __onSetSelfPlayerPos(param1:NewHallEvent) : void{}
      
      private function hidePlayer(param1:Event) : void{}
      
      private function playerClickHandler(param1:Event) : void{}
      
      protected function __addPlayer(param1:DictionaryEvent) : void{}
      
      protected function addPlayerCallBack(param1:ConsortiaBattlePlayer, param2:Boolean, param3:int) : void{}
      
      protected function __removePlayer(param1:DictionaryEvent) : void{}
      
      protected function __updatePlayerStatus(param1:DictionaryEvent) : void{}
      
      private function playerActionChange(param1:SceneCharacterEvent) : void{}
      
      public function setCenter(param1:SceneCharacterEvent = null, param2:Boolean = true, param3:Point = null) : void{}
      
      protected function __click(param1:MouseEvent) : void{}
      
      protected function sendMyPosition(param1:Array) : void{}
      
      protected function movePlayer(param1:ConsBatEvent) : void{}
      
      protected function updateMap(param1:Event) : void{}
      
      protected function judgeEnemy() : void{}
      
      protected function BuildEntityDepth() : void{}
      
      protected function getPointDepth(param1:Number, param2:Number) : Number{return 0;}
      
      public function addSelfPlayer() : void{}
      
      protected function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
