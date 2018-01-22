package morn.core.components
{
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import morn.editor.core.IContent;
   
   public class Panel extends Box implements IContent
   {
       
      
      protected var _content:Box;
      
      protected var _vScrollBar:VScrollBar;
      
      protected var _hScrollBar:HScrollBar;
      
      public function Panel(){super();}
      
      override protected function createChildren() : void{}
      
      override public function addChild(param1:DisplayObject) : DisplayObject{return null;}
      
      private function onResize(param1:Event) : void{}
      
      override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject{return null;}
      
      override public function removeChild(param1:DisplayObject) : DisplayObject{return null;}
      
      override public function removeChildAt(param1:int) : DisplayObject{return null;}
      
      override public function removeAllChild(param1:DisplayObject = null) : void{}
      
      override public function getChildAt(param1:int) : DisplayObject{return null;}
      
      override public function getChildByName(param1:String) : DisplayObject{return null;}
      
      override public function getChildIndex(param1:DisplayObject) : int{return 0;}
      
      override public function get numChildren() : int{return 0;}
      
      private function changeScroll() : void{}
      
      private function get contentWidth() : Number{return 0;}
      
      private function get contentHeight() : Number{return 0;}
      
      private function setContentSize(param1:Number, param2:Number) : void{}
      
      override public function set width(param1:Number) : void{}
      
      override public function set height(param1:Number) : void{}
      
      public function get vScrollBarSkin() : String{return null;}
      
      public function set vScrollBarSkin(param1:String) : void{}
      
      public function get hScrollBarSkin() : String{return null;}
      
      public function set hScrollBarSkin(param1:String) : void{}
      
      public function get vScrollBar() : ScrollBar{return null;}
      
      public function get hScrollBar() : ScrollBar{return null;}
      
      public function get content() : Sprite{return null;}
      
      protected function onScrollBarChange(param1:Event) : void{}
      
      override public function commitMeasure() : void{}
      
      public function scrollTo(param1:Number = 0, param2:Number = 0) : void{}
      
      public function refresh() : void{}
      
      override public function dispose() : void{}
   }
}
