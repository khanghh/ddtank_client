package farm.viewx.helper
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import farm.view.compose.event.SelectComposeItemEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class HelperSetItem extends Sprite implements Disposeable
   {
       
      
      private var _nameTxt:FilterFrameText;
      
      private var _bgImg:Bitmap;
      
      private var _id:int;
      
      private var _info:ShopItemInfo;
      
      public function HelperSetItem()
      {
         super();
         init();
         initEvents();
      }
      
      private function init() : void
      {
         _bgImg = ComponentFactory.Instance.creat("asset.farmHouse.selectComposeitemBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("core.comboxListCellTxt3");
         _nameTxt.height = 20;
         addChild(_nameTxt);
         addChildAt(_bgImg,0);
         _bgImg.alpha = 0;
         _bgImg.width = 100;
         _bgImg.y = -2;
      }
      
      private function initEvents() : void
      {
         addEventListener("click",__click);
         addEventListener("mouseMove",__mouseOver);
         addEventListener("rollOut",__mouseOut);
      }
      
      private function __mouseOver(param1:MouseEvent) : void
      {
         _bgImg.alpha = 1;
      }
      
      private function __mouseOut(param1:MouseEvent) : void
      {
         _bgImg.alpha = 0;
      }
      
      private function __click(param1:MouseEvent) : void
      {
         var _loc3_:Object = {};
         _loc3_.id = _id;
         var _loc2_:SelectComposeItemEvent = new SelectComposeItemEvent("selectSeed",_loc3_);
         dispatchEvent(_loc2_);
      }
      
      public function set info(param1:ShopItemInfo) : void
      {
         _nameTxt.text = param1.TemplateInfo.Name;
         _id = param1.TemplateInfo.TemplateID;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bgImg);
         _bgImg = null;
         if(_nameTxt && _nameTxt.parent)
         {
            _nameTxt.parent.removeChild(_nameTxt);
            _nameTxt = null;
         }
         removeEventListener("click",__click);
         removeEventListener("mouseOver",__mouseOver);
         removeEventListener("mouseOut",__mouseOut);
      }
   }
}
