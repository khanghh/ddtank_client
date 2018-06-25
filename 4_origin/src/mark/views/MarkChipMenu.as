package mark.views
{
   import baglocked.BaglockedManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PlayerManager;
   import flash.events.MouseEvent;
   import mark.MarkMgr;
   import mark.mornUI.views.MarkChipMenuUI;
   import morn.core.handlers.Handler;
   
   public class MarkChipMenu extends MarkChipMenuUI
   {
       
      
      private var _id:int = -1;
      
      public function MarkChipMenu(id:int)
      {
         _id = id;
         super();
      }
      
      override protected function initialize() : void
      {
         addMask();
         btnHammer.clickHandler = new Handler(hammer);
         btnUnlock.clickHandler = new Handler(unlock);
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
      
      private function unlock() : void
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
      
      private function clickHandler(evt:MouseEvent) : void
      {
         dispose();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEventListener("click",clickHandler);
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
