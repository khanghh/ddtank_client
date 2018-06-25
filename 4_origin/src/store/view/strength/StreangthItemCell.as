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
      
      public function StreangthItemCell($index:int)
      {
         var bg:Sprite = new Sprite();
         var bgBit:Bitmap = ComponentFactory.Instance.creatBitmap("asset.ddtstore.EquipCellBG");
         bg.addChild(bgBit);
         super(bg,$index);
         setContentSize(68,68);
         this.PicPos = new Point(-3,-3);
      }
      
      public function set stoneType(value:String) : void
      {
         _stoneType = value;
      }
      
      public function set actionState(value:Boolean) : void
      {
         _actionState = value;
      }
      
      public function get actionState() : Boolean
      {
         return _actionState;
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var info:InventoryItemInfo = effect.data as InventoryItemInfo;
         if(info && effect.action != "split")
         {
            effect.action = "none";
            if(info.getRemainDate() <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.AccessoryDragInArea.overdue"));
            }
            else if(info.CanStrengthen && isAdaptToStone(info))
            {
               if(info.StrengthenLevel >= PathManager.solveStrengthMax())
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.StrengthItemCell.up"));
                  return;
               }
               SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,12,index,1);
               _actionState = true;
               effect.action = "none";
               DragManager.acceptDrag(this);
               reset();
            }
            else if(isAdaptToStone(info))
            {
            }
         }
      }
      
      protected function isAdaptToStone(info:InventoryItemInfo) : Boolean
      {
         if(_stoneType == "")
         {
            return true;
         }
         if(_stoneType == "2" && info.RefineryLevel <= 0)
         {
            return true;
         }
         if(_stoneType == "35" && info.RefineryLevel > 0)
         {
            return true;
         }
         return false;
      }
      
      protected function reset() : void
      {
         _stoneType = "";
      }
      
      override public function set info(value:ItemTemplateInfo) : void
      {
         if(_info == value && !_info)
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
         _info = value;
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
