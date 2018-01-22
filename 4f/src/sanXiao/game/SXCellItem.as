package sanXiao.game
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import sanXiao.model.Pos;
   
   public class SXCellItem extends Sprite implements Disposeable
   {
      
      public static const IMMEDIATELY:String = "immediately";
      
      public static const TWEEN:String = "tween";
      
      public static const BACK:String = "back";
      
      public static var cellWidth:Number = 50;
      
      public static var cellHeight:Number = 49;
      
      public static var stepDistance:Number = 3;
       
      
      private var _curPos:Pos;
      
      protected var _tagPos:Pos;
      
      private var _tagY:Number = 0;
      
      private var _tagX:Number = 0;
      
      private var _icon:ScaleFrameImage;
      
      private var _boomEffect:MovieClip;
      
      private var _testText:FilterFrameText;
      
      private var _lightBorder:Bitmap;
      
      private var _columnDirection:Boolean;
      
      private var _rowDrection:Boolean;
      
      private var _step:Number = 17;
      
      private var _callBack:Function;
      
      public function SXCellItem(){super();}
      
      public function get curPos() : Pos{return null;}
      
      public function set curPos(param1:Pos) : void{}
      
      public function get tagPos() : Pos{return null;}
      
      public function set tagPos(param1:Pos) : void{}
      
      public function set type(param1:int) : void{}
      
      public function get type() : int{return 0;}
      
      public function boom() : void{}
      
      public function killBoom() : void{}
      
      protected function onEffectEnd(param1:Event) : void{}
      
      public function moveTo(param1:Pos, param2:String = "tween", param3:Function = null) : void{}
      
      private function TweenY() : void{}
      
      private function TweenX() : void{}
      
      private function onTweenComplete() : void{}
      
      public function set selected(param1:Boolean) : void{}
      
      public function dispose() : void{}
   }
}
