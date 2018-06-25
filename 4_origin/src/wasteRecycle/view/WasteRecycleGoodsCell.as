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
       
      
      public function WasteRecycleGoodsCell(bg:Sprite)
      {
         super(0,null,true,bg);
         this.addEventListener("interactive_click",__clickHandler);
         this.addEventListener("interactive_double_click",__doubleClickHandler);
         this.addEventListener("lockChanged",__cellChanged);
         DoubleClickManager.Instance.enableDoubleClick(this);
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
         var info:* = null;
         var frame:* = null;
         if(effect.action == "move" && effect.source is WasteRecycleCell)
         {
            info = effect.data as InventoryItemInfo;
            if(info)
            {
               frame = ComponentFactory.Instance.creatComponentByStylename("wasteRecycel.selectedFrame");
               frame.show(effect.source as WasteRecycleCell);
            }
            else
            {
               effect.action = "none";
            }
         }
         else
         {
            effect.action = "none";
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.wasteRecycle.notMove"));
         }
         DragManager.acceptDrag(this);
      }
      
      protected function __clickHandler(evt:InteractiveEvent) : void
      {
         this.dragStart();
      }
      
      override public function dragStop(effect:DragEffect) : void
      {
         SoundManager.instance.playButtonSound();
         if(effect.target == null)
         {
            if(effect.action == "move")
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.wasteRecycle.notMove"));
            }
            locked = false;
         }
      }
      
      protected function __doubleClickHandler(evt:InteractiveEvent) : void
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
      
      protected function __cellChanged(event:Event) : void
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
