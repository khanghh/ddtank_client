package cloudBuyLottery.view
{
   import cloudBuyLottery.CloudBuyLotteryManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class ExpBar extends Sprite implements Disposeable
   {
       
      
      protected var _groudPic:Bitmap;
      
      protected var _curPic:Bitmap;
      
      private var _totalLen:int;
      
      protected var _expBarTxt:FilterFrameText;
      
      protected var _maskMC:Sprite;
      
      private var _per:Number = 0;
      
      public var curNum:int = 0;
      
      public var totalNum:int = 0;
      
      public var id:int;
      
      public var stylename:String;
      
      protected var _oldX:int;
      
      public function ExpBar(){super();}
      
      public function beginChanges() : void{}
      
      public function commitChanges() : void{}
      
      public function initView() : void{}
      
      public function initBar(param1:int, param2:int, param3:Boolean = false) : void{}
      
      public function upData(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
