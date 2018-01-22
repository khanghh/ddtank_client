package gameCommon.view.playerThumbnail
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import gameCommon.model.Living;
   
   public class BloodItem extends Sprite implements Disposeable
   {
       
      
      private var _width:int;
      
      private var _totalBlood:int;
      
      private var _bloodNum:int;
      
      private var _bg:Bitmap;
      
      private var _HPStrip:Bitmap;
      
      private var _healthShape:Shape;
      
      private var _visibleRect:Rectangle;
      
      private var _living:Living;
      
      public function BloodItem(param1:int, param2:int){super();}
      
      public function setProgress(param1:int, param2:int) : void{}
      
      public function set bloodNum(param1:int) : void{}
      
      private function updateView() : void{}
      
      public function dispose() : void{}
   }
}
