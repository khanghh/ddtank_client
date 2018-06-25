package bagAndInfo.bag{   import bagAndInfo.cell.BagCell;   import bagAndInfo.cell.DragEffect;   import baglocked.BaglockedManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.TextButton;   import ddt.data.EquipType;   import ddt.interfaces.ICell;   import ddt.interfaces.IDragable;   import ddt.manager.DragManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.events.Event;   import flash.filters.ColorMatrixFilter;      public class SellGoodsBtn extends TextButton implements IDragable   {            public static const StopSell:String = "stopsell";                   public var isActive:Boolean = false;            private var sellFrame:SellGoodsFrame;            private var lightingFilter:ColorMatrixFilter;            private var _dragTarget:BagCell;            public function SellGoodsBtn() { super(); }
            override protected function init() : void { }
            public function dragStart(stageX:Number, stageY:Number) : void { }
            public function dragStop(effect:DragEffect) : void { }
            private function showSellFrame() : void { }
            public function getSource() : IDragable { return null; }
            public function getDragData() : Object { return null; }
            private function confirmBack(event:Event) : void { }
            private function setUpLintingFilter() : void { }
            override public function dispose() : void { }
            private function __disposeSellFrame() : void { }
            private function cancelBack(event:Event) : void { }
   }}