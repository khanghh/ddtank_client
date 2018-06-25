package beadSystem.controls{   import bagAndInfo.cell.DragEffect;   import baglocked.BaglockedManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.cell.ICell;   import ddt.interfaces.IDragable;   import ddt.manager.DragManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.events.Event;   import flash.events.MouseEvent;      public class BeadFeedButton extends SimpleBitmapButton implements IDragable   {            public static const stopFeed:String = "stopfeed";                   public var isActive:Boolean = false;            public function BeadFeedButton() { super(); }
            private function addEvt() : void { }
            private function removeEvt() : void { }
            private function clickthis(e:MouseEvent) : void { }
            override protected function init() : void { }
            public function dragAgain() : void { }
            public function dragStop(effect:DragEffect) : void { }
            public function dragStart(stageX:Number, stageY:Number) : void { }
            public function getSource() : IDragable { return null; }
   }}