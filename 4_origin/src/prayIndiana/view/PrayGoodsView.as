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
      
      public function setInfo($goods:Array) : void
      {
         var i:int = 0;
         var frame:* = null;
         var itemInfo:* = null;
         var tInfo:* = null;
         var dx:* = NaN;
         var dy:* = NaN;
         if($goods == null || $goods.length <= 0)
         {
            return;
         }
         var index:int = 0;
         _cellArr = [];
         _goodItemContainerAll = [];
         _goodsItemSprite = new Sprite();
         for(i = 0; i < $goods.length; )
         {
            index = $goods[i].Quality < 5?1:2;
            frame = ComponentFactory.Instance.creat("prayIndiana.GoodsF");
            frame.gotoAndStop(index);
            itemInfo = ItemManager.Instance.getTemplateById($goods[i].TemplateID) as ItemTemplateInfo;
            tInfo = new InventoryItemInfo();
            ObjectUtils.copyProperties(tInfo,itemInfo);
            tInfo.ValidDate = $goods[i].ValidDate;
            tInfo.StrengthenLevel = $goods[i].StrengthLevel;
            tInfo.AttackCompose = $goods[i].AttackCompose;
            tInfo.DefendCompose = $goods[i].DefendCompose;
            tInfo.LuckCompose = $goods[i].LuckCompose;
            tInfo.AgilityCompose = $goods[i].AgilityCompose;
            tInfo.IsBinds = $goods[i].IsBind;
            tInfo.Count = $goods[i].Count;
            tInfo.Place = $goods[i].Position;
            tInfo.exaltLevel = $goods[i].Quality;
            _cell = new BagCell(0,tInfo,false,null);
            _cell.width = 56;
            _cell.height = 55;
            _cell.x = 10;
            _cell.y = 11;
            _cell.setBgVisible(false);
            if($goods[i].IsSelect)
            {
               _cell.filters = ComponentFactory.Instance.creatFilters("grayFilter");
               _cell.alpha = 0.4;
               PrayIndianaManager.Instance.model.getGoods.push(i);
            }
            dx = 68;
            dy = 68;
            dx = Number(dx * (int(i % 7)));
            dy = Number(dy * (int(i / 7)));
            frame.x = dx;
            frame.y = dy;
            _cell.x = dx + 10;
            _cell.y = dy + 11;
            _goodsItemSprite.addChild(_cell);
            _cellArr.push(_cell);
            addChild(frame);
            addChild(_goodsItemSprite);
            _goodItemContainerAll.push(frame);
            i++;
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
      
      public function set goodItemContainerAll(value:Array) : void
      {
         _goodItemContainerAll = value;
      }
      
      public function get cellArr() : Array
      {
         return _cellArr;
      }
      
      public function set cellArr(value:Array) : void
      {
         _cellArr = value;
      }
      
      public function get goodsItemSprite() : Sprite
      {
         return _goodsItemSprite;
      }
      
      public function set goodsItemSprite(value:Sprite) : void
      {
         _goodsItemSprite = value;
      }
   }
}
