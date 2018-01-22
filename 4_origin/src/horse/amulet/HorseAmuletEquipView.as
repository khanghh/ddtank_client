package horse.amulet
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import horse.HorseAmuletManager;
   import horse.HorseManager;
   
   public class HorseAmuletEquipView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _horseMc:MovieClip;
      
      private var _tipsCon:Component;
      
      private var _cellList:Vector.<HorseAmuletEquipCell>;
      
      private var EQUIP_MAX_PALCE:int = 8;
      
      private var _bag:BagInfo;
      
      public function HorseAmuletEquipView()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         var _loc2_:int = 0;
         _bag = PlayerManager.Instance.Self.getBag(42);
         _bg = ComponentFactory.Instance.creatBitmap("asset.horseAmulet.equipViewBg");
         addChild(_bg);
         _horseMc = ComponentFactory.Instance.creat("asset.horse.frame.horseMc");
         PositionUtils.setPos(_horseMc,"horseAmulet.equip.horseMcPos");
         var _loc1_:int = int(HorseManager.instance.curLevel / 10) + 1;
         _horseMc.mouseChildren = false;
         _horseMc.mouseEnabled = false;
         _horseMc.gotoAndStop(_loc1_ > 9?9:_loc1_);
         addChild(_horseMc);
         _tipsCon = ComponentFactory.Instance.creatComponentByStylename("ddtcorei.horseAmulet.tips");
         _tipsCon.tipData = PlayerManager.Instance.Self;
         PositionUtils.setPos(_tipsCon,"horseAmulet.equip.tipsConPos");
         _tipsCon.graphics.beginFill(0,0);
         _tipsCon.graphics.drawRect(0,0,200,200);
         _tipsCon.graphics.endFill();
         addChild(_tipsCon);
         _cellList = new Vector.<HorseAmuletEquipCell>(9);
         _loc2_ = 0;
         while(_loc2_ < 9)
         {
            _cellList[_loc2_] = new HorseAmuletEquipCell(_loc2_,null);
            _cellList[_loc2_].openLevel = HorseAmuletManager.LIMIT_LEVEL[_loc2_];
            _cellList[_loc2_].info = _bag.getItemAt(_loc2_);
            PositionUtils.setPos(_cellList[_loc2_],"horseAmulet.equipCellPos" + _loc2_);
            addChild(_cellList[_loc2_]);
            _loc2_++;
         }
         _bag.addEventListener("update",__updateGoods);
      }
      
      private function __updateGoods(param1:BagEvent) : void
      {
         var _loc2_:* = null;
         var _loc4_:Dictionary = param1.changedSlots;
         var _loc6_:int = 0;
         var _loc5_:* = _loc4_;
         for each(var _loc3_ in _loc4_)
         {
            _loc2_ = _bag.getItemAt(_loc3_.Place);
            if(_loc2_)
            {
               setCellInfo(_loc3_.Place,_loc2_);
            }
            else
            {
               setCellInfo(_loc3_.Place,null);
            }
         }
      }
      
      private function setCellInfo(param1:int, param2:InventoryItemInfo) : void
      {
         if(param1 > EQUIP_MAX_PALCE)
         {
            return;
         }
         if(param2 == null)
         {
            if(_cellList[param1])
            {
               _cellList[param1].info = null;
            }
         }
         else if(param2.Count == 0)
         {
            _cellList[param1].info = null;
         }
         else
         {
            _cellList[param1].info = param2;
         }
      }
      
      public function dispose() : void
      {
         _bag.removeEventListener("update",__updateGoods);
         ObjectUtils.disposeAllChildren(this);
         _cellList.splice(0,_cellList.length);
         _cellList = null;
         _bg = null;
         _bag = null;
         _horseMc = null;
         _tipsCon = null;
      }
   }
}
