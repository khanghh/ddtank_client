package prayIndiana.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import prayIndiana.PrayIndianaManager;
   
   public class PrayGoodsView extends Sprite
   {
       
      
      private var _goodsFrameArr:Array;
      
      private var _cell:BagCell;
      
      private var _cellArr:Array;
      
      private var _goodItemContainerAll:Array;
      
      private var _goodsItemSprite:Sprite;
      
      public function PrayGoodsView()
      {
         super();
      }
      
      private function initView() : void
      {
      }
      
      public function setInfo(param1:Array) : void
      {
         var _loc8_:int = 0;
         var _loc3_:* = null;
         var _loc7_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = NaN;
         var _loc6_:* = NaN;
         if(param1 == null || param1.length <= 0)
         {
            return;
         }
         var _loc2_:int = 0;
         _cellArr = [];
         _goodItemContainerAll = [];
         _goodsItemSprite = new Sprite();
         _loc8_ = 0;
         while(_loc8_ < param1.length)
         {
            _loc2_ = param1[_loc8_].Quality < 5?1:2;
            _loc3_ = ComponentFactory.Instance.creat("prayIndiana.GoodsF");
            _loc3_.gotoAndStop(_loc2_);
            _loc7_ = ItemManager.Instance.getTemplateById(param1[_loc8_].TemplateID) as ItemTemplateInfo;
            _loc5_ = new InventoryItemInfo();
            ObjectUtils.copyProperties(_loc5_,_loc7_);
            _loc5_.ValidDate = param1[_loc8_].ValidDate;
            _loc5_.StrengthenLevel = param1[_loc8_].StrengthLevel;
            _loc5_.AttackCompose = param1[_loc8_].AttackCompose;
            _loc5_.DefendCompose = param1[_loc8_].DefendCompose;
            _loc5_.LuckCompose = param1[_loc8_].LuckCompose;
            _loc5_.AgilityCompose = param1[_loc8_].AgilityCompose;
            _loc5_.IsBinds = param1[_loc8_].IsBind;
            _loc5_.Count = param1[_loc8_].Count;
            _loc5_.Place = param1[_loc8_].Position;
            _loc5_.exaltLevel = param1[_loc8_].Quality;
            _cell = new BagCell(0,_loc5_,false,null);
            _cell.width = 56;
            _cell.height = 55;
            _cell.x = 10;
            _cell.y = 11;
            _cell.setBgVisible(false);
            if(param1[_loc8_].IsSelect)
            {
               _cell.filters = ComponentFactory.Instance.creatFilters("grayFilter");
               _cell.alpha = 0.4;
               PrayIndianaManager.Instance.model.getGoods.push(_loc8_);
            }
            _loc4_ = 68;
            _loc6_ = 68;
            _loc4_ = Number(_loc4_ * (int(_loc8_ % 7)));
            _loc6_ = Number(_loc6_ * (int(_loc8_ / 7)));
            _loc3_.x = _loc4_;
            _loc3_.y = _loc6_;
            _cell.x = _loc4_ + 10;
            _cell.y = _loc6_ + 11;
            _goodsItemSprite.addChild(_cell);
            _cellArr.push(_cell);
            addChild(_loc3_);
            addChild(_goodsItemSprite);
            _goodItemContainerAll.push(_loc3_);
            _loc8_++;
         }
      }
      
      private function removeEvnet() : void
      {
      }
      
      public function dispose() : void
      {
      }
      
      public function get goodItemContainerAll() : Array
      {
         return _goodItemContainerAll;
      }
      
      public function set goodItemContainerAll(param1:Array) : void
      {
         _goodItemContainerAll = param1;
      }
      
      public function get cellArr() : Array
      {
         return _cellArr;
      }
      
      public function set cellArr(param1:Array) : void
      {
         _cellArr = param1;
      }
      
      public function get goodsItemSprite() : Sprite
      {
         return _goodsItemSprite;
      }
      
      public function set goodsItemSprite(param1:Sprite) : void
      {
         _goodsItemSprite = param1;
      }
   }
}
