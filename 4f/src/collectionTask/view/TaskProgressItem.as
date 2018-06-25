package collectionTask.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.utils.PositionUtils;   import flash.display.Sprite;      public class TaskProgressItem extends Sprite implements Disposeable   {                   private var _nameTxt:FilterFrameText;            private var _progressTxt:FilterFrameText;            private var _nameStr:String;            private var _progressStr:String;            public function TaskProgressItem() { super(); }
            private function initView() : void { }
            public function refresh(desc:String) : void { }
            public function dispose() : void { }
   }}