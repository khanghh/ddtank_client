package feedback
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.events.CEvent;
   import feedback.data.FeedbackReplyInfo;
   import feedback.view.FeedbackReplyFrame;
   import feedback.view.FeedbackSubmitFrame;
   import flash.events.EventDispatcher;
   
   public class FeedbackController extends EventDispatcher
   {
      
      private static var _instance:FeedbackController;
       
      
      private var _feedbackSubmitFrame:FeedbackSubmitFrame;
      
      private var _feedbackReplyFrame:FeedbackReplyFrame;
      
      private var _manager:FeedbackManager;
      
      public function FeedbackController()
      {
         super();
      }
      
      public static function get instance() : FeedbackController
      {
         if(_instance == null)
         {
            _instance = new FeedbackController();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _manager = FeedbackManager.instance;
         addEvents();
      }
      
      protected function addEvents() : void
      {
         _manager.addEventListener("closeFrame",onEventsHandler);
         _manager.addEventListener("openFeedbackReply",onEventsHandler);
         _manager.addEventListener("openFeedbackSubmit",onEventsHandler);
      }
      
      private function onEventsHandler(e:CEvent) : void
      {
         var _loc2_:* = e.type;
         if("openFeedbackReply" !== _loc2_)
         {
            if("openFeedbackSubmit" !== _loc2_)
            {
               if("closeFrame" === _loc2_)
               {
                  closeFrame();
               }
            }
            else
            {
               openFeedbackSubmitView();
            }
         }
         else
         {
            openFeedbackReplyView();
         }
      }
      
      private function openFeedbackSubmitView() : void
      {
         if(!_feedbackSubmitFrame)
         {
            _feedbackSubmitFrame = ComponentFactory.Instance.creatComponentByStylename("feedback.feedbackSubmitFrame");
            _feedbackSubmitFrame.show();
            return;
         }
         closeFrame();
      }
      
      private function openFeedbackReplyView() : void
      {
         if(!_feedbackReplyFrame)
         {
            _feedbackReplyFrame = ComponentFactory.Instance.creatComponentByStylename("feedback.feedbackReplyFrame");
            _feedbackReplyFrame.show();
            _feedbackReplyFrame.setup(_manager._feedbackReplyData.list[0] as FeedbackReplyInfo);
            return;
         }
         closeFrame();
      }
      
      public function closeFrame() : void
      {
         _manager._feedbackInfo = null;
         if(_feedbackSubmitFrame)
         {
            _feedbackSubmitFrame.dispose();
            _feedbackSubmitFrame = null;
         }
         if(_feedbackReplyFrame)
         {
            _feedbackReplyFrame.dispose();
            _feedbackReplyFrame = null;
         }
      }
   }
}
