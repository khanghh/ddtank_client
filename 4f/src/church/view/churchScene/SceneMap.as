package church.view.churchScene
{
   import church.events.WeddingRoomEvent;
   import church.model.ChurchRoomModel;
   import church.player.ChurchPlayer;
   import church.view.churchFire.ChurchFireEffectPlayer;
   import church.vo.PlayerVO;
   import church.vo.SceneMapVO;
   import com.pickgliss.utils.ClassUtils;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
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
   import flash.utils.getTimer;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   
   public class SceneMap extends Sprite
   {
      
      public static const SCENE_ALLOW_FIRES:int = 6;
       
      
      private const CLICK_INTERVAL:Number = 200;
      
      protected var articleLayer:Sprite;
      
      protected var meshLayer:Sprite;
      
      protected var bgLayer:Sprite;
      
      protected var skyLayer:Sprite;
      
      public var sceneScene:SceneScene;
      
      protected var _data:DictionaryData;
      
      protected var _characters:DictionaryData;
      
      protected var _selfPlayer:ChurchPlayer;
      
      private var last_click:Number;
      
      private var current_display_fire:int = 0;
      
      private var _mouseMovie:MovieClip;
      
      private var _currentLoadingPlayer:ChurchPlayer;
      
      private var _isShowName:Boolean = true;
      
      private var _isChatBall:Boolean = true;
      
      private var _clickInterval:Number = 200;
      
      private var _lastClick:Number = 0;
      
      private var _sceneMapVO:SceneMapVO;
      
      private var _model:ChurchRoomModel;
      
      protected var reference:ChurchPlayer;
      
      public function SceneMap(param1:ChurchRoomModel, param2:SceneScene, param3:DictionaryData, param4:Sprite, param5:Sprite, param6:Sprite = null, param7:Sprite = null){super();}
      
      public function get sceneMapVO() : SceneMapVO{return null;}
      
      public function set sceneMapVO(param1:SceneMapVO) : void{}
      
      protected function init() : void{}
      
      protected function addEvent() : void{}
      
      private function menuChange(param1:WeddingRoomEvent) : void{}
      
      public function nameVisible() : void{}
      
      public function chatBallVisible() : void{}
      
      public function fireVisible() : void{}
      
      protected function updateMap(param1:Event) : void{}
      
      protected function __click(param1:MouseEvent) : void{}
      
      public function sendMyPosition(param1:Array) : void{}
      
      public function useFire(param1:int, param2:int) : void{}
      
      protected function fireCompleteHandler(param1:Event) : void{}
      
      public function movePlayer(param1:int, param2:Array) : void{}
      
      public function setCenter(param1:SceneCharacterEvent = null) : void{}
      
      public function addSelfPlayer() : void{}
      
      protected function ajustScreen(param1:ChurchPlayer) : void{}
      
      protected function __addPlayer(param1:DictionaryEvent) : void{}
      
      private function addPlayerCallBack(param1:ChurchPlayer, param2:Boolean, param3:int) : void{}
      
      private function playerActionChange(param1:SceneCharacterEvent) : void{}
      
      protected function __removePlayer(param1:DictionaryEvent) : void{}
      
      protected function BuildEntityDepth() : void{}
      
      protected function getPointDepth(param1:Number, param2:Number) : Number{return 0;}
      
      public function setSalute(param1:int) : void{}
      
      protected function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
