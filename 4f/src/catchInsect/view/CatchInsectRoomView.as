package catchInsect.view
{
   import baglocked.BaglockedManager;
   import catchInsect.CatchInsectControl;
   import catchInsect.CatchInsectManager;
   import catchInsect.CatchInsectRoomModel;
   import catchInsect.componets.RoomMenuView;
   import catchInsect.event.CatchInsectRoomEvent;
   import catchInsect.loader.LoaderCatchInsectUIModule;
   import church.vo.SceneMapVO;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyFrame;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.chat.ChatView;
   import ddt.view.scenePathSearcher.PathMapHitTester;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class CatchInsectRoomView extends Sprite implements Disposeable
   {
      
      public static const MAP_SIZEII:Array = [1738,1300];
       
      
      private var _contoller:CatchInsectRoomController;
      
      private var _model:CatchInsectRoomModel;
      
      private var _sceneScene:SceneScene;
      
      private var _sceneMap:CatchInsectScneneMap;
      
      private var _chatFrame:ChatView;
      
      private var _roomMenuView:RoomMenuView;
      
      private var _sceneInfoViewBg:Bitmap;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _ballCountTxt:FilterFrameText;
      
      private var _netCountTxt:FilterFrameText;
      
      private var _buyBallBtn:SimpleBitmapButton;
      
      private var _buyNetBtn:SimpleBitmapButton;
      
      private var _useCakeBtn:SimpleBitmapButton;
      
      private var _useWhistleBtn:SimpleBitmapButton;
      
      private var _useCakeTxt:FilterFrameText;
      
      private var _useWhistleTxt:FilterFrameText;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _timer:Timer;
      
      public function CatchInsectRoomView(param1:CatchInsectRoomController, param2:CatchInsectRoomModel){super();}
      
      public function show() : void{}
      
      private function initialize() : void{}
      
      private function addEvent() : void{}
      
      private function updateBtnTxt() : void{}
      
      private function __updateFightMonster(param1:CatchInsectRoomEvent) : void{}
      
      protected function __useCakeBtnClick(param1:MouseEvent) : void{}
      
      protected function __useWhistleBtnClick(param1:MouseEvent) : void{}
      
      protected function __updateScore(param1:Event) : void{}
      
      private function removeEvent() : void{}
      
      protected function __updateGoods(param1:BagEvent) : void{}
      
      protected function __buyNetBtnClick(param1:MouseEvent) : void{}
      
      protected function __buyBallBtnClick(param1:MouseEvent) : void{}
      
      public function setViewAgain() : void{}
      
      public function setMap(param1:Point = null) : void{}
      
      public function getSceneMapVO() : SceneMapVO{return null;}
      
      public function movePlayer(param1:int, param2:Array) : void{}
      
      public function updatePlayerStauts(param1:int, param2:int, param3:Point = null) : void{}
      
      public function updateSelfStatus(param1:int) : void{}
      
      private function _leaveRoom(param1:Event) : void{}
      
      private function clearMap() : void{}
      
      public function dispose() : void{}
   }
}
