package magicHouse.magicBox
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class MagicBoxFusionItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _name:FilterFrameText;
      
      private var _shine:Bitmap;
      
      private var _cell:BagCell;
      
      private var _info:MagicBoxItemInfo;
      
      public function MagicBoxFusionItem(){super();}
      
      private function initView() : void{}
      
      public function setItemData(param1:MagicBoxItemInfo) : void{}
      
      public function setItemShine(param1:Boolean) : void{}
      
      public function get info() : MagicBoxItemInfo{return null;}
      
      public function dispose() : void{}
   }
}
