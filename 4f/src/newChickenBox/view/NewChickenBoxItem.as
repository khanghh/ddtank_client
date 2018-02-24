package newChickenBox.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import newChickenBox.data.NewChickenBoxGoodsTempInfo;
   
   public class NewChickenBoxItem extends Sprite
   {
       
      
      private var _bg:MovieClip;
      
      private var _cell:NewChickenBoxCell;
      
      private var _position:int;
      
      public var info:NewChickenBoxGoodsTempInfo;
      
      protected var _filterString:String;
      
      protected var _frameFilter:Array;
      
      protected var _currentFrameIndex:int = 1;
      
      protected var _tbxCount:FilterFrameText;
      
      public function NewChickenBoxItem(param1:NewChickenBoxCell, param2:MovieClip){super();}
      
      public function countTextShowIf() : void{}
      
      public function updateCount() : void{}
      
      public function setBg(param1:int) : void{}
      
      public function dispose() : void{}
      
      public function set filterString(param1:String) : void{}
      
      public function get frameFilter() : Array{return null;}
      
      public function set frameFilter(param1:Array) : void{}
      
      private function alphaItem(param1:Event) : void{}
      
      private function showItem(param1:Event) : void{}
      
      private function hideItem(param1:Event) : void{}
      
      public function get cell() : NewChickenBoxCell{return null;}
      
      public function set cell(param1:NewChickenBoxCell) : void{}
      
      public function get bg() : MovieClip{return null;}
      
      public function set bg(param1:MovieClip) : void{}
      
      public function get position() : int{return 0;}
      
      public function set position(param1:int) : void{}
      
      public function setFrame(param1:int) : void{}
      
      private function __onMouseRollout(param1:MouseEvent) : void{}
      
      private function __onMouseRollover(param1:MouseEvent) : void{}
      
      protected function addEvent() : void{}
      
      protected function removeEvent() : void{}
   }
}
