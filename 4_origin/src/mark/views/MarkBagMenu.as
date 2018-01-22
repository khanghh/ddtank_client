package mark.views
{
   import baglocked.BaglockedManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PlayerManager;
   import flash.events.MouseEvent;
   import mark.MarkMgr;
   import mark.mornUI.views.MarkBagMenuUI;
   import morn.core.handlers.Handler;
   
   public class MarkBagMenu extends MarkBagMenuUI
   {
       
      
      private var _id:int = -1;
      
      public function MarkBagMenu(param1:int)
      {
         _id = param1;
         super();
      }
      
      override protected function initialize() : void
      {
         addMask();
         btnHammer.clickHandler = new Handler(hammer);
         btnSell.clickHandler = new Handler(sell);
         btnWear.clickHandler = new Handler(wear);
      }
      
      private function hammer() : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            dispose();
            return;
         }
         MarkMgr.inst.model.chipItemID = _id;
         MarkMgr.inst.showMarkMainFrame();
         dispose();
      }
      
      private function sell() : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            dispose();
            return;
         }
         MarkMgr.inst.model.sellList.push(_id);
         MarkMgr.inst.submitSell();
         dispose();
      }
      
      private function wear() : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            dispose();
            return;
         }
         MarkMgr.inst.moveChip(_id);
         dispose();
      }
      
      private function addMask() : void
      {
         graphics.beginFill(0,0);
         graphics.drawRect(-3000,-3000,6000,6000);
         graphics.endFill();
         addEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _id = 0;
         removeEventListener("click",clickHandler);
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
