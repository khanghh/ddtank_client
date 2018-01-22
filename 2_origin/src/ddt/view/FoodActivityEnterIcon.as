package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import foodActivity.FoodActivityManager;
   
   public class FoodActivityEnterIcon extends Sprite implements Disposeable
   {
       
      
      private var _foodActivityIcon:MovieImage;
      
      private var _foodActivityTxt:FilterFrameText;
      
      private var _timeBg:Bitmap;
      
      private var _timeTxt:FilterFrameText;
      
      private var _timeSp:Sprite;
      
      private var _minutesArr:Array;
      
      public function FoodActivityEnterIcon()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _foodActivityIcon = ComponentFactory.Instance.creat("hall.foodActivityBtn");
         _foodActivityIcon.buttonMode = true;
         addChild(_foodActivityIcon);
         _foodActivityTxt = ComponentFactory.Instance.creatComponentByStylename("hall.foodActivity.countTxt");
         _foodActivityTxt.x = 68;
         _foodActivityTxt.y = 3;
         _foodActivityTxt.text = "" + FoodActivityManager.Instance.cookingCount;
         addChild(_foodActivityTxt);
         _timeSp = new Sprite();
         _timeBg = ComponentFactory.Instance.creatBitmap("foodActivity.timeBGAsset");
         _timeTxt = ComponentFactory.Instance.creat("foodActivity.TimeBoxStyle");
         _timeTxt.x = _timeBg.x + (_timeBg.width - _timeTxt.width) / 2;
         _timeTxt.y = _timeBg.y + 1;
         _timeSp.addChild(_timeBg);
         _timeSp.addChild(_timeTxt);
         addChild(_timeSp);
         _timeSp.visible = false;
      }
      
      public function showTxt() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Array = FoodActivityManager.Instance.info.remain2.split("|");
         _minutesArr = [];
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _minutesArr.push(_loc1_[_loc2_].split(",")[0]);
            _loc2_++;
         }
         if(FoodActivityManager.Instance.cookingCount == 0 && FoodActivityManager.Instance.state == 0)
         {
            FoodActivityManager.Instance.startTime();
         }
         else
         {
            FoodActivityManager.Instance.endTime();
         }
      }
      
      public function set text(param1:String) : void
      {
         _foodActivityTxt.text = param1;
      }
      
      public function startTime(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _timeSp.visible = true;
         if(FoodActivityManager.Instance.sumTime > 0)
         {
            updateTime();
            return;
         }
         if(param1)
         {
            _loc2_ = FoodActivityManager.Instance.delayTime;
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < _minutesArr.length)
            {
               if(FoodActivityManager.Instance.currentSumTime < _minutesArr[_loc3_])
               {
                  _loc2_ = _minutesArr[_loc3_] - FoodActivityManager.Instance.currentSumTime;
                  break;
               }
               _loc3_++;
            }
         }
         if(_loc2_ == 0)
         {
            FoodActivityManager.Instance.endTime();
            return;
         }
         FoodActivityManager.Instance.sumTime = _loc2_ * 60;
         updateTime();
      }
      
      public function updateTime() : void
      {
         var _loc1_:int = FoodActivityManager.Instance.sumTime / 60;
         var _loc3_:int = FoodActivityManager.Instance.sumTime % 60;
         var _loc2_:String = "";
         if(_loc1_ < 10)
         {
            _loc2_ = _loc2_ + ("0" + _loc1_);
         }
         else
         {
            _loc2_ = _loc2_ + _loc1_;
         }
         _loc2_ = _loc2_ + ":";
         if(_loc3_ < 10)
         {
            _loc2_ = _loc2_ + ("0" + _loc3_);
         }
         else
         {
            _loc2_ = _loc2_ + _loc3_;
         }
         _timeTxt.text = _loc2_;
      }
      
      public function endTime() : void
      {
         _timeSp.visible = false;
      }
      
      protected function __showFoodActivityFrame(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         FoodActivityManager.Instance.show();
      }
      
      private function initEvent() : void
      {
         _foodActivityIcon.addEventListener("click",__showFoodActivityFrame);
      }
      
      private function removeEvent() : void
      {
         _foodActivityIcon.removeEventListener("click",__showFoodActivityFrame);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_foodActivityIcon);
         _foodActivityIcon = null;
         ObjectUtils.disposeObject(_foodActivityTxt);
         _foodActivityTxt = null;
         ObjectUtils.disposeObject(_timeBg);
         _timeBg = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_timeSp);
         _timeSp = null;
      }
   }
}
