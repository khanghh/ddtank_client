package gradeAwardsBoxBtn.view{   import bagAndInfo.cell.BagCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MovieImage;   import com.pickgliss.ui.image.ScaleLeftRightImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import gradeAwardsBoxBtn.ui.GradeAwardsBoxBitmapTitle;   import hall.HallStateView;      public class GradeAwardsBoxSprite extends Sprite implements Disposeable   {            private static var instance:GradeAwardsBoxSprite;                   private var _gradeAwardsBoxBtn:MovieImage;            private var _gradeBottomTimeTips:FilterFrameText;            private var _gradeBG:ScaleLeftRightImage;            private var _gradeBD:GradeAwardsBoxBitmapTitle;            private var _gradeAwardsItem:BagCell;            private var _isVisible:Boolean = false;            private var _hall:HallStateView;            public function GradeAwardsBoxSprite(single:inner) { super(); }
            public static function getInstance() : GradeAwardsBoxSprite { return null; }
            private function init() : void { }
            public function updateText($text:String) : void { }
            public function show(info:InventoryItemInfo, shining:Boolean) : void { }
            public function hide() : void { }
            public function dispose() : void { }
            public function setHall(value:HallStateView) : void { }
            public function get isVisible() : Boolean { return false; }
   }}class inner{          function inner() { super(); }
}