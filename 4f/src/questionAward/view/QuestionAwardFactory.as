package questionAward.view{   import questionAward.data.QuestionDataBaseInfo;      public class QuestionAwardFactory   {            private static var _instance:QuestionAwardFactory;                   public function QuestionAwardFactory(enforcer:QuestionAwardFactoryEnforcer) { super(); }
            public static function get instance() : QuestionAwardFactory { return null; }
            public function createQuestionView(info:QuestionDataBaseInfo) : QuestionViewBase { return null; }
            private function createSelectview(data:QuestionDataBaseInfo) : QuestionViewBase { return null; }
            private function createAnswerView(data:QuestionDataBaseInfo) : QuestionViewBase { return null; }
   }}class QuestionAwardFactoryEnforcer{          function QuestionAwardFactoryEnforcer() { super(); }
}