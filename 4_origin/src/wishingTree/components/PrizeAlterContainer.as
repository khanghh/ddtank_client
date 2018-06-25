package wishingTree.components
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Sine;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class PrizeAlterContainer extends Sprite implements Disposeable
   {
       
      
      private var _wishSuccess:Bitmap;
      
      private var _successTxt:FilterFrameText;
      
      private var _wishFail:Bitmap;
      
      public function PrizeAlterContainer()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _wishSuccess = ComponentFactory.Instance.creat("wishingTree.success");
         addChild(_wishSuccess);
         _successTxt = ComponentFactory.Instance.creatComponentByStylename("wishingTree.successTxt");
         addChild(_successTxt);
         _wishFail = ComponentFactory.Instance.creat("wishingTree.fail");
         addChild(_wishFail);
      }
      
      public function show(isSuccess:Boolean, itemTxt:String = "", delay:Number = 0) : void
      {
         if(isSuccess)
         {
            _wishSuccess.visible = true;
            _successTxt.visible = true;
            _wishFail.visible = false;
            _successTxt.text = LanguageMgr.GetTranslation("wishingTree.successTxt",itemTxt);
         }
         else
         {
            _wishSuccess.visible = false;
            _successTxt.visible = false;
            _wishFail.visible = true;
         }
         this.y = 340;
         this.alpha = 0;
         TweenLite.to(this,0.3,{
            "y":120,
            "alpha":1,
            "delay":delay,
            "ease":Sine.easeInOut,
            "onComplete":alertComplete
         });
      }
      
      private function alertComplete() : void
      {
         TweenLite.to(this,0.5,{
            "y":-90,
            "alpha":0,
            "delay":0.5,
            "ease":Sine.easeInOut,
            "onComplete":alertComplete2
         });
      }
      
      private function alertComplete2() : void
      {
         dispatchEvent(new Event("complete"));
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_wishSuccess);
         _wishSuccess = null;
         ObjectUtils.disposeObject(_successTxt);
         _successTxt = null;
         ObjectUtils.disposeObject(_wishFail);
         _wishFail = null;
      }
   }
}
