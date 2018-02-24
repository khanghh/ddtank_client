package magpieBridge.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import ddtBuried.data.MapItemData;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import magpieBridge.MagpieBridgeManager;
   
   public class MagpieBridgeMap extends Sprite implements Disposeable
   {
      
      private static const ICON_WIDTH:int = 70;
       
      
      private var _mapArray:Array;
      
      private var _mapVec:Vector.<Sprite>;
      
      private var _light:MovieClip;
      
      public function MagpieBridgeMap(){super();}
      
      private function initView() : void{}
      
      private function creatMap() : void{}
      
      private function addProps() : void{}
      
      public function closeIcon() : void{}
      
      private function getIconPos(param1:Sprite, param2:Sprite, param3:int) : Point{return null;}
      
      public function dispose() : void{}
      
      public function get mapVec() : Vector.<Sprite>{return null;}
   }
}
