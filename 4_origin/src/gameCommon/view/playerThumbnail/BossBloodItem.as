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
      
      public function BossBloodItem(param1:Number)
      {
         super();
         _totalBlood = param1;
         _bloodNum = param1;
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
      
      public function set bloodNum(param1:Number) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         else if(param1 > _totalBlood)
         {
            param1 = Number(_totalBlood);
         }
         _bloodNum = param1;
         updateView();
      }
      
      public function updateBlood(param1:Number, param2:Number) : void
      {
         _bloodNum = param1;
         if(_bloodNum < 0)
         {
            _bloodNum = 0;
         }
         _totalBlood = param2;
         if(_totalBlood < _bloodNum)
         {
            _totalBlood = _bloodNum;
         }
         updateView();
      }
      
      private function updateView() : void
      {
         var _loc1_:int = getRate(_bloodNum,_totalBlood);
         _rateTxt.text = _loc1_.toString() + "%";
         _maskShape.width = 120 * (_loc1_ / 100);
         _bg.mask = _maskShape;
      }
      
      private function getRate(param1:Number, param2:Number) : int
      {
         var _loc3_:* = Number(param1 / param2 * 100);
         if(_loc3_ > 0 && _loc3_ < 1)
         {
            _loc3_ = 1;
         }
         return int(_loc3_);
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
