package bagAndInfo.bag
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BagArrangeTipSprite extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _contentTxt:FilterFrameText;
      
      private var _bagArrangeCheckBtn:SelectedCheckButton;
      
      private var _arrangeAdd:Boolean;
      
      public function BagArrangeTipSprite()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get arrangeAdd() : Boolean
      {
         return _arrangeAdd;
      }
      
      public function set arrangeAdd(param1:Boolean) : void
      {
         _arrangeAdd = param1;
      }
      
      private function initEvent() : void
      {
         addEventListener("rollOut",__outHandler);
         _bagArrangeCheckBtn.addEventListener("click",__btnSelectedHandler);
      }
      
      protected function __btnSelectedHandler(param1:MouseEvent) : void
      {
         _arrangeAdd = _bagArrangeCheckBtn.selected;
      }
      
      protected function __outHandler(param1:MouseEvent) : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      protected function __overHandler(param1:MouseEvent) : void
      {
         if(parent)
         {
            parent.addChild(this);
         }
      }
      
      private function removeEvent() : void
      {
         _bagArrangeCheckBtn.removeEventListener("click",__btnSelectedHandler);
         removeEventListener("rollOut",__outHandler);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("bagArrangeText");
         _contentTxt.text = LanguageMgr.GetTranslation("tank.view.bagII.BagIIView.bagArrangeBtn");
         _bagArrangeCheckBtn = ComponentFactory.Instance.creatComponentByStylename("bagArrangeCheckBox");
         addChild(_bg);
         addChild(_bagArrangeCheckBtn);
         addChild(_contentTxt);
         updateTransform();
      }
      
      protected function updateTransform() : void
      {
         _bg.width = _contentTxt.width + 40;
         _bg.height = _contentTxt.height + 12;
         _contentTxt.x = _bg.x + 25;
         _contentTxt.y = _bg.y + 6;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_contentTxt);
         _contentTxt = null;
         ObjectUtils.disposeObject(_bagArrangeCheckBtn);
         _bagArrangeCheckBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
