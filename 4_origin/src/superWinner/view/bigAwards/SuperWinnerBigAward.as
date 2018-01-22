package superWinner.view.bigAwards
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class SuperWinnerBigAward extends Sprite implements Disposeable
   {
       
      
      private var _type:uint;
      
      private var _awardNumTxt:FilterFrameText;
      
      private const MAX_AWARD_NUM:Array = [32,16,8,4,2,1];
      
      public function SuperWinnerBigAward(param1:uint)
      {
         _type = param1;
         super();
         init();
      }
      
      private function init() : void
      {
         var _loc1_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.superWinner.bigAward" + awardType);
         addChild(_loc1_);
         _awardNumTxt = ComponentFactory.Instance.creatComponentByStylename("superWinner.bigAwardTxt");
         addChild(_awardNumTxt);
         _awardNumTxt.text = "0/" + MAX_AWARD_NUM[awardType - 1];
      }
      
      public function set awardNum(param1:uint) : void
      {
         _awardNumTxt.text = param1 + "/" + MAX_AWARD_NUM[awardType - 1];
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
