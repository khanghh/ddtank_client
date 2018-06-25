package questionAward.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import flash.display.Sprite;   import questionAward.data.QuestionDataBaseInfo;      public class QuestionViewBase extends Sprite   {                   protected var _title:FilterFrameText;            protected var _info:QuestionDataBaseInfo;            public function QuestionViewBase(value:QuestionDataBaseInfo) { super(); }
            public function getAnswer() : String { return null; }
            protected function initView() : void { }
            protected function initData() : void { }
            public function dispose() : void { }
   }}