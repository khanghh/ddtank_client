package farm.viewx.poultry
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import ddt.view.chat.chatBall.ChatBallPlayer;
   import farm.FarmEvent;
   import farm.FarmModelController;
   import farm.modelx.FarmPoultryInfo;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.ui.Mouse;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import road.game.resource.ActionMovie;
   import room.RoomManager;
   import roomList.RoomListEnumerate;
   
   public class FarmPoultry extends Sprite implements Disposeable
   {
       
      
      private var _poultry:ActionMovie;
      
      private var _poultryName:FilterFrameText;
      
      private var _expSprite:Sprite;
      
      private var _bloodBg:Bitmap;
      
      private var _blood:Bitmap;
      
      private var _wakeFeed:WakeFeedCountDown;
      
      private var _mask:Sprite;
      
      private var _poultryArea:Sprite;
      
      private var _expText:FilterFrameText;
      
      private var _fightBossFlag:Boolean;
      
      private var _sward:MovieClip;
      
      private var _pointArray:Array;
      
      private var _pointId:int = 0;
      
      private var _walkTimer:Timer;
      
      private var _offPoint:Point;
      
      private var _moveSpeed:int = 5;
      
      private var _last_creat:uint;
      
      private var _chatBallView:ChatBallPlayer;
      
      public function FarmPoultry(){super();}
      
      public function startLoadPoultry() : void{}
      
      private function initView() : void{}
      
      private function creatChatBall() : void{}
      
      private function creatTimer() : void{}
      
      private function creatMask() : void{}
      
      private function initEvent() : void{}
      
      public function setInfo(param1:int, param2:int, param3:int, param4:Date) : void{}
      
      private function initPoultryInfo() : void{}
      
      private function setExp(param1:int, param2:int) : void{}
      
      private function setWakeFeedBtnState(param1:int) : void{}
      
      protected function __onPoultryWalk(param1:TimerEvent) : void{}
      
      protected function __onEnterFrame(param1:Event) : void{}
      
      private function loadPoultry() : void{}
      
      protected function __onLoadComplete(param1:LoaderEvent) : void{}
      
      private function creatPoultryArea(param1:int, param2:int, param3:int) : void{}
      
      protected function __onAreaClick(param1:MouseEvent) : void{}
      
      protected function __gameStart(param1:CrazyTankSocketEvent) : void{}
      
      protected function __onAreaMove(param1:MouseEvent) : void{}
      
      protected function __onAreaOut(param1:MouseEvent) : void{}
      
      protected function __onAreaOver(param1:MouseEvent) : void{}
      
      private function deletePoultryArea() : void{}
      
      private function deleteChatBallView() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
