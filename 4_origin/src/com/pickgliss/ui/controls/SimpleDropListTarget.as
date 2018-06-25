package com.pickgliss.ui.controls
{
   import com.pickgliss.ui.controls.list.IDropListTarget;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.DisplayObject;
   
   public class SimpleDropListTarget extends FilterFrameText implements IDropListTarget
   {
       
      
      public function SimpleDropListTarget()
      {
         super();
      }
      
      public function setValue(value:*) : void
      {
         text = String(value);
      }
      
      public function setCursor(index:int) : void
      {
         setSelection(index,index);
      }
      
      public function getValueLength() : int
      {
         return text.length;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
