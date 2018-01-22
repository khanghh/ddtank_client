package com.pickgliss.ui.controls
{
   import flash.events.Event;
   
   public class SelectedButtonForArrange extends SelectedButton
   {
       
      
      public function SelectedButtonForArrange()
      {
         super();
      }
      
      override public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(param1 == true)
         {
            if(_selectedButton)
            {
               _selectedButton.x = 0;
               addChild(_selectedButton);
            }
            if(_unSelectedButton)
            {
               _unSelectedButton.x = 0;
               _unSelectedButton.parent && removeChild(_unSelectedButton);
            }
         }
         else
         {
            if(_selectedButton)
            {
               _selectedButton.x = 0;
               _selectedButton.parent && removeChild(_selectedButton);
            }
            if(_unSelectedButton)
            {
               _unSelectedButton.x = 0;
               addChild(_unSelectedButton);
            }
         }
         onPropertiesChanged("selected");
         dispatchEvent(new Event("select"));
         drawHitArea();
      }
      
      override protected function addChildren() : void
      {
      }
   }
}
