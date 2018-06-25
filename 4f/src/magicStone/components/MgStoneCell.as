package magicStone.components{   import bagAndInfo.cell.BagCell;   import bagAndInfo.cell.DragEffect;   import baglocked.BaglockedManager;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.DoubleClickManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.CellEvent;   import ddt.manager.DragManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.events.MouseEvent;   import flash.geom.Point;      public class MgStoneCell extends BagCell   {                   private var _lockIcon:Bitmap;            protected var _nameTxt:FilterFrameText;            public function MgStoneCell(index:int = 0, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null) { super(null,null,null,null); }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            override protected function onMouseOver(evt:MouseEvent) : void { }
            override protected function onMouseClick(evt:MouseEvent) : void { }
            protected function onClick(evt:InteractiveEvent) : void { }
            protected function onDoubleClick(evt:InteractiveEvent) : void { }
            override public function dragStart() : void { }
            override public function dragDrop(effect:DragEffect) : void { }
            override public function dragStop(effect:DragEffect) : void { }
            private function dragHidePicTxt() : void { }
            private function dragShowPicTxt() : void { }
            public function lockMgStone() : void { }
            override public function set info(value:ItemTemplateInfo) : void { }
            override protected function createLoading() : void { }
            override public function dispose() : void { }
   }}