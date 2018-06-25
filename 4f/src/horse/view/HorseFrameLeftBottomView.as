package horse.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.utils.PositionUtils;   import ddt.view.horse.HorseFrameLeftBottomStarCell;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Shape;   import flash.display.Sprite;   import flash.events.Event;   import horse.HorseManager;      public class HorseFrameLeftBottomView extends Sprite implements Disposeable   {                   private var _levelStarTxtImage:Bitmap;            private var _levelTxt:FilterFrameText;            private var _starTxt:FilterFrameText;            private var _starCellList:Vector.<HorseFrameLeftBottomStarCell>;            private var _progressTxtImage:Bitmap;            private var _progressBg:Bitmap;            private var _progressCover:Bitmap;            private var _progressBarMask:Shape;            private var _progressTxt:FilterFrameText;            public function HorseFrameLeftBottomView() { super(); }
            private function initView() : void { }
            private function creatMask(source:DisplayObject) : Shape { return null; }
            private function initEvent() : void { }
            private function upHorseHandler(event:Event) : void { }
            private function refreshView() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}