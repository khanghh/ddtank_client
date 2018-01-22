package powerUp
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class NumMovieSprite extends Sprite implements Disposeable
   {
       
      
      private var _powerNum:int;
      
      private var _powerString:String;
      
      private var _addPowerNum:int;
      
      private var _allPowerNum:int;
      
      private var _allPowerString:String;
      
      private var _iconArr:Array;
      
      private var _iconArr2:Array;
      
      private var _moveNumArr:Array;
      
      private var _frame:int;
      
      public function NumMovieSprite(param1:int, param2:int){super();}
      
      protected function __updateNumHandler(param1:Event) : void{}
      
      private function initView() : void{}
      
      public function dispose() : void{}
   }
}
