package com.pickgliss.ui.controls{   import com.pickgliss.ui.controls.list.IDropListTarget;   import com.pickgliss.ui.text.FilterFrameText;   import flash.display.DisplayObject;      public class SimpleDropListTarget extends FilterFrameText implements IDropListTarget   {                   public function SimpleDropListTarget() { super(); }
            public function setValue(value:*) : void { }
            public function setCursor(index:int) : void { }
            public function getValueLength() : int { return 0; }
            public function asDisplayObject() : DisplayObject { return null; }
   }}