package gradeAwardsBoxBtn.view{   import bagAndInfo.cell.BagCell;   import com.greensock.TweenMax;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import ddt.data.goods.InventoryItemInfo;   import ddt.view.MainToolBar;   import flash.geom.Point;   import flash.utils.setTimeout;      public class GradeAwardsFlyIntoBagView   {            private static var totalCellFlying:int;            private static var tooMuch:Boolean = false;                   public function GradeAwardsFlyIntoBagView() { super(); }
            public function onFrameClose(infos:Array) : void { }
            private function notTooMuchNow() : void { }
            private function onFlyStart(tag:BagCell) : void { }
            private function onGoodsIconFlied(tag:BagCell) : void { }
   }}