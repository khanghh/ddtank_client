package magicStone.components{   import bagAndInfo.cell.DragEffect;   import baglocked.BaglockedManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import ddt.interfaces.IDragable;   import ddt.manager.DragManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.events.MouseEvent;   import flash.utils.setTimeout;      public class MgStoneLockBtn extends SimpleBitmapButton implements IDragable   {                   public function MgStoneLockBtn() { super(); }
            private function addEvt() : void { }
            private function removeEvt() : void { }
            private function clickthis(e:MouseEvent) : void { }
            public function getSource() : IDragable { return null; }
            public function dragStop(effect:DragEffect) : void { }
            private function continueDrag() : void { }
            public function dragStart(stageX:Number, stageY:Number) : void { }
            override public function get width() : Number { return 0; }
            override public function get height() : Number { return 0; }
   }}