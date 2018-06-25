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
      
      protected function __onHide(event:MailEvent) : void
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
      
      private function __escapeKeyDown(evt:EmailEvent) : void
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
      
      private function __onOpenView(event:MailEvent) : void
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
      
      public function changeState(state:String) : void
      {
         MailManager.Instance.Model.state = state;
      }
      
      protected function __onShowWriting(event:MailEvent) : void
      {
         _name = String(event.info);
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
      
      private function __closeWriting(event:FrameEvent) : void
      {
         if(_write)
         {
            _write.closeWin();
         }
      }
      
      private function __closeWritingFrame(event:EmailEvent) : void
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
      
      private function __onDispose(event:EmailEvent) : void
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
      
      public function changeType(type:String) : void
      {
         if(MailManager.Instance.Model.mailType == type)
         {
            return;
         }
         updateNoReadMails();
         MailManager.Instance.Model.mailType = type;
      }
      
      public function updateNoReadMails() : void
      {
         MailManager.Instance.Model.getNoReadMails();
      }
      
      public function getAnnexToBag(info:EmailInfo, type:int) : void
      {
         if(!HasAtLeastOneDiamond(info))
         {
            return;
         }
         SocketManager.Instance.out.sendGetMail(info.ID,type);
      }
      
      private function HasAtLeastOneDiamond(info:EmailInfo) : Boolean
      {
         var i:* = 0;
         if(info.Gold > 0)
         {
            return true;
         }
         if(info.Money > 0)
         {
            return true;
         }
         if(info.BindMoney > 0)
         {
            return true;
         }
         if(info.Medal > 0)
         {
            return true;
         }
         i = uint(1);
         while(i <= 5)
         {
            if(info["Annex" + i])
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      public function deleteEmail(info:EmailInfo) : void
      {
         var arr:* = null;
         if(info)
         {
            if(info.Type == 59)
            {
               if(SharedManager.Instance.deleteMail[PlayerManager.Instance.Self.ID])
               {
                  arr = SharedManager.Instance.deleteMail[PlayerManager.Instance.Self.ID] as Array;
                  if(arr.indexOf(info.ID) < 0)
                  {
                     arr.push(info.ID);
                  }
               }
               else
               {
                  SharedManager.Instance.deleteMail[PlayerManager.Instance.Self.ID] = [info.ID];
               }
               SharedManager.Instance.save();
            }
            if(curShowPage == "sent")
            {
               SocketManager.Instance.out.sendDeleteSentMail(info.ID);
            }
            else
            {
               SocketManager.Instance.out.sendDeleteMail(info.ID);
            }
         }
      }
      
      public function readEmail(info:EmailInfo) : void
      {
         if(MailManager.Instance.Model.mailType != "no read mails")
         {
            MailManager.Instance.Model.removeFromNoRead(info);
         }
         SocketManager.Instance.out.sendUpdateMail(info.ID);
      }
      
      public function setPage(pre:Boolean, canChangePane:Boolean = true) : void
      {
         if(!pre && !canChangePane)
         {
            MailManager.Instance.Model.currentPage = MailManager.Instance.Model.currentPage;
            return;
         }
         if(pre)
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
      
      public function sendEmail(value:Object) : void
      {
         SocketManager.Instance.out.sendEmail(value);
      }
      
      public function onSendAnnex(annexArr:Array) : void
      {
         TaskManager.instance.onSendAnnex(annexArr);
      }
      
      public function removeMail(info:EmailInfo) : void
      {
         MailManager.Instance.Model.removeEmail(info);
      }
      
      private function __sendEmail(event:PkgEvent) : void
      {
         if(event.pkg.readBoolean())
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
