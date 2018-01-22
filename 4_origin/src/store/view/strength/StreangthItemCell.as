package store.view.strength
{
   import bagAndInfo.cell.CellContentCreator;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import store.StoreCell;
   
   public class StreangthItemCell extends StoreCell
   {
       
      
      protected var _stoneType:String = "";
      
      protected var _actionState:Boolean;
      
      public function StreangthItemCell(param1:int)
      {
         var _loc2_:Sprite = new Sprite();
         var _loc3_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtstore.EquipCellBG");
         _loc2_.addChild(_loc3_);
         super(_loc2_,param1);
         setContentSize(68,68);
         this.PicPos = new Point(-3,-3);
      }
      
      public function set stoneType(param1:String) : void
      {
         _stoneType = param1;
      }
      
      public function set actionState(param1:Boolean) : void
      {
         _actionState = param1;
      }
      
      public function get actionState() : Boolean
      {
         return _actionState;
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
               if(_loc2_.StrengthenLevel >= PathManager.solveStrengthMax())
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.StrengthItemCell.up"));
                  return;
               }
               SocketManager.Instance.out.sendMoveGoods(_loc2_.BagType,_loc2_.Place,12,index,1);
               _actionState = true;
               param1.action = "none";
               DragManager.acceptDrag(this);
               reset();
            }
            else if(isAdaptToStone(_loc2_))
            {
            }
         }
      }
      
      protected function isAdaptToStone(param1:InventoryItemInfo) : Boolean
      {
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
      
      protected function reset() : void
      {
         _stoneType = "";
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
               tipStyle = "ddtstore.StrengthTips";
               _tipData = new GoodTipInfo();
               GoodTipInfo(_tipData).itemInfo = info;
            }
         }
         dispatchEvent(new Event("change"));
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
