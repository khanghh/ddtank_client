package com.pickgliss.ui
{
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.DisplayObject;
   
   public class FilterFrameTextWithTips extends FilterFrameText implements ITipedDisplay
   {
       
      
      private var _tipStyle:String;
      
      private var _tipGapV:int;
      
      private var _tipGapH:int;
      
      private var _tipDirctions:String;
      
      private var _tipData:Object;
      
      public function FilterFrameTextWithTips()
      {
         super();
         ShowTipManager.Instance.addTip(this);
      }
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function set tipData(param1:Object) : void
      {
         _tipData = param1;
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirctions;
      }
      
      public function set tipDirctions(param1:String) : void
      {
         _tipDirctions = param1;
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function set tipGapH(param1:int) : void
      {
         _tipGapH = param1;
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function set tipGapV(param1:int) : void
      {
         _tipGapV = param1;
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function set tipStyle(param1:String) : void
      {
         _tipStyle = param1;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ShowTipManager.Instance.removeTip(this);
      }
   }
}
