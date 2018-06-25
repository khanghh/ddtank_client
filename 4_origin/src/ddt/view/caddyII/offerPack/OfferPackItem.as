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
      
      public function OfferPackItem()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _iconCell = CellFactory.instance.createPersonalInfoCell(-1,null,true) as BagCell;
         var bounds:Rectangle = ComponentFactory.Instance.creatCustomObject("ddt.view.caddyII.offerPack.OfferPackItem.cellBounds");
         _iconCell.x = bounds.x;
         _iconCell.y = bounds.y;
         _iconCell.width = bounds.width;
         _iconCell.height = bounds.height;
         var countFieldBG:Scale9CornerImage = ComponentFactory.Instance.creatComponentByStylename("offer.oferItemCountBg");
         _countField = ComponentFactory.Instance.creatComponentByStylename("caddy.OfferPack.PackItem.CountField");
         addChild(_iconCell);
         addChild(countFieldBG);
         addChild(_countField);
         _selecetedShin = ComponentFactory.Instance.creatComponentByStylename("offer.oferItemShin");
         addChild(_selecetedShin);
         var _loc3_:* = false;
         _selecetedShin.mouseEnabled = _loc3_;
         _loc3_ = _loc3_;
         _selecetedShin.mouseChildren = _loc3_;
         _selecetedShin.visible = _loc3_;
         mouseChildren = true;
         buttonMode = true;
      }
      
      private function initEvents() : void
      {
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
      }
      
      private function __overHandler(e:MouseEvent) : void
      {
         _selecetedShin.visible = true;
      }
      
      private function __outHandler(e:MouseEvent) : void
      {
         if(!_seleceted)
         {
            _selecetedShin.visible = false;
         }
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function set count(val:int) : void
      {
         _count = val;
         if(_countField)
         {
            _countField.text = String(_count);
         }
      }
      
      public function get info() : ItemTemplateInfo
      {
         return _info;
      }
      
      public function set info(val:ItemTemplateInfo) : void
      {
         if(_info != val)
         {
            _info = val;
            _iconCell.info = _info;
            count = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_info.TemplateID);
         }
      }
      
      public function get selected() : Boolean
      {
         return _seleceted;
      }
      
      public function set selected(val:Boolean) : void
      {
         if(_seleceted != val)
         {
            _seleceted = val;
            if(_selecetedShin)
            {
               _selecetedShin.visible = _seleceted;
            }
         }
      }
      
      override public function get width() : Number
      {
         return 53;
      }
      
      public function dispose() : void
      {
         removeEvents();
         _info = null;
         if(_countField)
         {
            ObjectUtils.disposeObject(_countField);
         }
         _countField = null;
         if(_selecetedShin)
         {
            ObjectUtils.disposeObject(_selecetedShin);
         }
         _selecetedShin = null;
         if(_iconCell)
         {
            ObjectUtils.disposeObject(_iconCell);
         }
         _iconCell = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
