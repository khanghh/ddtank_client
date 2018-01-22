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
      
      public function createBagCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null) : ICell
      {
         var _loc5_:BagCell = new BagCell(param1,param2,param3,param4);
         fillTipProp(_loc5_);
         return _loc5_;
      }
      
      public function creteLockableBagCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null) : ICell
      {
         var _loc5_:LockableBagCell = new LockableBagCell(param1,param2,param3,param4);
         fillTipProp(_loc5_);
         return _loc5_;
      }
      
      public function createBankCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true) : ICell
      {
         var _loc4_:BankCell = new BankCell(param1,param2,param3);
         fillTipProp(_loc4_);
         return _loc4_;
      }
      
      public function createPersonalInfoCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true) : ICell
      {
         var _loc4_:BagCell = new PersonalInfoCell(param1,param2,param3);
         fillTipProp(_loc4_);
         return _loc4_;
      }
      
      public function createTreasureCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true) : ICell
      {
         var _loc4_:MagicHouseTreasureCell = new MagicHouseTreasureCell(param1,param2,param3);
         fillTipProp(_loc4_);
         return _loc4_;
      }
      
      public function createBeadCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true) : ICell
      {
         var _loc4_:BeadCell = new BeadCell(param1,param2,param3);
         fillTipProp(_loc4_);
         return _loc4_;
      }
      
      public function createShopPlayerItemCell() : ICell
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,45,45);
         _loc1_.graphics.endFill();
         var _loc2_:ShopPlayerCell = new ShopPlayerCell(_loc1_);
         fillTipProp(_loc2_);
         return _loc2_;
      }
      
      public function createShopCartItemCell() : ICell
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,64,64);
         _loc1_.graphics.endFill();
         var _loc2_:ShopPlayerCell = new ShopPlayerCell(_loc1_);
         fillTipProp(_loc2_);
         return _loc2_;
      }
      
      public function createShopColorItemCell() : ICell
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,90,90);
         _loc1_.graphics.endFill();
         var _loc2_:ShopPlayerCell = new ShopPlayerCell(_loc1_);
         fillTipProp(_loc2_);
         return _loc2_;
      }
      
      public function createShopItemCell(param1:DisplayObject, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:Boolean = true) : ICell
      {
         var _loc5_:ShopItemCell = new ShopItemCell(param1,param2,param3,param4);
         fillTipProp(_loc5_);
         return _loc5_;
      }
      
      public function fillTipProp(param1:ICell) : void
      {
         param1.tipDirctions = "7,6,2,1,5,4,0,3,6";
         param1.tipGapV = 10;
         param1.tipGapH = 10;
         param1.tipStyle = "core.GoodsTip";
      }
      
      public function createWeeklyItemCell(param1:DisplayObject, param2:int) : ICell
      {
         var _loc3_:* = null;
         var _loc5_:* = ShopManager.Instance.getShopItemByGoodsID(param2);
         if(!_loc5_)
         {
            _loc5_ = ItemManager.Instance.getTemplateById(param2);
         }
         var _loc4_:ShopPlayerCell = new ShopPlayerCell(param1);
         if(_loc5_ is ItemTemplateInfo)
         {
            _loc4_.info = _loc5_;
         }
         if(_loc5_ is ShopItemInfo)
         {
            _loc3_ = new ShopCarItemInfo(_loc5_.GoodsID,_loc5_.TemplateID);
            ObjectUtils.copyProperties(_loc3_,_loc5_);
            _loc4_.shopItemInfo = _loc3_;
         }
         ShowTipManager.Instance.removeTip(_loc4_);
         return _loc4_;
      }
   }
}
