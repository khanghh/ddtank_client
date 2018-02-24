package roomLoading.view
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Sine;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import room.RoomManager;
   
   public class RoomLoadingVersusItem extends Sprite implements Disposeable
   {
       
      
      private var _gameType:Bitmap;
      
      private var _gameTypeBg:Bitmap;
      
      private var _versusMc:DisplayObject;
      
      private var _gameMode:int;
      
      private var _glowFilter:GlowFilter;
      
      private var _survival:Bitmap;
      
      public function RoomLoadingVersusItem(param1:int){super();}
      
      private function init() : void{}
      
      private function addEffect() : void{}
      
      private function updateFilter() : void{}
      
      private function createGameModeTxt() : void{}
      
      public function dispose() : void{}
   }
}
