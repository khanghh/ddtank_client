package gameStarling.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.StarlingObjectUtils;
   import road7th.StarlingMain;
   import starling.display.Image;
   import starling.display.Sprite;
   import starlingui.core.text.TextLabel;
   
   public class ExpMovie3D extends Sprite
   {
       
      
      private var _expText:TextLabel;
      
      private var _expUpAsset:Image;
      
      public function ExpMovie3D()
      {
         super();
      }
      
      private function initView() : void
      {
         _expText = ComponentFactory.Instance.creatComponentByStylename("ExpMovie.expText");
         _expUpAsset = StarlingMain.instance.createImage("asset.expMovie.ExpUPAsset");
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
      
      override public function dispose() : void
      {
         TweenLite.killTweensOf(_expText);
         TweenLite.killTweensOf(_expUpAsset);
         StarlingObjectUtils.disposeObject(_expText);
         _expText = null;
         StarlingObjectUtils.disposeObject(_expUpAsset);
         _expUpAsset = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
