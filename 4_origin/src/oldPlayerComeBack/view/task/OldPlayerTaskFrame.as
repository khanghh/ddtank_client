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
      
      private function __taskChangedHandler(param1:TaskEvent) : void
      {
         var _loc3_:QuestInfo = param1.info;
         var _loc2_:QuestDataInfo = param1.data;
         if(_view)
         {
            _view.updateTaskItem(_loc3_);
         }
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
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
