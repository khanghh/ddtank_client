package ddt.view.caddyII.offerPack
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PlayerManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class OfferPackItem extends Sprite implements Disposeable
   {
      
      public static const HSpace:int = 10;
       
      
      private var _count:int = 0;
      
      private var _countField:FilterFrameText;
      
      private var _info:ItemTemplateInfo;
      
      private var _seleceted:Boolean = false;
      
      private var _selecetedShin:Scale9CornerImage;
      
      private var _iconCell:BagCell;
      
      public function OfferPackItem(){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      private function removeEvents() : void{}
      
      private function __overHandler(param1:MouseEvent) : void{}
      
      private function __outHandler(param1:MouseEvent) : void{}
      
      public function get count() : int{return 0;}
      
      public function set count(param1:int) : void{}
      
      public function get info() : ItemTemplateInfo{return null;}
      
      public function set info(param1:ItemTemplateInfo) : void{}
      
      public function get selected() : Boolean{return false;}
      
      public function set selected(param1:Boolean) : void{}
      
      override public function get width() : Number{return 0;}
      
      public function dispose() : void{}
   }
}
