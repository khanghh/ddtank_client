package horse.amulet{   import bagAndInfo.cell.DragEffect;   import baglocked.BaglockedManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import ddt.interfaces.IDragable;   import ddt.manager.DragManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.events.MouseEvent;      public class HorseAmuletSmashButton extends SimpleBitmapButton implements IDragable   {                   public function HorseAmuletSmashButton() { super(); }
            override protected function __onMouseClick(event:MouseEvent) : void { }
            public function dragStart(stageX:Number, stageY:Number) : void { }
            public function getSource() : IDragable { return null; }
            public function dragStop(effect:DragEffect) : void { }
   }}