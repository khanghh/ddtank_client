package quest{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.quest.QuestInfo;   import flash.display.Bitmap;   import flash.display.Sprite;      public class QuestInfoItemView extends Sprite implements Disposeable   {                   protected var _titleBg:Bitmap;            protected var _titleImg:ScaleFrameImage;            protected var _content:Sprite;            protected var _panel:ScrollPanel;            protected var _info:QuestInfo;            public function QuestInfoItemView() { super(); }
            override public function get height() : Number { return 0; }
            protected function initView() : void { }
            public function set info(value:QuestInfo) : void { }
            public function dispose() : void { }
   }}