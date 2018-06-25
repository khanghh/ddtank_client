package tofflist.view{   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.utils.PositionUtils;   import ddt.view.MainToolBar;   import flash.display.Sprite;   import tofflist.TofflistController;   import tofflist.TofflistEvent;   import tofflist.TofflistModel;      public class TofflistView extends Sprite implements Disposeable   {                   private var _contro:TofflistController;            private var _leftView:TofflistLeftView;            private var _rightView:TofflistRightView;            public function TofflistView($contro:TofflistController) { super(); }
            public function get rightView() : TofflistRightView { return null; }
            public function addEvent() : void { }
            public function dispose() : void { }
            public function removeEvent() : void { }
            private function __crossServerTofflistDataChange(evt:TofflistEvent) : void { }
            private function __tofflistDataChange(evt:TofflistEvent) : void { }
            public function clearDisplayContent() : void { }
            private function init() : void { }
   }}