package wonderfulActivity.items
{
   import com.gskinner.geom.ColorMatrix;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.GlowFilter;
   
   public class AccumulativeItem extends Component implements Disposeable
   {
       
      
      private var _box:MovieClip;
      
      private var _numberBG:Bitmap;
      
      private var _number:FilterFrameText;
      
      private var _progressPoint:Bitmap;
      
      private var _questionMark:FilterFrameText;
      
      private var glintFilter:GlowFilter;
      
      private var lightFilter:ColorMatrixFilter;
      
      private var grayFilters:Array;
      
      public var index:int;
      
      private var tempfilters:Array;
      
      private var glintFlag:Boolean = true;
      
      public function AccumulativeItem(){super();}
      
      private function initFilter() : void{}
      
      public function initView(param1:int) : void{}
      
      public function lightProgressPoint() : void{}
      
      public function setNumber(param1:int) : void{}
      
      public function turnGray(param1:Boolean) : void{}
      
      public function turnLight(param1:Boolean) : void{}
      
      public function glint(param1:Boolean) : void{}
      
      private function __enterFrame(param1:Event) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
      
      public function get box() : MovieClip{return null;}
   }
}
