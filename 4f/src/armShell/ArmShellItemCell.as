package armShell
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import com.pickgliss.events.InteractiveEvent;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import store.StoneCell;
   
   public class ArmShellItemCell extends StoneCell
   {
       
      
      public function ArmShellItemCell(param1:Array, param2:int){super(null,null);}
      
      override public function dragStart() : void{}
      
      override public function dragStop(param1:DragEffect) : void{}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void{}
   }
}
