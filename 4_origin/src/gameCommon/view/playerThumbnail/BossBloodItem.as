package gameCommon.view.playerThumbnail
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class BossBloodItem extends Sprite implements Disposeable
   {
       
      
      private var _totalBlood:Number;
      
      private var _bloodNum:Number;
      
      private var _maskShape:Shape;
      
      private var _HPTxt:FilterFrameText;
      
      private var _bg:Bitmap;
      
      private var _rateTxt:FilterFrameText;
      
      public function BossBloodItem(totalBlood:Number)
      {
         super();
         _totalBlood = totalBlood;
         _bloodNum = totalBlood;
         _bg = ComponentFactory.Instance.creatBitmap("asset.game.bossHpStripAsset");
         addChild(_bg);
         _maskShape = new Shape();
         _maskShape.x = 13;
         _maskShape.y = 7;
         _maskShape.graphics.beginFill(0,1);
         _maskShape.graphics.drawRect(0,0,120,25);
         _maskShape.graphics.endFill();
         _bg.mask = _maskShape;
         addChild(_maskShape);
         _rateTxt = ComponentFactory.Instance.creatComponentByStylename("asset.bossHPStripRateTxt");
         addChild(_rateTxt);
         _rateTxt.text = "100%";
      }
      
      public function set bloodNum(value:Number) : void
      {
         if(value < 0)
         {
            value = 0;
         }
         else if(value > _totalBlood)
         {
            value = Number(_totalBlood);
         }
         _bloodNum = value;
         updateView();
      }
      
      public function updateBlood(current:Number, max:Number) : void
      {
         _bloodNum = current;
         if(_bloodNum < 0)
         {
            _bloodNum = 0;
         }
         _totalBlood = max;
         if(_totalBlood < _bloodNum)
         {
            _totalBlood = _bloodNum;
         }
         updateView();
      }
      
      private function updateView() : void
      {
         var rate:int = getRate(_bloodNum,_totalBlood);
         _rateTxt.text = rate.toString() + "%";
         _maskShape.width = 120 * (rate / 100);
         _bg.mask = _maskShape;
      }
      
      private function getRate(value1:Number, value2:Number) : int
      {
         var rate:* = Number(value1 / value2 * 100);
         if(rate > 0 && rate < 1)
         {
            rate = 1;
         }
         return int(rate);
      }
      
      public function dispose() : void
      {
         removeChild(_bg);
         _bg.bitmapData.dispose();
         _bg = null;
         removeChild(_maskShape);
         _maskShape = null;
         if(_HPTxt)
         {
            _HPTxt.dispose();
            _HPTxt = null;
         }
         ObjectUtils.disposeObject(_rateTxt);
         _rateTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
