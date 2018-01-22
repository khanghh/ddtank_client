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
      
      public function PrizeAlterContainer(){super();}
      
      private function initView() : void{}
      
      public function show(param1:Boolean, param2:String = "", param3:Number = 0) : void{}
      
      private function alertComplete() : void{}
      
      private function alertComplete2() : void{}
      
      public function dispose() : void{}
   }
}
