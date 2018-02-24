package chickActivation.view
{
   import chickActivation.ChickActivationManager;
   import chickActivation.event.ChickActivationEvent;
   import chickActivation.model.ChickActivationModel;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class ChickActivationLevelPacks extends Sprite implements Disposeable
   {
       
      
      public var packsLevelArr:Array;
      
      private var _arrData:Array;
      
      private var _progressLine1:Bitmap;
      
      private var _progressLine2:Bitmap;
      
      private var _drawProgress1Data:BitmapData;
      
      private var _drawProgress2Data:Bitmap;
      
      public function ChickActivationLevelPacks(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function __levelItemsClickHandler(param1:MouseEvent) : void{}
      
      public function update() : void{}
      
      private function updateProgressLine(param1:Bitmap, param2:int) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
