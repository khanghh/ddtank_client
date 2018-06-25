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
      
      public function FTextButton(str:String, txtstr:String)
      {
         super();
         _btn = ComponentFactory.Instance.creatComponentByStylename(str);
         addChild(_btn);
         _txt = ComponentFactory.Instance.creatComponentByStylename(txtstr);
         _txt.text = "前去充值";
         _txt.selectable = false;
         addChild(_txt);
      }
      
      public function setTxt(str:String) : void
      {
         _txt.text = str;
      }
   }
}
