package bagAndInfo.cell{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.DoubleClickManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.CellEvent;   import ddt.manager.DragManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import ddt.view.tips.GoodTipInfo;   import flash.display.MovieClip;   import flash.events.MouseEvent;   import flash.geom.Point;   import gemstone.info.GemstoneInfo;   import petsBag.PetsBagManager;      public class PersonalInfoCell extends BagCell   {                   public var gemstoneList:Vector.<GemstoneInfo>;            private var _isGemstone:Boolean = false;            private var _shineObject:MovieClip;            public function PersonalInfoCell(index:int = 0, info:ItemTemplateInfo = null, showLoading:Boolean = true) { super(null,null,null); }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            override public function set info(value:ItemTemplateInfo) : void { }
            override public function dragStart() : void { }
            override protected function onMouseOver(evt:MouseEvent) : void { }
            override protected function onMouseClick(evt:MouseEvent) : void { }
            protected function onClick(evt:InteractiveEvent) : void { }
            protected function onDoubleClick(evt:InteractiveEvent) : void { }
            override public function dragDrop(effect:DragEffect) : void { }
            override protected function createLoading() : void { }
            override public function checkOverDate() : void { }
            private function __onResponse(evt:FrameEvent) : void { }
            private function __onBindResponse(evt:FrameEvent) : void { }
            private function sendDefy() : void { }
            private function sendBindDefy() : void { }
            private function getCellIndex(info:ItemTemplateInfo) : Array { return null; }
            override public function dragStop(effect:DragEffect) : void { }
            public function shine() : void { }
            public function stopShine() : void { }
            override public function updateCount() : void { }
            override public function dispose() : void { }
   }}