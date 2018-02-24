package email.manager
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.email.EmailInfo;
   import ddt.events.EmailEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import email.MailEvent;
   import email.MailManager;
   import email.view.EmailView;
   import email.view.WritingView;
   import flash.net.URLVariables;
   import giftSystem.GiftManager;
   import hall.event.NewHallEvent;
   import quest.TaskManager;
   
   public class MailControl
   {
      
      private static var useFirst:Boolean = true;
      
      public static const TYPE_MAIL:String = "mail";
      
      public static const TYPE_NOT_READ:String = "not_read";
      
      public static const TYPE_SENT:String = "sent";
      
      private static var _instance:MailControl;
       
      
      public const NUM_OF_WRITING_DIAMONDS:uint = 4;
      
      private var _view:EmailView;
      
      private var args:URLVariables;
      
      private var _write:WritingView;
      
      private var _loadedUiModuleNum:int;
      
      public var curShowPage:String;
      
      private var _name:String;
      
      public function MailControl(){super();}
      
      public static function get Instance() : MailControl{return null;}
      
      public function setup() : void{}
      
      public function show() : void{}
      
      protected function __onHide(param1:MailEvent) : void{}
      
      public function hide() : void{}
      
      private function __escapeKeyDown(param1:EmailEvent) : void{}
      
      private function __onOpenView(param1:MailEvent) : void{}
      
      public function changeState(param1:String) : void{}
      
      protected function __onShowWriting(param1:MailEvent) : void{}
      
      private function creatWriteView() : void{}
      
      private function __closeWriting(param1:FrameEvent) : void{}
      
      private function __closeWritingFrame(param1:EmailEvent) : void{}
      
      private function __onDispose(param1:EmailEvent) : void{}
      
      public function changeType(param1:String) : void{}
      
      public function updateNoReadMails() : void{}
      
      public function getAnnexToBag(param1:EmailInfo, param2:int) : void{}
      
      private function HasAtLeastOneDiamond(param1:EmailInfo) : Boolean{return false;}
      
      public function deleteEmail(param1:EmailInfo) : void{}
      
      public function readEmail(param1:EmailInfo) : void{}
      
      public function setPage(param1:Boolean, param2:Boolean = true) : void{}
      
      public function sendEmail(param1:Object) : void{}
      
      public function onSendAnnex(param1:Array) : void{}
      
      public function removeMail(param1:EmailInfo) : void{}
      
      private function __sendEmail(param1:PkgEvent) : void{}
   }
}
