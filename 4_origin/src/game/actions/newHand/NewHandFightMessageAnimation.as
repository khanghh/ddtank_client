package game.actions.newHand
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quint;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   class NewHandFightMessageAnimation implements Disposeable
   {
       
      
      private var _duration:Number;
      
      private var _tipContent:DisplayObject;
      
      private var _tipContainer:Sprite;
      
      function NewHandFightMessageAnimation(tipStyle:String, duration:Number, autoShow:Boolean = true)
      {
         super();
         _duration = duration;
         _tipContainer = new Sprite();
         var _loc4_:Boolean = false;
         _tipContainer.mouseEnabled = _loc4_;
         _tipContainer.mouseChildren = _loc4_;
         _tipContainer.y = StageReferance.stageHeight >> 1;
         _tipContent = ComponentFactory.Instance.creat(tipStyle);
         _tipContainer.addChild(_tipContent);
         _tipContainer.x = StageReferance.stageWidth - _tipContent.width >> 1;
         if(autoShow)
         {
            show();
         }
      }
      
      public function show() : void
      {
         var tempY:int = (StageReferance.stageHeight - _tipContainer.height) / 2 - 10;
         TweenMax.fromTo(_tipContainer,0.3,{
            "y":StageReferance.stageHeight / 2 + 20,
            "alpha":0,
            "ease":Quint.easeIn,
            "onComplete":onTipToCenter
         },{
            "y":tempY,
            "alpha":1
         });
         LayerManager.Instance.addToLayer(_tipContainer,1,false,0,false);
      }
      
      private function onTipToCenter() : void
      {
         TweenMax.to(_tipContainer,_duration,{
            "alpha":0,
            "ease":Quint.easeOut,
            "onComplete":dispose,
            "delay":1.2
         });
      }
      
      public function dispose() : void
      {
         TweenMax.killTweensOf(_tipContainer);
         if(_tipContent)
         {
            ObjectUtils.disposeObject(_tipContent);
         }
         _tipContent = null;
         if(_tipContainer)
         {
            ObjectUtils.disposeObject(_tipContainer);
         }
         _tipContainer = null;
      }
   }
}
