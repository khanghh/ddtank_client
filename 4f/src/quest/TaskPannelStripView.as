package quest{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.quest.QuestInfo;   import ddt.events.TaskEvent;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class TaskPannelStripView extends Sprite   {            private static const THIS_HEIGHT:int = 37;            private static const THIS_WIDTH:int = 214;                   private var _bg:ScaleFrameImage;            private var _info:QuestInfo;            private var _status:String;            private var titleField:FilterFrameText;            private var bmpNEW:MovieClip;            private var bmpOK:Bitmap;            private var bmpRecommond:Bitmap;            private var _light:Scale9CornerImage;            private var _trusteeshipTxtImg:Bitmap;            private var _style:int = 1;            public function TaskPannelStripView(info:QuestInfo) { super(); }
            public function set status(value:String) : void { }
            private function get isHovered() : Boolean { return false; }
            private function get isSelected() : Boolean { return false; }
            private function initView() : void { }
            public function set taskStyle(style:int) : void { }
            public function get info() : QuestInfo { return null; }
            protected function addEvent() : void { }
            protected function removeEvent() : void { }
            public function update() : void { }
            private function __onRollOver(event:MouseEvent) : void { }
            private function __onRollOut(event:MouseEvent) : void { }
            private function __onClick(event:MouseEvent) : void { }
            protected function _active() : void { }
            protected function _deactive() : void { }
            public function onShow() : void { }
            public function active() : void { }
            public function deactive() : void { }
            override public function get width() : Number { return 0; }
            override public function get height() : Number { return 0; }
            public function dispose() : void { }
   }}