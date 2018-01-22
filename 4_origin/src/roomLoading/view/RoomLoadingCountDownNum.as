package roomLoading.view
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import room.RoomManager;
   
   public class RoomLoadingCountDownNum extends Sprite implements Disposeable
   {
       
      
      private var _numTxt:FilterFrameText;
      
      private var _num:int;
      
      private var _countDownBg:Bitmap;
      
      private var _bitmapDatas:Vector.<BitmapData>;
      
      private var _tenDigit:Bitmap;
      
      private var _digit:Bitmap;
      
      public function RoomLoadingCountDownNum()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         var _loc1_:int = 0;
         _num = RoomManager.Instance.current.type == 4 || RoomManager.Instance.current.type == 11 || RoomManager.Instance.current.type == 25 || RoomManager.Instance.current.type == 123?90:60;
         _countDownBg = ComponentFactory.Instance.creatBitmap("asset.roomloading.countDownBg");
         addChild(_countDownBg);
         _tenDigit = new Bitmap();
         _digit = new Bitmap();
         TweenMax.fromTo(_tenDigit,0.5,{
            "scaleX":0.5,
            "scaleY":0.5,
            "ease":Quint.easeIn,
            "alpha":0
         },{
            "scaleX":1,
            "scaleY":1,
            "alpha":1
         });
         TweenMax.fromTo(_digit,0.5,{
            "scaleX":0.5,
            "scaleY":0.5,
            "ease":Quint.easeIn,
            "alpha":0
         },{
            "scaleX":1,
            "scaleY":1,
            "alpha":1
         });
         _bitmapDatas = new Vector.<BitmapData>();
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            _bitmapDatas.push(ComponentFactory.Instance.creatBitmapData("asset.roomloading.countDownNum_" + _loc1_));
            _loc1_++;
         }
         updateNumView();
      }
      
      public function updateNum() : void
      {
         _num = Number(_num) - 1;
         if(_num < 0)
         {
            _num = 0;
         }
         updateNumView();
      }
      
      private function updateNumView() : void
      {
         _tenDigit.bitmapData = _bitmapDatas[int(_num / 10)];
         _digit.bitmapData = _bitmapDatas[_num % 10];
         PositionUtils.setPos(_tenDigit,"asset.roomloading.tenDigitPos");
         PositionUtils.setPos(_digit,"asset.roomloading.digitPos");
         addChild(_tenDigit);
         addChild(_digit);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_countDownBg);
         _countDownBg = null;
         var _loc3_:int = 0;
         var _loc2_:* = _bitmapDatas;
         for each(var _loc1_ in _bitmapDatas)
         {
            _loc1_.dispose();
         }
         TweenMax.killTweensOf(_tenDigit);
         ObjectUtils.disposeObject(_tenDigit);
         _tenDigit = null;
         TweenMax.killTweensOf(_digit);
         ObjectUtils.disposeObject(_digit);
         _digit = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
