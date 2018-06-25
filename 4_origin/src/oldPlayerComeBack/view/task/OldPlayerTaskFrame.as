package oldPlayerComeBack.view.task
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.quest.QuestDataInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.events.TaskEvent;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import quest.TaskManager;
   
   public class OldPlayerTaskFrame extends Frame
   {
       
      
      private var _view:OldPlayerTaskView;
      
      private var _bg:Bitmap;
      
      public function OldPlayerTaskFrame()
      {
         super();
         initEVent();
      }
      
      override protected function init() : void
      {
         super.init();
         titleText = LanguageMgr.GetTranslation("oldPlayerComeBack.taskView.titleTxt");
         _bg = ComponentFactory.Instance.creat("asset.oldPlayerComeBack.taskBg");
         addToContent(_bg);
         _view = new OldPlayerTaskView();
         PositionUtils.setPos(_view,"oldPlayerComeBack.taskViewPos");
         addToContent(_view);
      }
      
      private function initEVent() : void
      {
         addEventListener("response",__responseHandler);
         TaskManager.instance.addEventListener("changed",__taskChangedHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         TaskManager.instance.removeEventListener("changed",__taskChangedHandler);
      }
      
      private function __taskChangedHandler(evt:TaskEvent) : void
      {
         var info:QuestInfo = evt.info;
         var data:QuestDataInfo = evt.data;
         if(_view)
         {
            _view.updateTaskItem(info);
         }
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_view)
         {
            ObjectUtils.disposeObject(_view);
         }
         _view = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
