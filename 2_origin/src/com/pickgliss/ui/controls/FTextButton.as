package com.pickgliss.ui.controls
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Sprite;
   
   public class FTextButton extends Sprite
   {
       
      
      private var _btn:SimpleBitmapButton;
      
      private var _txt:FilterFrameText;
      
      public var id:int;
      
      public function FTextButton(param1:String, param2:String)
      {
         super();
         _btn = ComponentFactory.Instance.creatComponentByStylename(param1);
         addChild(_btn);
         _txt = ComponentFactory.Instance.creatComponentByStylename(param2);
         _txt.text = "前去充值";
         _txt.selectable = false;
         addChild(_txt);
      }
      
      public function setTxt(param1:String) : void
      {
         _txt.text = param1;
      }
   }
}
