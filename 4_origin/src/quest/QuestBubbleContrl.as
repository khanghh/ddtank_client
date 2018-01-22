package quest
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   
   public class QuestBubbleContrl
   {
      
      private static var _instance:QuestBubbleContrl;
       
      
      private var _view:QuestBubble;
      
      private var _model:QuestBubbleMode;
      
      public function QuestBubbleContrl()
      {
         super();
      }
      
      public static function get instance() : QuestBubbleContrl
      {
         if(_instance == null)
         {
            _instance = new QuestBubbleContrl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         QuestBubbleManager.Instance.addEventListener("QuestBubbleShow",__questBubbleShowHandler);
         QuestBubbleManager.Instance.addEventListener("QuestBubbleHide",__questBubbleHideHandler);
      }
      
      private function __questBubbleShowHandler(param1:Event) : void
      {
         if(_view)
         {
            return;
         }
         _model = new QuestBubbleMode();
         if(_model.questsInfo.length <= 0)
         {
            _model = null;
            QuestBubbleManager.Instance.dispatchEvent(new Event("show_task_tip"));
            return;
         }
         _view = new QuestBubble();
         _view.start(_model.questsInfo);
         _view.show();
      }
      
      private function __questBubbleHideHandler(param1:Event) : void
      {
         ObjectUtils.disposeObject(_view);
         _view = null;
      }
   }
}
