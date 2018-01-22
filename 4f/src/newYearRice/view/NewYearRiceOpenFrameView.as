package newYearRice.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.BossBoxManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.UIModuleSmallLoading;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import invite.InviteFrame;
   import invite.InviteManager;
   import newYearRice.NewYearRiceController;
   import newYearRice.NewYearRiceManager;
   import road7th.comm.PackageIn;
   import room.RoomManager;
   
   public class NewYearRiceOpenFrameView extends Frame
   {
       
      
      private var _main:MovieClip;
      
      private var _openBtn:BaseButton;
      
      private var _inviteBtn:BaseButton;
      
      private var _playerItems:Vector.<PlayerCell>;
      
      private var _startInvite:Boolean = false;
      
      private var _inviteFrame:InviteFrame;
      
      private var _bg:Bitmap;
      
      private var _playerID:int;
      
      private var _isRoomPlayer:Boolean;
      
      private var _nameID:int;
      
      private var _alert1:BaseAlerFrame;
      
      private var _roomPlayerID:int;
      
      public function NewYearRiceOpenFrameView(){super();}
      
      private function initView() : void{}
      
      private function __cellClick(param1:MouseEvent) : void{}
      
      private function __quitPlayer(param1:FrameEvent) : void{}
      
      public function roomPlayerItem(param1:int) : void{}
      
      public function updatePlayerItem(param1:Array) : void{}
      
      private function addEvents() : void{}
      
      private function removeEvents() : void{}
      
      private function __quitYearFoodRoom(param1:CrazyTankSocketEvent) : void{}
      
      private function __updateView(param1:Event) : void{}
      
      public function setBtnEnter() : void{}
      
      private function __exitYearFoodRoom(param1:CrazyTankSocketEvent) : void{}
      
      public function setViewFrame(param1:int) : void{}
      
      private function __openBtnHandler(param1:MouseEvent) : void{}
      
      private function __inviteBtnHandler(param1:MouseEvent) : void{}
      
      protected function startInvite() : void{}
      
      private function loadInviteRes() : void{}
      
      private function __onClose(param1:Event) : void{}
      
      private function __onInviteResComplete(param1:UIModuleEvent) : void{}
      
      private function __onInviteComplete(param1:Event) : void{}
      
      private function __onInviteResError(param1:UIModuleEvent) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
