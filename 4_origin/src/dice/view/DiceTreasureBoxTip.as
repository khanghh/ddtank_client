package dice.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import dice.controller.DiceController;
   import dice.vo.DiceAwardCell;
   import dice.vo.DiceAwardInfo;
   import flash.display.Sprite;
   
   public class DiceTreasureBoxTip extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _line:ScaleBitmapImage;
      
      private var _script:FilterFrameText;
      
      public function DiceTreasureBoxTip()
      {
         super();
         preInitialize();
         initialize();
         addEvent();
      }
      
      private function preInitialize() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("asset.dice.treasureBox.tip.BG");
         _line = ComponentFactory.Instance.creatComponentByStylename("asset.dice.treasureBox.tip.line");
         _script = ComponentFactory.Instance.creatComponentByStylename("asset.dice.treasureBox.tip.script");
      }
      
      public function update() : void
      {
         removeAllChildren();
         initialize();
      }
      
      private function removeAllChildren() : void
      {
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
      }
      
      private function initialize() : void
      {
         addChild(_bg);
         addChild(_line);
         addChild(_script);
         _script.text = LanguageMgr.GetTranslation("dice.treasureBoxTip.script",DiceController.Instance.LuckIntegralLevel + 1);
         addAwardList();
      }
      
      private function addAwardList() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Vector.<DiceAwardCell> = (DiceController.Instance.AwardLevelInfo[DiceController.Instance.LuckIntegralLevel] as DiceAwardInfo).templateInfo;
         var _loc2_:int = 0;
         if(_loc1_ != null)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc1_.length)
            {
               if(_loc1_[_loc3_])
               {
                  _loc2_++;
                  _loc1_[_loc3_].x = 10;
                  _loc1_[_loc3_].y = _loc2_ * 47 + 11;
                  addChild(_loc1_[_loc3_]);
               }
               _loc3_++;
            }
            _bg.height = _loc1_[_loc3_ - 1].y + 55;
         }
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
      }
   }
}
