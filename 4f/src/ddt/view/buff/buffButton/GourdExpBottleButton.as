package ddt.view.buff.buffButton{   import com.pickgliss.ui.LayerManager;   import ddt.data.BuffInfo;   import ddt.data.GourdExpBottleInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.utils.PositionUtils;   import flash.events.MouseEvent;   import flash.geom.Point;   import trainer.view.NewHandContainer;      public class GourdExpBottleButton extends BuffButton   {                   private var _helpViewShow:Boolean = true;            private var _gourdHelpTipView:GourdHelpTipView;            private var _gourdInfo:GourdExpBottleInfo;            public function GourdExpBottleButton() { super(null); }
            public function get gourdInfo() : GourdExpBottleInfo { return null; }
            public function set gourdInfo(value:GourdExpBottleInfo) : void { }
            private function initView() : void { }
            private function updataButton() : void { }
            override protected function __onclick(event:MouseEvent) : void { }
            protected function __closeChairChnnel(event:MouseEvent) : void { }
            override public function dispose() : void { }
   }}