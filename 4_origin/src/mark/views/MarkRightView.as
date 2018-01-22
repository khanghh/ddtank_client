package mark.views
{
   import com.pickgliss.utils.ObjectUtils;
   import mark.MarkMgr;
   import mark.data.MarkBagData;
   import mark.event.MarkEvent;
   import mark.items.MarkSuitItem;
   import mark.mornUI.views.MarkRightViewUI;
   import morn.core.handlers.Handler;
   
   public class MarkRightView extends MarkRightViewUI
   {
       
      
      private var _bag:MarkBagView = null;
      
      private var _bagId:int = -1;
      
      public function MarkRightView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         listBags.renderHandler = new Handler(render);
         listBags.selectHandler = new Handler(select);
         initEvent();
         updateChips();
      }
      
      private function render(param1:MarkSuitItem, param2:int) : void
      {
         param1.data = listBags.array[param2];
      }
      
      private function select(param1:int) : void
      {
         if(!_bag)
         {
            _bag = new MarkBagView();
         }
         var _loc2_:MarkBagData = listBags.array[param1];
         _bag.data = _loc2_;
         if(listBags.array[param1].chips.length > 0)
         {
            _bag.listBag.scrollTo(0);
         }
         _bagId = listBags.array[param1].type;
         _bag.visible = true;
         addChild(_bag);
         MarkMgr.inst.reqOperationStatus(0,_loc2_.type);
      }
      
      private function initEvent() : void
      {
         MarkMgr.inst.addEventListener("remove_view",disposeView);
         MarkMgr.inst.addEventListener("updateChips",updateChips);
         MarkMgr.inst.addEventListener("putOnChip",updateChips);
         MarkMgr.inst.addEventListener("putOffChip",updateChips);
         MarkMgr.inst.addEventListener("updateOperation",updateChips);
      }
      
      private function removeEvent() : void
      {
         MarkMgr.inst.removeEventListener("remove_view",disposeView);
         MarkMgr.inst.removeEventListener("updateChips",updateChips);
         MarkMgr.inst.removeEventListener("putOnChip",updateChips);
         MarkMgr.inst.removeEventListener("putOffChip",updateChips);
         MarkMgr.inst.removeEventListener("updateOperation",updateChips);
      }
      
      private function updateStatus() : void
      {
         var _loc2_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = MarkMgr.inst.model.bags;
         for each(var _loc1_ in MarkMgr.inst.model.bags)
         {
            if(_loc1_.type > 1000)
            {
               _loc2_.push(_loc1_);
            }
         }
         listBags.array = _loc2_;
         if(listBags.array != null && listBags.array.length > 0)
         {
            listBags.repeatY = _loc2_.length;
         }
      }
      
      private function updateChips(param1:MarkEvent = null) : void
      {
         updateStatus();
         if(_bag)
         {
            _bag.data = MarkMgr.inst.model.bags[_bagId];
         }
      }
      
      private function disposeView(param1:MarkEvent) : void
      {
         dispose();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_bag)
         {
            _bag.dispose();
            _bag = null;
         }
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
