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
       
      
      public function ArmShellItemCell(param1:Array, param2:int)
      {
         super(param1,param2);
      }
      
      override public function dragStart() : void
      {
      }
      
      override public function dragStop(param1:DragEffect) : void
      {
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
      }
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
         if(!DoubleClickEnabled)
         {
            return;
         }
         if(info == null)
         {
            return;
         }
         if((param1.currentTarget as BagCell).info != null)
         {
            SocketManager.Instance.out.sendMoveGoods(0,index,itemBagType,-1);
            if(!mouseSilenced)
            {
               SoundManager.instance.play("008");
            }
         }
      }
   }
}
