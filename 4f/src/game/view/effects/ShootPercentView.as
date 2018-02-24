package game.view.effects
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gameCommon.BloodNumberCreater;
   
   public class ShootPercentView extends Sprite
   {
       
      
      private var _type:int;
      
      private var _isAdd:Boolean;
      
      private var _picBmp:Bitmap;
      
      private var add:Boolean = true;
      
      private var tmp:int = 0;
      
      public function ShootPercentView(param1:int, param2:int = 1, param3:Boolean = false){super();}
      
      public function dispose() : void{}
      
      private function __addToStage(param1:Event) : void{}
      
      private function __enterFrame(param1:Event) : void{}
      
      private function doShowType1() : void{}
      
      private function doShowType2() : void{}
      
      public function getPercent(param1:int) : Bitmap{return null;}
      
      private function returnNum(param1:Array) : Array{return null;}
   }
}
