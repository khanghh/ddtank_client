package gameCommon.view.experience
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class ExpTotalNums extends Sprite implements Disposeable
   {
      
      public static const EXPERIENCE:uint = 0;
      
      public static const EXPLOIT:uint = 1;
       
      
      public var maxValue:int;
      
      private var _value:int;
      
      private var _type:int;
      
      private var _bg:MovieClip;
      
      private var _operator:Bitmap;
      
      private var _bitmaps:Vector.<Bitmap>;
      
      private var _bitmapDatas:Vector.<BitmapData>;
      
      public function ExpTotalNums(param1:int){super();}
      
      private function init() : void{}
      
      public function playLight() : void{}
      
      public function setValue(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
