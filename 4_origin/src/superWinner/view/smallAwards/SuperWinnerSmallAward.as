package superWinner.view.smallAwards
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class SuperWinnerSmallAward extends Sprite implements Disposeable
   {
       
      
      private var _type:uint;
      
      private var _awardNumTxt:FilterFrameText;
      
      public function SuperWinnerSmallAward(param1:uint)
      {
         _type = param1;
         super();
         init();
      }
      
      private function init() : void
      {
         var _loc1_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.superWinner.smallAward" + awardType);
         addChild(_loc1_);
         _awardNumTxt = ComponentFactory.Instance.creatComponentByStylename("superWinner.smallAwardTxt");
         addChild(_awardNumTxt);
         _awardNumTxt.text = "0";
      }
      
      public function set awardNum(param1:uint) : void
      {
         _awardNumTxt.text = param1 + "";
      }
      
      public function get awardType() : uint
      {
         return _type;
      }
      
      public function dispose() : void
      {
         ObjectUtils.removeChildAllChildren(this);
      }
   }
}
