package armShell{   import bagAndInfo.cell.BagCell;   import bagAndInfo.cell.DragEffect;   import com.pickgliss.events.InteractiveEvent;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import store.StoneCell;      public class ArmShellItemCell extends StoneCell   {                   public function ArmShellItemCell(stoneType:Array, $index:int) { super(null,null); }
            override public function dragStart() : void { }
            override public function dragStop(effect:DragEffect) : void { }
            override public function dragDrop(effect:DragEffect) : void { }
            override protected function __doubleClickHandler(evt:InteractiveEvent) : void { }
   }}