package ddt.view.buff.buffButton{   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.container.VBox;   import ddt.data.BuffInfo;   import ddt.manager.LanguageMgr;   import ddt.utils.PositionUtils;   import flash.events.MouseEvent;   import flash.geom.Point;      public class LabyrinthBuffButton extends BuffButton   {                   private var _labyrinthBuffTipView:LabyrinthBuffTipView;            private var _helpViewShow:Boolean = false;            public function LabyrinthBuffButton() { super(null); }
            private function initView() : void { }
            override protected function __onclick(event:MouseEvent) : void { }
            protected function __closeChairChnnel(event:MouseEvent) : void { }
            private function checkIsVBoxChild(target:*, buffItemVBox:VBox) : Boolean { return false; }
            override public function dispose() : void { }
   }}