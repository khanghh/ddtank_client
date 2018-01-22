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
      
      public function ShowEffect(param1:String)
      {
         super();
         _type = param1;
         init();
      }
      
      private function init() : void
      {
         initPicture();
         addChild(_pic);
         addEventListener("enterFrame",enterFrameHandler);
      }
      
      private function enterFrameHandler(param1:Event) : void
      {
         if(_pic.alpha > 0.95)
         {
            tmp = Number(tmp) + 1;
            if(tmp == 20)
            {
               add = false;
               _pic.alpha = 0.9;
            }
         }
         if(_pic.alpha < 1)
         {
            if(add)
            {
               _pic.y = _pic.y - 8;
               _pic.alpha = _pic.alpha + 0.22;
            }
            else
            {
               _pic.y = _pic.y - 6;
               _pic.alpha = _pic.alpha - 0.1;
            }
         }
         if(_pic.alpha < 0.05)
         {
            dispose();
         }
      }
      
      private function initPicture() : void
      {
         var _loc1_:* = _type;
         if(GUARD !== _loc1_)
         {
            _pic = new MovieClip();
         }
         else
         {
            _pic = ComponentFactory.Instance.creatBitmap("asset.game.guardAsset") as Bitmap;
         }
      }
      
      public function dispose() : void
      {
         removeEventListener("enterFrame",enterFrameHandler);
         if(parent)
         {
            parent.removeChild(this);
         }
         _pic = null;
      }
   }
}
