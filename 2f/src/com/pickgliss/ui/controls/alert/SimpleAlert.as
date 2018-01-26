package com.pickgliss.ui.controls.alert
{
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class SimpleAlert extends BaseAlerFrame
   {
      
      public static const P_frameInnerRect:String = "frameInnerRect";
      
      public static const P_frameMiniH:String = "frameMiniH";
      
      public static const P_frameMiniW:String = "frameMiniW";
      
      public static const P_textField:String = "textFieldStyle";
       
      
      protected var _frameMiniH:int = -2147483648;
      
      protected var _frameMiniW:int = -2147483648;
      
      protected var _textField:TextField;
      
      protected var _textFieldStyle:String;
      
      private var _frameInnerRect:InnerRectangle;
      
      private var _frameInnerRectString:String;
      
      private var _selectedBandBtn:SelectedCheckButton;
      
      private var _selectedBtn:SelectedCheckButton;
      
      private var _back:MovieClip;
      
      protected var _seleContent:Sprite;
      
      public function SimpleAlert(){super();}
      
      override public function dispose() : void{}
      
      override public function set info(param1:AlertInfo) : void{}
      
      override protected function creatTheLog() : void{}
      
      protected function selectedBandHander(param1:MouseEvent) : void{}
      
      protected function selectedHander(param1:MouseEvent) : void{}
      
      public function set frameInnerRectString(param1:String) : void{}
      
      public function set frameMiniH(param1:int) : void{}
      
      public function set frameMiniW(param1:int) : void{}
      
      public function set textStyle(param1:String) : void{}
      
      override protected function addChildren() : void{}
      
      protected function layoutFrameRect() : void{}
      
      override protected function onProppertiesUpdate() : void{}
      
      protected function updateMsg() : void{}
   }
}
