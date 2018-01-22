package gameCommon.view.control
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import gameCommon.model.LocalPlayer;
   
   public class ControlState extends Sprite implements Disposeable
   {
       
      
      protected var _self:LocalPlayer;
      
      protected var _container:DisplayObjectContainer;
      
      protected var _leavingFunc:Function;
      
      protected var _background:DisplayObject;
      
      public function ControlState(param1:LocalPlayer)
      {
         super();
         _self = param1;
         configUI();
      }
      
      protected function configUI() : void
      {
      }
      
      protected function addEvent() : void
      {
      }
      
      protected function removeEvent() : void
      {
      }
      
      public function enter(param1:DisplayObjectContainer) : void
      {
         _container = param1;
         _container.addChild(this);
         addEvent();
         tweenIn();
      }
      
      protected function tweenIn() : void
      {
         y = 600;
         TweenLite.to(this,0.3,{
            "y":600 - height,
            "onComplete":enterComplete
         });
      }
      
      protected function tweenOut() : void
      {
         TweenLite.to(this,0.3,{
            "y":600,
            "onComplete":leavingComplete
         });
      }
      
      public function leaving(param1:Function = null) : void
      {
         _leavingFunc = param1;
         removeEvent();
         tweenOut();
      }
      
      protected function enterComplete() : void
      {
      }
      
      protected function leavingComplete() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
         if(_leavingFunc != null)
         {
            _leavingFunc.apply();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         TweenLite.killTweensOf(this);
         ObjectUtils.disposeObject(_background);
         _background = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
