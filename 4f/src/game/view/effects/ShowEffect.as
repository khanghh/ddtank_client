package game.view.effects
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class ShowEffect extends Sprite implements Disposeable
   {
      
      public static var GUARD:String = "guard";
       
      
      private var _type:String;
      
      private var _pic:DisplayObject;
      
      private var tmp:int = 0;
      
      private var add:Boolean = true;
      
      public function ShowEffect(param1:String){super();}
      
      private function init() : void{}
      
      private function enterFrameHandler(param1:Event) : void{}
      
      private function initPicture() : void{}
      
      public function dispose() : void{}
   }
}
