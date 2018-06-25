package com.pickgliss.ui.controls
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   
   public class SimpleBitmapButton extends BaseButton
   {
       
      
      public function SimpleBitmapButton()
      {
         super();
         _frameFilter = ComponentFactory.Instance.creatFrameFilters(ComponentSetting.SIMPLE_BITMAP_BUTTON_FILTER);
      }
      
      override public function set backStyle(stylename:String) : void
      {
         if(stylename == _backStyle)
         {
            return;
         }
         _backStyle = stylename;
         backgound = ComponentFactory.Instance.creat(stylename);
         _width = _back.width;
         _height = _back.height;
         onPropertiesChanged("backStyle");
      }
      
      public function setFocusFrame() : void
      {
         _focusFrame.x = 0;
         _focusFrame.y = 0;
      }
   }
}
