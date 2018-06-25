package tofflist.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import tofflist.TofflistController;   import tofflist.TofflistEvent;   import tofflist.TofflistModel;      public class TofflistRightView extends Sprite implements Disposeable   {                   private var _contro:TofflistController;            private var _currentData:Array;            private var _currentPage:int;            private var _gridBox:TofflistGridBox;            private var _pageTxt:FilterFrameText;            private var _pgdn:BaseButton;            private var _pgup:BaseButton;            private var _stairMenu:TofflistStairMenu;            private var _thirdClassMenu:TofflistThirdClassMenu;            private var _totalPage:int;            private var _twoGradeMenu:TofflistTwoGradeMenu;            private var _leftInfo:TofflistLeftInfoView;            private var _upDownTextBg:Image;            private var _bg:MutipleImage;            public function TofflistRightView($contro:TofflistController) { super(); }
            public function get gridBox() : TofflistGridBox { return null; }
            public function dispose() : void { }
            public function updateTime(timeStr:String) : void { }
            public function get firstType() : String { return null; }
            public function orderList($list:Array) : void { }
            public function get twoGradeType() : String { return null; }
            private function __addToStageHandler(evt:Event) : void { }
            private function __menuTypeHandler(evt:TofflistEvent) : void { }
            private function __pgdnHandler(evt:MouseEvent) : void { }
            private function __pgupHandler(evt:MouseEvent) : void { }
            private function __searchOrderHandler(evt:TofflistEvent) : void { }
            private function __selectChildBarHandler(evt:TofflistEvent) : void { }
            private function __selectStairMenuHandler(evt:TofflistEvent) : void { }
            private function addEvent() : void { }
            private function checkPageBtn() : void { }
            private function init() : void { }
            private function removeEvent() : void { }
   }}