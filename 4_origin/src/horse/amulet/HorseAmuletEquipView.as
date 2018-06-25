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
         var i:int = 0;
         _bag = PlayerManager.Instance.Self.getBag(42);
         _bg = ComponentFactory.Instance.creatBitmap("asset.horseAmulet.equipViewBg");
         addChild(_bg);
         _horseMc = ComponentFactory.Instance.creat("asset.horse.frame.horseMc");
         PositionUtils.setPos(_horseMc,"horseAmulet.equip.horseMcPos");
         var index:int = int(HorseManager.instance.curLevel / 10) + 1;
         _horseMc.mouseChildren = false;
         _horseMc.mouseEnabled = false;
         _horseMc.gotoAndStop(index > 9?9:index);
         addChild(_horseMc);
         _tipsCon = ComponentFactory.Instance.creatComponentByStylename("ddtcorei.horseAmulet.tips");
         _tipsCon.tipData = PlayerManager.Instance.Self;
         PositionUtils.setPos(_tipsCon,"horseAmulet.equip.tipsConPos");
         _tipsCon.graphics.beginFill(0,0);
         _tipsCon.graphics.drawRect(0,0,200,200);
         _tipsCon.graphics.endFill();
         addChild(_tipsCon);
         _cellList = new Vector.<HorseAmuletEquipCell>(9);
         for(i = 0; i < 9; )
         {
            _cellList[i] = new HorseAmuletEquipCell(i,null);
            _cellList[i].openLevel = HorseAmuletManager.LIMIT_LEVEL[i];
            _cellList[i].info = _bag.getItemAt(i);
            PositionUtils.setPos(_cellList[i],"horseAmulet.equipCellPos" + i);
            addChild(_cellList[i]);
            i++;
         }
         _bag.addEventListener("update",__updateGoods);
      }
      
      private function __updateGoods(evt:BagEvent) : void
      {
         var c:* = null;
         var changes:Dictionary = evt.changedSlots;
         var _loc6_:int = 0;
         var _loc5_:* = changes;
         for each(var i in changes)
         {
            c = _bag.getItemAt(i.Place);
            if(c)
            {
               setCellInfo(i.Place,c);
            }
            else
            {
               setCellInfo(i.Place,null);
            }
         }
      }
      
      private function setCellInfo(index:int, info:InventoryItemInfo) : void
      {
         if(index > EQUIP_MAX_PALCE)
         {
            return;
         }
         if(info == null)
         {
            if(_cellList[index])
            {
               _cellList[index].info = null;
            }
         }
         else if(info.Count == 0)
         {
            _cellList[index].info = null;
         }
         else
         {
            _cellList[index].info = info;
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
