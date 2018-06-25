package feedback{   import com.pickgliss.ui.ComponentFactory;   import ddt.events.CEvent;   import feedback.data.FeedbackReplyInfo;   import feedback.view.FeedbackReplyFrame;   import feedback.view.FeedbackSubmitFrame;   import flash.events.EventDispatcher;      public class FeedbackController extends EventDispatcher   {            private static var _instance:FeedbackController;                   private var _feedbackSubmitFrame:FeedbackSubmitFrame;            private var _feedbackReplyFrame:FeedbackReplyFrame;            private var _manager:FeedbackManager;            public function FeedbackController() { super(); }
            public static function get instance() : FeedbackController { return null; }
            public function setup() : void { }
            protected function addEvents() : void { }
            private function onEventsHandler(e:CEvent) : void { }
            private function openFeedbackSubmitView() : void { }
            private function openFeedbackReplyView() : void { }
            public function closeFrame() : void { }
   }}