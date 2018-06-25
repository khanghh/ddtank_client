package quest{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.quest.QuestCondition;   import flash.display.Bitmap;   import flash.display.Sprite;      public class QuestConditionView extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _cond:QuestCondition;            private var conditionText:FilterFrameText;            private var statusText:FilterFrameText;            public function QuestConditionView(condition:QuestCondition) { super(); }
            public function set status(value:String) : void { }
            public function set text(value:String) : void { }
            public function set isComplete(value:Boolean) : void { }
            override public function get height() : Number { return 0; }
            public function dispose() : void { }
   }}