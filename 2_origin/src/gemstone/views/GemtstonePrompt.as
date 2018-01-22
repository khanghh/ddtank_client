package gemstone.views
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class GemtstonePrompt extends Frame
   {
       
      
      private var _btn:SimpleBitmapButton;
      
      private var _goodsContent:Bitmap;
      
      private var _goods:Bitmap;
      
      public function GemtstonePrompt()
      {
         super();
         backStyle = "SimpleFrameBackgoundOne";
         closestyle = "core.closebt";
         stylename = "caddyAwardListFrame";
         titleStyle = "FrameTitleTextStyle";
         titleOuterRectPosString = "15,10,5";
         x = 160;
         y = 40;
         closeInnerRectString = "44,19,6,30,14";
         width = 300;
         height = 200;
         addEventListener("response",response);
         _goodsContent = ComponentFactory.Instance.creatBitmap("asset.toolbar.GemstoneAlert.back");
         addToContent(_goodsContent);
         _goods = ComponentFactory.Instance.creatBitmap("asset.toolbar.GemstoneAlert.attck");
         addToContent(_goods);
         _btn = ComponentFactory.Instance.creatComponentByStylename("lookBtn");
         _btn.addEventListener("click",clickHander);
         addToContent(_btn);
      }
      
      protected function clickHander(param1:MouseEvent) : void
      {
         ObjectUtils.disposeObject(this);
      }
      
      private function response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            ObjectUtils.disposeObject(this);
         }
      }
      
      override public function dispose() : void
      {
         _btn.addEventListener("click",clickHander);
         if(_goodsContent)
         {
            ObjectUtils.disposeObject(_goodsContent);
         }
         _goodsContent = null;
         if(_goods)
         {
            ObjectUtils.disposeObject(_goods);
         }
         _goods = null;
         if(_btn)
         {
            ObjectUtils.disposeObject(_btn);
         }
         _btn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
