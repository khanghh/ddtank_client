package gameStarling.view.effects
{
   import com.pickgliss.utils.StarlingObjectUtils;
   import road7th.StarlingMain;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class ShowEffect3D extends Sprite
   {
      
      public static var GUARD:String = "guard";
       
      
      private var _type:String;
      
      private var _pic:Image;
      
      private var tmp:int = 0;
      
      private var add:Boolean = true;
      
      public function ShowEffect3D(param1:String)
      {
         super();
         _type = param1;
         init();
      }
      
      private function init() : void
      {
         initPicture();
         if(_pic)
         {
            addChild(_pic);
            addEventListener("enterFrame",enterFrameHandler);
         }
         else
         {
            dispose();
         }
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
         if(GUARD === _loc1_)
         {
            _pic = StarlingMain.instance.createImage("game_effect_guardAsset");
         }
      }
      
      override public function dispose() : void
      {
         removeEventListener("enterFrame",enterFrameHandler);
         if(parent)
         {
            parent.removeChild(this);
         }
         StarlingObjectUtils.disposeObject(_pic);
         _pic = null;
         super.dispose();
      }
   }
}
