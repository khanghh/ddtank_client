package email.manager{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.email.EmailInfo;   import ddt.events.EmailEvent;   import ddt.events.PkgEvent;   import ddt.manager.PlayerManager;   import ddt.manager.SharedManager;   import ddt.manager.SocketManager;   import ddt.utils.PositionUtils;   import email.MailEvent;   import email.MailManager;   import email.view.EmailView;   import email.view.WritingView;   import flash.net.URLVariables;   import giftSystem.GiftManager;   import hall.event.NewHallEvent;   import quest.TaskManager;      public class MailControl   {            private static var useFirst:Boolean = true;            public static const TYPE_MAIL:String = "mail";            public static const TYPE_NOT_READ:String = "not_read";            public static const TYPE_SENT:String = "sent";            private static var _instance:MailControl;                   public const NUM_OF_WRITING_DIAMONDS:uint = 4;            private var _view:EmailView;            private var args:URLVariables;            private var _write:WritingView;            private var _loadedUiModuleNum:int;            public var curShowPage:String;            private var _name:String;            public function MailControl() { super(); }
            public static function get Instance() : MailControl { return null; }
            public function setup() : void { }
            public function show() : void { }
            protected function __onHide(event:MailEvent) : void { }
            public function hide() : void { }
            private function __escapeKeyDown(evt:EmailEvent) : void { }
            private function __onOpenView(event:MailEvent) : void { }
            public function changeState(state:String) : void { }
            protected function __onShowWriting(event:MailEvent) : void { }
            private function creatWriteView() : void { }
            private function __closeWriting(event:FrameEvent) : void { }
            private function __closeWritingFrame(event:EmailEvent) : void { }
            private function __onDispose(event:EmailEvent) : void { }
            public function changeType(type:String) : void { }
            public function updateNoReadMails() : void { }
            public function getAnnexToBag(info:EmailInfo, type:int) : void { }
            private function HasAtLeastOneDiamond(info:EmailInfo) : Boolean { return false; }
            public function deleteEmail(info:EmailInfo) : void { }
            public function readEmail(info:EmailInfo) : void { }
            public function setPage(pre:Boolean, canChangePane:Boolean = true) : void { }
            public function sendEmail(value:Object) : void { }
            public function onSendAnnex(annexArr:Array) : void { }
            public function removeMail(info:EmailInfo) : void { }
            private function __sendEmail(event:PkgEvent) : void { }
   }}