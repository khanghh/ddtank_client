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
      
      public function BloodItem(param1:int, param2:int)
      {
         super();
         _bg = ComponentFactory.Instance.creatBitmap("asset.game.smallplayer.BloodBack");
         addChild(_bg);
         _HPStrip = ComponentFactory.Instance.creatBitmap("asset.game.smallplayer.BloodFore");
         addChild(_HPStrip);
         _width = _HPStrip.width;
         _totalBlood = param2;
         _bloodNum = param1;
         _visibleRect = new Rectangle(0,0,_HPStrip.width,_HPStrip.height);
         _HPStrip.scrollRect = _visibleRect;
         setProgress(_bloodNum,_totalBlood);
      }
      
      public function setProgress(param1:int, param2:int) : void
      {
         _visibleRect.width = _width * param1 / param2;
         _HPStrip.scrollRect = _visibleRect;
      }
      
      public function set bloodNum(param1:int) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         else if(param1 > _totalBlood)
         {
            param1 = _totalBlood;
         }
         _bloodNum = param1;
         updateView();
      }
      
      private function updateView() : void
      {
         _visibleRect.width = Math.floor(_HPStrip.width * _bloodNum / _totalBlood);
         _HPStrip.scrollRect = _visibleRect;
      }
      
      public function dispose() : void
      {
         removeChild(_bg);
         _bg.bitmapData.dispose();
         _bg = null;
         removeChild(_HPStrip);
         _HPStrip.bitmapData.dispose();
         _HPStrip = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
