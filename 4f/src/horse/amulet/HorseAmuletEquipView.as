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
      
      public function HorseAmuletEquipView(){super();}
      
      private function init() : void{}
      
      private function __updateGoods(param1:BagEvent) : void{}
      
      private function setCellInfo(param1:int, param2:InventoryItemInfo) : void{}
      
      public function dispose() : void{}
   }
}
