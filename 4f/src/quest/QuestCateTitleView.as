package quest{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.filters.ColorMatrixFilter;      public class QuestCateTitleView extends Sprite implements Disposeable   {                   private var _type:int;            private var _isExpanded:Boolean;            private var rLum:Number = 0.2225;            private var gLum:Number = 0.7169;            private var bLum:Number = 0.0606;            private var bwMatrix:Array;            private var cmf:ColorMatrixFilter;            private var bg:ScaleFrameImage;            private var titleImg:ScaleFrameImage;            private var titleIconImg:ScaleFrameImage;            private var bmpNEW:MovieClip;            private var bmpOK:Bitmap;            private var bmpRecommond:Bitmap;            private var _expandBg:DisplayObject;            public function QuestCateTitleView(cateID:int = 0) { super(); }
            override public function get width() : Number { return 0; }
            override public function get height() : Number { return 0; }
            private function initView() : void { }
            private function initEvent() : void { }
            public function set taskStyle(style:int) : void { }
            public function set enable(value:Boolean) : void { }
            public function get isExpanded() : Boolean { return false; }
            public function set isExpanded(value:Boolean) : void { }
            public function haveNew() : void { }
            public function haveCompleted() : void { }
            public function haveNoTag() : void { }
            public function haveRecommond() : void { }
            public function dispose() : void { }
   }}