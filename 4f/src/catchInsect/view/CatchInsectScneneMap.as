package catchInsect.view
{
   import catchInsect.CatchInsectControl;
   import catchInsect.CatchInsectManager;
   import catchInsect.CatchInsectMonsterManager;
   import catchInsect.CatchInsectRoomModel;
   import catchInsect.PlayerVO;
   import catchInsect.data.InsectInfo;
   import catchInsect.event.CatchInsectRoomEvent;
   import catchInsect.player.CatchInsectMonster;
   import catchInsect.player.CatchInsectRoomPlayer;
   import church.vo.SceneMapVO;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import hall.event.NewHallEvent;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   
   public class CatchInsectScneneMap extends Sprite implements Disposeable
   {
      
      public static var packsNum:int = 1;
       
      
      protected var articleLayer:Sprite;
      
      protected var meshLayer:Sprite;
      
      protected var bgLayer:Sprite;
      
      protected var skyLayer:Sprite;
      
      protected var snowLayer:Sprite;
      
      public var sceneScene:SceneScene;
      
      protected var _data:DictionaryData;
      
      protected var _characters:DictionaryData;
      
      public var selfPlayer:CatchInsectRoomPlayer;
      
      private var _isUpdateComplete:Boolean;
      
      private var _updateState:int;
      
      private var last_click:Number;
      
      private var current_display_fire:int = 0;
      
      private var _currentLoadingPlayer:CatchInsectRoomPlayer;
      
      private var _isShowName:Boolean = true;
      
      private var _isChatBall:Boolean = true;
      
      private var _clickInterval:Number = 200;
      
      private var _lastClick:Number = 0;
      
      private var _sceneMapVO:SceneMapVO;
      
      private var _model:CatchInsectRoomModel;
      
      private var armyPos:Point;
      
      private var decorationLayer:Sprite;
      
      protected var _mapObjs:DictionaryData;
      
      protected var _monsters:DictionaryData;
      
      private var _mouseMovie:MovieClip;
      
      private var r:int = 250;
      
      private var auto:Point;
      
      private var autoMove:Boolean = false;
      
      private var _entering:Boolean = false;
      
      private var endPoint:Point;
      
      protected var reference:CatchInsectRoomPlayer;
      
      public function CatchInsectScneneMap(param1:CatchInsectRoomModel, param2:SceneScene, param3:DictionaryData, param4:DictionaryData, param5:Sprite, param6:Sprite, param7:Sprite = null, param8:Sprite = null, param9:Sprite = null, param10:Sprite = null){super();}
      
      private function checkDistance() : Boolean{return false;}
      
      public function set enterIng(param1:Boolean) : void{}
      
      public function get sceneMapVO() : SceneMapVO{return null;}
      
      public function set sceneMapVO(param1:SceneMapVO) : void{}
      
      protected function init() : void{}
      
      protected function addEvent() : void{}
      
      protected function __onSetSelfPlayerPos(param1:NewHallEvent) : void{}
      
      private function __addMonster(param1:DictionaryEvent) : void{}
      
      private function __removeMonster(param1:DictionaryEvent) : void{}
      
      private function __onMonsterUpdate(param1:DictionaryEvent) : void{}
      
      private function menuChange(param1:CatchInsectRoomEvent) : void{}
      
      public function nameVisible() : void{}
      
      protected function updateMap(param1:Event) : void{}
      
      protected function __click(param1:MouseEvent) : void{}
      
      public function sendMyPosition(param1:Array) : void{}
      
      public function movePlayer(param1:int, param2:Array) : void{}
      
      public function updatePlayersStauts(param1:int, param2:int, param3:Point) : void{}
      
      public function __otherPlayrStartFight(param1:CatchInsectRoomEvent) : void{}
      
      public function updateSelfStatus(param1:int) : void{}
      
      public function checkSelfStatus() : int{return 0;}
      
      public function setCenter(param1:SceneCharacterEvent = null) : void{}
      
      public function addSelfPlayer() : void{}
      
      protected function ajustScreen(param1:CatchInsectRoomPlayer) : void{}
      
      protected function __addPlayer(param1:DictionaryEvent) : void{}
      
      private function addPlayerCallBack(param1:CatchInsectRoomPlayer, param2:Boolean, param3:int) : void{}
      
      private function playerActionChange(param1:SceneCharacterEvent) : void{}
      
      private function __walkEndHandler(param1:SceneCharacterEvent) : void{}
      
      protected function __removePlayer(param1:DictionaryEvent) : void{}
      
      protected function BuildEntityDepth() : void{}
      
      protected function getPointDepth(param1:Number, param2:Number) : Number{return 0;}
      
      protected function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
