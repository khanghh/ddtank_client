package ddt.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class SimpleReturnBar extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _stretchBtn:SelectedButton;
      
      private var _returnBtn:BaseButton;
      
      private var _returnCall:Function;
      
      public var stopTo:Number;
      
      public var moveTo:Number;
      
      public function SimpleReturnBar()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.ddtcore.returnBarBG");
         _stretchBtn = ComponentFactory.Instance.creatComponentByStylename("asset.simpleReturnBar.stretchBtn");
         _returnBtn = ComponentFactory.Instance.creatComponentByStylename("asset.simpleReturnBar.returnBtn");
         addChild(_bg);
         addChild(_stretchBtn);
         addChild(_returnBtn);
      }
      
      private function initEvent() : void
      {
         _stretchBtn.addEventListener("click",__onStretchBtnClick);
         _returnBtn.addEventListener("click",__onReturnClick);
      }
      
      private function __onStretchBtnClick(event:MouseEvent) : void
      {
         TweenLite.killTweensOf(this);
         TweenLite.to(this,0.5,{"x":(!!_stretchBtn.selected?moveTo:Number(stopTo))});
      }
      
      private function __onReturnClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(_returnCall != null)
         {
            _returnCall();
         }
      }
      
      private function removeEvent() : void
      {
         _stretchBtn.removeEventListener("click",__onStretchBtnClick);
         _returnBtn.removeEventListener("click",__onReturnClick);
      }
      
      public function set returnCall(call:Function) : void
      {
         _returnCall = call;
      }
      
      public function dispose() : void
      {
         removeEvent();
         TweenLite.killTweensOf(this);
         _returnCall = null;
      }
   }
}
