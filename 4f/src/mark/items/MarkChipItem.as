package mark.items{   import bagAndInfo.cell.BaseCell;   import baglocked.BaglockedManager;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.DoubleClickManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.ItemManager;   import ddt.manager.PlayerManager;   import ddt.utils.PositionUtils;   import flash.display.MovieClip;   import flash.display.Shape;   import flash.display.Sprite;   import flash.geom.Point;   import mark.MarkMgr;   import mark.data.MarkChipData;   import mark.data.MarkChipTemplateData;   import mark.mornUI.items.MarkChipItemUI;   import mark.views.MarkChipMenu;   import morn.core.components.Box;   import morn.core.components.Clip;      public class MarkChipItem extends MarkChipItemUI   {                   private var _chip:MarkChipData = null;            private var _cell:BaseCell = null;            private var _active:Boolean = true;            private var _effect:MovieClip = null;            private var _effectContainer:Sprite = null;            public function MarkChipItem(chip:MarkChipData) { super(); }
            override protected function initialize() : void { }
            protected function doubleClickHandler(e:InteractiveEvent) : void { }
            private function clickHander(evt:InteractiveEvent) : void { }
            public function set interactive(value:Boolean) : void { }
            public function playSuitEffect() : void { }
            public function stopSuitEffect() : void { }
            public function get id() : int { return 0; }
            override public function dispose() : void { }
   }}