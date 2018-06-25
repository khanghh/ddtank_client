package email.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.email.EmailModel;
   import ddt.events.EmailEvent;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import email.manager.MailControl;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   
   public class EmailView extends Sprite implements Disposeable
   {
       
      
      private var _controller:MailControl;
      
      private var _model:EmailModel;
      
      private var _read:ReadingView;
      
      private var _write:WritingView;
      
      public function EmailView()
      {
         super();
      }
      
      public function setup(controller:MailControl, model:EmailModel) : void
      {
         _controller = controller;
         _model = model;
         addEvent();
      }
      
      private function addEvent() : void
      {
         addEventListener("addedToStage",__addToStage);
         _model.addEventListener("changeState",__changeState);
         _model.addEventListener("changeType",__changeType);
         _model.addEventListener("changePage",__changePage);
         _model.addEventListener("selectEmail",__selectEmail);
         _model.addEventListener("removeEmail",__removeEmail);
         _model.addEventListener("initEmail",__initEmail);
         addEventListener("keyDown",__keyDownHandler);
      }
      
      private function removeEvent() : void
      {
         _model.removeEventListener("changeState",__changeState);
         _model.removeEventListener("changeType",__changeType);
         _model.removeEventListener("changePage",__changePage);
         _model.removeEventListener("selectEmail",__selectEmail);
         _model.removeEventListener("removeEmail",__removeEmail);
         _model.removeEventListener("initEmail",__initEmail);
         removeEventListener("keyDown",__keyDownHandler);
      }
      
      private function __keyDownHandler(evt:KeyboardEvent) : void
      {
         if(evt.keyCode == 27)
         {
            evt.stopImmediatePropagation();
            SoundManager.instance.play("008");
            this.dispatchEvent(new EmailEvent("escapeKey"));
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         _controller = null;
         _model = null;
         if(_read)
         {
            ObjectUtils.disposeObject(_read);
         }
         _read = null;
         if(_write)
         {
            ObjectUtils.disposeObject(_write);
         }
         _write = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      public function resetWrite() : void
      {
         _write.reset();
      }
      
      public function cancelMail() : void
      {
         _read.setListView(_model.getViewData(),_model.totalPage,_model.currentPage);
      }
      
      private function __addToStage(event:Event) : void
      {
         MailControl.Instance.changeState("read");
         MailControl.Instance.changeType("all mails");
         MailControl.Instance.updateNoReadMails();
         if(_model.isLoaded)
         {
            _model.currentPage = 1;
         }
      }
      
      private function __changeType(event:EmailEvent) : void
      {
         _read.switchBtnsVisible(_model.mailType != "sended mails");
         updateListView();
      }
      
      private function __changeState(event:EmailEvent) : void
      {
         if(_model.state == "read")
         {
            if(_read == null)
            {
               _read = ComponentFactory.Instance.creat("email.readingView");
            }
            addChild(_read);
            if(_write && _write.parent)
            {
               _write.parent.removeChild(_write);
            }
            if(stage && stage.focus)
            {
               stage.focus == _read;
            }
            PositionUtils.setPos(this,"EmailView.Pos_0");
         }
         else
         {
            if(_write == null)
            {
               _write = ComponentFactory.Instance.creat("email.writingView");
            }
            PositionUtils.setPos(this,"EmailView.Pos_1");
            _write.selectInfo = _model.selectEmail;
            addChild(_write);
            if(_read && _read.parent)
            {
               _read.parent.removeChild(_read);
            }
            if(stage && stage.focus)
            {
               stage.focus == _write;
            }
            if(_model.state == "write")
            {
               _write.reset();
            }
         }
      }
      
      private function __changePage(event:EmailEvent) : void
      {
         updateListView();
      }
      
      private function __selectEmail(event:EmailEvent) : void
      {
         _read.info = event.info;
         if(event.info == null)
         {
            _read.personalHide();
         }
         _read.readOnly = false;
         if(_model.mailType == "sended mails")
         {
            _read.isCanReply = false;
            _read.readOnly = true;
            return;
         }
         _read.isCanReply = _model.selectEmail && _model.selectEmail.canReply?true:false;
      }
      
      private function __removeEmail(event:EmailEvent) : void
      {
         updateListView();
      }
      
      private function __initEmail(event:EmailEvent) : void
      {
         updateListView();
      }
      
      private function updateListView() : void
      {
         _read.setListView(_model.getViewData(),_model.totalPage,_model.currentPage,_model.mailType == "sended mails");
      }
      
      public function get writeView() : WritingView
      {
         return _write;
      }
   }
}
