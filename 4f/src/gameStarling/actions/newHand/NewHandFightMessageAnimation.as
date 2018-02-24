package gameStarling.actions.newHand
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
      
      function NewHandFightMessageAnimation(param1:String, param2:Number, param3:Boolean = true){super();}
      
      public function show() : void{}
      
      private function onTipToCenter() : void{}
      
      public function dispose() : void{}
   }
}
