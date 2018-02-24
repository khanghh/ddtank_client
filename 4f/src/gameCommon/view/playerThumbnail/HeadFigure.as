package gameCommon.view.playerThumbnail
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PathManager;
   import ddt.view.character.ShowCharacter;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import gameCommon.GameControl;
   import gameCommon.model.Living;
   import gameCommon.model.Player;
   import gameCommon.model.SimpleBoss;
   
   public class HeadFigure extends Sprite implements Disposeable
   {
       
      
      private var _head:Bitmap;
      
      private var _headC:Sprite;
      
      private var _info:Player;
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var _living:Living;
      
      private var _defaultFace:BitmapData;
      
      private var _isGray:Boolean = false;
      
      private var _displayLoader:DisplayLoader;
      
      public function HeadFigure(param1:Number, param2:Number, param3:Object = null){super();}
      
      private function initFigure() : void{}
      
      private function initLivingHead() : void{}
      
      private function __onLoaderComplete(param1:LoaderEvent) : void{}
      
      private function bitmapChange(param1:Event) : void{}
      
      private function drawHead(param1:BitmapData) : void{}
      
      private function getHeadRect() : Rectangle{return null;}
      
      public function gray() : void{}
      
      public function reset() : void{}
      
      public function dispose() : void{}
   }
}
