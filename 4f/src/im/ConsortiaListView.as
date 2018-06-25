package im{   import com.pickgliss.events.ListItemEvent;   import com.pickgliss.geom.IntPoint;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ListPanel;   import com.pickgliss.ui.core.Disposeable;   import consortion.ConsortionModelManager;   import consortion.event.ConsortionEvent;   import ddt.data.player.ConsortiaPlayerInfo;   import ddt.manager.SoundManager;   import flash.display.Sprite;      public class ConsortiaListView extends Sprite implements Disposeable   {                   private var _list:ListPanel;            private var _consortiaPlayerArray:Array;            private var _consortiaInfoArray:Array;            private var _currentItem:ConsortiaPlayerInfo;            private var _currentTitle:ConsortiaPlayerInfo;            private var _pos:int;            public function ConsortiaListView() { super(); }
            public function get consortiaInfoArray() : Array { return null; }
            private function init() : void { }
            private function __updateList(event:ConsortionEvent) : void { }
            private function __itemClick(event:ListItemEvent) : void { }
            private function updateList() : void { }
            private function update() : void { }
            public function dispose() : void { }
   }}