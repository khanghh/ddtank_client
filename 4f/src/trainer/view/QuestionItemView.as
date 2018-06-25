package trainer.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class QuestionItemView extends Sprite implements Disposeable   {                   private var _bmpSel:Bitmap;            private var _imgIcon:ScaleFrameImage;            private var _txtContext:FilterFrameText;            private var _index:int;            private var _filters:Vector.<Array>;            public function QuestionItemView() { super(); }
            public function get index() : int { return 0; }
            public function setData(index:int, answer:String) : void { }
            private function initView() : void { }
            private function __mouseHandler(evt:MouseEvent) : void { }
            public function dispose() : void { }
   }}