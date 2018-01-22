package store.view.exalt
{
   import bagAndInfo.cell.CellContentCreator;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.view.tips.GoodTipInfo;
   import flash.events.Event;
   import store.view.strength.StreangthItemCell;
   
   public class ExaltItemCell extends StreangthItemCell
   {
       
      
      public function ExaltItemCell(param1:int)
      {
         super(param1);
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:InventoryItemInfo = param1.data as InventoryItemInfo;
         if(_loc2_ && param1.action != "split")
         {
            param1.action = "none";
            if(_loc2_.getRemainDate() <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.AccessoryDragInArea.overdue"));
            }
            else if(_loc2_.CanStrengthen && isAdaptToStone(_loc2_))
            {
               SocketManager.Instance.out.sendMoveGoods(_loc2_.BagType,_loc2_.Place,12,index,1);
               _actionState = true;
               param1.action = "none";
               DragManager.acceptDrag(this);
               reset();
            }
         }
      }
      
      override protected function isAdaptToStone(param1:InventoryItemInfo) : Boolean
      {
         if(param1.StrengthenLevel >= 15)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.exalt.warningI"));
            return false;
         }
         if(_stoneType == "")
         {
            return true;
         }
         if(_stoneType == "2" && param1.RefineryLevel <= 0)
         {
            return true;
         }
         if(_stoneType == "35" && param1.RefineryLevel > 0)
         {
            return true;
         }
         return false;
      }
      
      override public function set info(param1:ItemTemplateInfo) : void
      {
         if(_info == param1 && !_info)
         {
            return;
         }
         if(_info)
         {
            clearCreatingContent();
            ObjectUtils.disposeObject(_pic);
            _pic = null;
            clearLoading();
            _tipData = null;
            locked = false;
         }
         _info = param1;
         if(_info)
         {
            if(_showLoading)
            {
               createLoading();
            }
            _pic = new CellContentCreator();
            _pic.info = _info;
            _pic.loadSync(createContentComplete);
            addChild(_pic);
            if(_info.CategoryID != 26)
            {
               tipStyle = "ddtstore.ExaltTips";
               _tipData = new GoodTipInfo();
               GoodTipInfo(_tipData).itemInfo = info;
            }
         }
         dispatchEvent(new Event("change"));
      }
   }
}
