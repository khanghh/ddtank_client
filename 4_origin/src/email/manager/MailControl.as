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
      
      public function MailControl()
      {
         super();
      }
      
      public static function get Instance() : MailControl
      {
         if(_instance == null)
         {
            _instance = new MailControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         MailManager.Instance.addEventListener("emailOpenView",__onOpenView);
         MailManager.Instance.addEventListener("emailShowWriting",__onShowWriting);
         MailManager.Instance.addEventListener("emailHide",__onHide);
         SocketManager.Instance.addEventListener(PkgEvent.format(116),__sendEmail);
      }
      
      public function show() : void
      {
         hide();
         _view = ComponentFactory.Instance.creatCustomObject("emailView");
         _view.setup(this,MailManager.Instance.Model);
         _view.addEventListener("escapeKey",__escapeKeyDown);
         MailManager.Instance.isShow = true;
         _view.show();
      }
      
      protected function __onHide(param1:MailEvent) : void
      {
         hide();
      }
      
      public function hide() : void
      {
         if(_view)
         {
            MailManager.Instance.Model.selectEmail = null;
            MailManager.Instance.Model.mailType = "all mails";
            _view.removeEventListener("escapeKey",__escapeKeyDown);
            _view.dispose();
            _view = null;
         }
         MailManager.Instance.isShow = false;
         if(MailManager.Instance.isOpenFromBag)
         {
            GiftManager.Instance.show();
         }
         MailManager.Instance.isOpenFromBag = false;
      }
      
      private function __escapeKeyDown(param1:EmailEvent) : void
      {
         if(_write && _write.parent)
         {
            _write.removeEventListener("escapeKey",__escapeKeyDown);
            _write.removeEventListener("closeWritingFrame",__closeWritingFrame);
            ObjectUtils.disposeObject(_write);
            _write = null;
         }
         if(_view)
         {
            if(_view.writeView && _view.writeView.parent)
            {
               _view.writeView.closeWin();
            }
            else
            {
               hide();
            }
         }
      }
      
      private function __onOpenView(param1:MailEvent) : void
      {
         if(_view && _view.parent)
         {
            hide();
         }
         else
         {
            show();
            MailManager.Instance.Model.dispatchEvent(new NewHallEvent("cancelemailshine"));
         }
      }
      
      public function changeState(param1:String) : void
      {
         MailManager.Instance.Model.state = param1;
      }
      
      protected function __onShowWriting(param1:MailEvent) : void
      {
         _name = String(param1.info);
         creatWriteView();
      }
      
      private function creatWriteView() : void
      {
         if(_write != null)
         {
            _write = null;
         }
         _write = ComponentFactory.Instance.creat("email.writingView");
         _write.type = 0;
         PositionUtils.setPos(_write,"EmailView.Pos_2");
         _write.selectInfo = MailManager.Instance.Model.selectEmail;
         LayerManager.Instance.addToLayer(_write,3,false,1);
         if(StageReferance.stage && StageReferance.stage.focus)
         {
            StageReferance.stage.focus == _write;
         }
         _write.reset();
         if(_name != null)
         {
            _write.setName(_name);
         }
         _write.addEventListener("closeWritingFrame",__closeWritingFrame);
         _write.addEventListener("response",__closeWriting);
         _write.addEventListener("escapeKey",__escapeKeyDown);
         _write.addEventListener("disposed",__onDispose);
      }
      
      private function __closeWriting(param1:FrameEvent) : void
      {
         if(_write)
         {
            _write.closeWin();
         }
      }
      
      private function __closeWritingFrame(param1:EmailEvent) : void
      {
         if(_write)
         {
            _write.removeEventListener("response",__closeWriting);
            _write.removeEventListener("escapeKey",__escapeKeyDown);
            _write.removeEventListener("closeWritingFrame",__closeWritingFrame);
            ObjectUtils.disposeObject(_write);
            _write = null;
         }
      }
      
      private function __onDispose(param1:EmailEvent) : void
      {
         if(_write)
         {
            try
            {
               _write.removeEventListener("response",__closeWriting);
               _write.removeEventListener("escapeKey",__escapeKeyDown);
               _write.removeEventListener("closeWritingFrame",__closeWritingFrame);
               ObjectUtils.disposeObject(_write);
            }
            catch(e:Error)
            {
            }
         }
         _write = null;
      }
      
      public function changeType(param1:String) : void
      {
         if(MailManager.Instance.Model.mailType == param1)
         {
            return;
         }
         updateNoReadMails();
         MailManager.Instance.Model.mailType = param1;
      }
      
      public function updateNoReadMails() : void
      {
         MailManager.Instance.Model.getNoReadMails();
      }
      
      public function getAnnexToBag(param1:EmailInfo, param2:int) : void
      {
         if(!HasAtLeastOneDiamond(param1))
         {
            return;
         }
         SocketManager.Instance.out.sendGetMail(param1.ID,param2);
      }
      
      private function HasAtLeastOneDiamond(param1:EmailInfo) : Boolean
      {
         var _loc2_:* = 0;
         if(param1.Gold > 0)
         {
            return true;
         }
         if(param1.Money > 0)
         {
            return true;
         }
         if(param1.BindMoney > 0)
         {
            return true;
         }
         if(param1.Medal > 0)
         {
            return true;
         }
         _loc2_ = uint(1);
         while(_loc2_ <= 5)
         {
            if(param1["Annex" + _loc2_])
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function deleteEmail(param1:EmailInfo) : void
      {
         var _loc2_:* = null;
         if(param1)
         {
            if(param1.Type == 59)
            {
               if(SharedManager.Instance.deleteMail[PlayerManager.Instance.Self.ID])
               {
                  _loc2_ = SharedManager.Instance.deleteMail[PlayerManager.Instance.Self.ID] as Array;
                  if(_loc2_.indexOf(param1.ID) < 0)
                  {
                     _loc2_.push(param1.ID);
                  }
               }
               else
               {
                  SharedManager.Instance.deleteMail[PlayerManager.Instance.Self.ID] = [param1.ID];
               }
               SharedManager.Instance.save();
            }
            if(curShowPage == "sent")
            {
               SocketManager.Instance.out.sendDeleteSentMail(param1.ID);
            }
            else
            {
               SocketManager.Instance.out.sendDeleteMail(param1.ID);
            }
         }
      }
      
      public function readEmail(param1:EmailInfo) : void
      {
         if(MailManager.Instance.Model.mailType != "no read mails")
         {
            MailManager.Instance.Model.removeFromNoRead(param1);
         }
         SocketManager.Instance.out.sendUpdateMail(param1.ID);
      }
      
      public function setPage(param1:Boolean, param2:Boolean = true) : void
      {
         if(!param1 && !param2)
         {
            MailManager.Instance.Model.currentPage = MailManager.Instance.Model.currentPage;
            return;
         }
         if(param1)
         {
            if(MailManager.Instance.Model.currentPage - 1 > 0)
            {
               MailManager.Instance.Model.currentPage = MailManager.Instance.Model.currentPage - 1;
            }
            else
            {
               MailManager.Instance.Model.currentPage = MailManager.Instance.Model.totalPage;
            }
         }
         else if(MailManager.Instance.Model.currentPage + 1 <= MailManager.Instance.Model.totalPage)
         {
            MailManager.Instance.Model.currentPage = MailManager.Instance.Model.currentPage + 1;
         }
         else if(MailManager.Instance.Model.mailType == "no read mails" && MailManager.Instance.Model.totalPage == 1)
         {
            MailManager.Instance.Model.currentPage = 1;
         }
         else
         {
            MailManager.Instance.Model.currentPage = 1;
         }
      }
      
      public function sendEmail(param1:Object) : void
      {
         SocketManager.Instance.out.sendEmail(param1);
      }
      
      public function onSendAnnex(param1:Array) : void
      {
         TaskManager.instance.onSendAnnex(param1);
      }
      
      public function removeMail(param1:EmailInfo) : void
      {
         MailManager.Instance.Model.removeEmail(param1);
      }
      
      private function __sendEmail(param1:PkgEvent) : void
      {
         if(param1.pkg.readBoolean())
         {
            if(_view)
            {
               _view.resetWrite();
            }
            if(_write)
            {
               _write.reset();
            }
         }
      }
   }
}
