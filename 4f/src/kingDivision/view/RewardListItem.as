package kingDivision.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;      public class RewardListItem extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _topThreeRink:ScaleFrameImage;            private var _index:int;            private var _goodsList:RewardGoodsList;            private var _leftBtn:BaseButton;            private var _rightBtn:BaseButton;            private var _panel:ScrollPanel;            private var _select:int;            private var _zoneIndex:int;            public function RewardListItem(index:int, zoneIndex:int) { super(); }
            private function initView() : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            private function setRink() : void { }
            private function __onClickLeftBtn(evt:MouseEvent) : void { }
            private function __onClickRightBtn(evt:MouseEvent) : void { }
            private function __enterFrame(evt:Event) : void { }
            private function __onMouseUpBtn(evt:MouseEvent) : void { }
            public function dispose() : void { }
   }}