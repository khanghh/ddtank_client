package ddt.view.caddyII.badLuck
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class ReceiveBadLuckItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _RsortTxt:FilterFrameText;
      
      private var _RnameTxt:FilterFrameText;
      
      private var _RgoosTxt:FilterFrameText;
      
      private var _topThteeBit:ScaleFrameImage;
      
      private var _cell:BaseCell;
      
      public function ReceiveBadLuckItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.RbadLuckItemBG");
         _RsortTxt = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.RsortTxt");
         _RnameTxt = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.RNameTxt");
         _RgoosTxt = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.RgoodsTxt");
         _topThteeBit = ComponentFactory.Instance.creatComponentByStylename("caddy.RBadTopThreeRink");
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,28,28);
         _loc1_.graphics.endFill();
         _cell = ComponentFactory.Instance.creatCustomObject("badLuck.itemCell",[_loc1_]);
         addChild(_bg);
         addChild(_RsortTxt);
         addChild(_RnameTxt);
         addChild(_RgoosTxt);
         addChild(_topThteeBit);
         addChild(_cell);
      }
      
      public function update(param1:int, param2:String, param3:InventoryItemInfo) : void
      {
         _bg.setFrame(param1 % 2 + 1);
         _RsortTxt.text = param1 + 1 + "th";
         _topThteeBit.setFrame(param1 < 3?param1 + 1:1);
         _topThteeBit.visible = param1 < 3;
         _RsortTxt.visible = param1 >= 3;
         _RnameTxt.text = param2;
         _RgoosTxt.text = param3.Name;
         _cell.info = param3;
      }
      
      override public function get height() : Number
      {
         if(_bg == null)
         {
            return 0;
         }
         return _bg.y + _bg.displayHeight;
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_RsortTxt)
         {
            ObjectUtils.disposeObject(_RsortTxt);
         }
         _RsortTxt = null;
         if(_RnameTxt)
         {
            ObjectUtils.disposeObject(_RnameTxt);
         }
         _RnameTxt = null;
         if(_RgoosTxt)
         {
            ObjectUtils.disposeObject(_RgoosTxt);
         }
         _RgoosTxt = null;
         if(_topThteeBit)
         {
            ObjectUtils.disposeObject(_topThteeBit);
         }
         _topThteeBit = null;
         if(_cell)
         {
            ObjectUtils.disposeObject(_cell);
         }
         _cell = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
