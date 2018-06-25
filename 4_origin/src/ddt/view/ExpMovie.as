package ddt.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class ExpMovie extends Sprite implements Disposeable
   {
       
      
      private var _expText:FilterFrameText;
      
      private var _expUpAsset:Bitmap;
      
      public function ExpMovie()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _expText = ComponentFactory.Instance.creatComponentByStylename("ExpMovie.expText");
         _expUpAsset = ComponentFactory.Instance.creatBitmap("asset.expMovie.ExpUPAsset");
         addChild(_expText);
         addChild(_expUpAsset);
         _expText.alpha = 0;
         _expUpAsset.alpha = 0;
      }
      
      public function set exp(value:int) : void
      {
         _expText.text = value.toString();
      }
      
      public function play() : void
      {
         _expText.y = 0;
         _expText.alpha = 0;
         TweenLite.to(_expText,0.4,{
            "y":-22,
            "alpha":1,
            "onComplete":onOut
         });
         _expUpAsset.y = 28;
         _expUpAsset.alpha = 0;
         TweenLite.to(_expUpAsset,0.4,{
            "y":4,
            "alpha":1,
            "delay":0.2,
            "onComplete":onOut1
         });
      }
      
      private function onOut() : void
      {
         TweenLite.to(_expText,0.4,{
            "y":-20,
            "alpha":0,
            "delay":1
         });
      }
      
      private function onOut1() : void
      {
         TweenLite.to(_expUpAsset,0.4,{
            "y":0,
            "alpha":0,
            "delay":0.9
         });
      }
      
      public function dispose() : void
      {
         TweenLite.killTweensOf(_expText);
         TweenLite.killTweensOf(_expUpAsset);
         if(_expText)
         {
            ObjectUtils.disposeObject(_expText);
         }
         _expText = null;
         if(_expUpAsset)
         {
            ObjectUtils.disposeObject(_expUpAsset);
         }
         _expUpAsset = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
