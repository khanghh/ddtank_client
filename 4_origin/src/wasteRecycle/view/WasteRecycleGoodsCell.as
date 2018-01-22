package wasteRecycle.view
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class WasteRecycleGoodsCell extends BagCell
   {
       
      
      public function WasteRecycleGoodsCell(param1:Sprite)
      {
         super(0,null,true,param1);
         this.addEventListener("interactive_click",__clickHandler);
         this.addEventListener("interactive_double_click",__doubleClickHandler);
         this.addEventListener("lockChanged",__cellChanged);
         DoubleClickManager.Instance.enableDoubleClick(this);
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(param1.action == "move" && param1.source is WasteRecycleCell)
         {
            _loc3_ = param1.data as InventoryItemInfo;
            if(_loc3_)
            {
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("wasteRecycel.selectedFrame");
               _loc2_.show(param1.source as WasteRecycleCell);
            }
            else
            {
               param1.action = "none";
            }
         }
         else
         {
            param1.action = "none";
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.wasteRecycle.notMove"));
         }
         DragManager.acceptDrag(this);
      }
      
      protected function __clickHandler(param1:InteractiveEvent) : void
      {
         this.dragStart();
      }
      
      override public function dragStop(param1:DragEffect) : void
      {
         SoundManager.instance.playButtonSound();
         if(param1.target == null)
         {
            if(param1.action == "move")
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.wasteRecycle.notMove"));
            }
            locked = false;
         }
      }
      
      protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
         if(_info)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            SoundManager.instance.playButtonSound();
            SocketManager.Instance.out.sendClearStoreBag();
         }
      }
      
      override public function dragStart() : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         SoundManager.instance.playButtonSound();
         super.dragStart();
      }
      
      protected function __cellChanged(param1:Event) : void
      {
         dispatchEvent(new Event("change"));
      }
      
      override public function dispose() : void
      {
         this.removeEventListener("interactive_click",__clickHandler);
         this.removeEventListener("interactive_double_click",__doubleClickHandler);
         this.removeEventListener("lockChanged",__cellChanged);
         DoubleClickManager.Instance.disableDoubleClick(this);
         super.dispose();
      }
   }
}
