package drgnBoatBuild.views{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import drgnBoatBuild.DrgnBoatBuildControl;   import flash.display.DisplayObject;   import flash.events.MouseEvent;   import store.HelpFrame;      public class DrgnBoatBuildFrame extends Frame   {                   private var _bg:ScaleBitmapImage;            private var _leftView:DrgnBoatBuildLeftView;            private var _rightView:DrgnBoatBuildRightView;            private var _helpBtn:SimpleBitmapButton;            public function DrgnBoatBuildFrame() { super(); }
            private function initView() : void { }
            private function initEvents() : void { }
            protected function __helpBtnClick(event:MouseEvent) : void { }
            private function __frameEventHandler(event:FrameEvent) : void { }
            private function removeEvents() : void { }
            override public function dispose() : void { }
   }}