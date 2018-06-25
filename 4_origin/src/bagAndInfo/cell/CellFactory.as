package bagAndInfo.cell
{
   import beadSystem.controls.BeadCell;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.interfaces.ICell;
   import ddt.interfaces.ICellFactory;
   import ddt.manager.ItemManager;
   import ddt.manager.ShopManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import magicHouse.treasureHouse.MagicHouseTreasureCell;
   import shop.view.ShopItemCell;
   import shop.view.ShopPlayerCell;
   
   public class CellFactory implements ICellFactory
   {
      
      private static var _instance:CellFactory;
       
      
      public function CellFactory()
      {
         super();
      }
      
      public static function get instance() : CellFactory
      {
         if(_instance == null)
         {
            _instance = new CellFactory();
         }
         return _instance;
      }
      
      public function createBagCell(place:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null) : ICell
      {
         var cell:BagCell = new BagCell(place,info,showLoading,bg);
         fillTipProp(cell);
         return cell;
      }
      
      public function creteLockableBagCell(place:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null) : ICell
      {
         var cell:LockableBagCell = new LockableBagCell(place,info,showLoading,bg);
         fillTipProp(cell);
         return cell;
      }
      
      public function createBankCell(place:int, info:ItemTemplateInfo = null, showLoading:Boolean = true) : ICell
      {
         var cell:BankCell = new BankCell(place,info,showLoading);
         fillTipProp(cell);
         return cell;
      }
      
      public function createPersonalInfoCell(place:int, info:ItemTemplateInfo = null, showLoading:Boolean = true) : ICell
      {
         var cell:BagCell = new PersonalInfoCell(place,info,showLoading);
         fillTipProp(cell);
         return cell;
      }
      
      public function createTreasureCell(place:int, info:ItemTemplateInfo = null, showLoading:Boolean = true) : ICell
      {
         var cell:MagicHouseTreasureCell = new MagicHouseTreasureCell(place,info,showLoading);
         fillTipProp(cell);
         return cell;
      }
      
      public function createBeadCell(place:int, info:ItemTemplateInfo = null, showLoading:Boolean = true) : ICell
      {
         var cell:BeadCell = new BeadCell(place,info,showLoading);
         fillTipProp(cell);
         return cell;
      }
      
      public function createShopPlayerItemCell() : ICell
      {
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,45,45);
         sp.graphics.endFill();
         var cell:ShopPlayerCell = new ShopPlayerCell(sp);
         fillTipProp(cell);
         return cell;
      }
      
      public function createShopCartItemCell() : ICell
      {
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,64,64);
         sp.graphics.endFill();
         var cell:ShopPlayerCell = new ShopPlayerCell(sp);
         fillTipProp(cell);
         return cell;
      }
      
      public function createShopColorItemCell() : ICell
      {
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,90,90);
         sp.graphics.endFill();
         var cell:ShopPlayerCell = new ShopPlayerCell(sp);
         fillTipProp(cell);
         return cell;
      }
      
      public function createShopItemCell(bg:DisplayObject, info:ItemTemplateInfo = null, showLoading:Boolean = true, showTip:Boolean = true) : ICell
      {
         var cell:ShopItemCell = new ShopItemCell(bg,info,showLoading,showTip);
         fillTipProp(cell);
         return cell;
      }
      
      public function fillTipProp(cell:ICell) : void
      {
         cell.tipDirctions = "7,6,2,1,5,4,0,3,6";
         cell.tipGapV = 10;
         cell.tipGapH = 10;
         cell.tipStyle = "core.GoodsTip";
      }
      
      public function createWeeklyItemCell(placeHolder:DisplayObject, templateID:int) : ICell
      {
         var t:* = null;
         var info:* = ShopManager.Instance.getShopItemByGoodsID(templateID);
         if(!info)
         {
            info = ItemManager.Instance.getTemplateById(templateID);
         }
         var cell:ShopPlayerCell = new ShopPlayerCell(placeHolder);
         if(info is ItemTemplateInfo)
         {
            cell.info = info;
         }
         if(info is ShopItemInfo)
         {
            t = new ShopCarItemInfo(info.GoodsID,info.TemplateID);
            ObjectUtils.copyProperties(t,info);
            cell.shopItemInfo = t;
         }
         ShowTipManager.Instance.removeTip(cell);
         return cell;
      }
   }
}
