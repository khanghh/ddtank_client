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
         var i:int = 0;
         var temp:Array = FoodActivityManager.Instance.info.remain2.split("|");
         _minutesArr = [];
         for(i = 0; i < temp.length; )
         {
            _minutesArr.push(temp[i].split(",")[0]);
            i++;
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
      
      public function set text(value:String) : void
      {
         _foodActivityTxt.text = value;
      }
      
      public function startTime(isUpdateCount:Boolean = false) : void
      {
         var minutes:int = 0;
         var i:int = 0;
         _timeSp.visible = true;
         if(FoodActivityManager.Instance.sumTime > 0)
         {
            updateTime();
            return;
         }
         if(isUpdateCount)
         {
            minutes = FoodActivityManager.Instance.delayTime;
         }
         else
         {
            i = 0;
            while(i < _minutesArr.length)
            {
               if(FoodActivityManager.Instance.currentSumTime < _minutesArr[i])
               {
                  minutes = _minutesArr[i] - FoodActivityManager.Instance.currentSumTime;
                  break;
               }
               i++;
            }
         }
         if(minutes == 0)
         {
            FoodActivityManager.Instance.endTime();
            return;
         }
         FoodActivityManager.Instance.sumTime = minutes * 60;
         updateTime();
      }
      
      public function updateTime() : void
      {
         var _minute:int = FoodActivityManager.Instance.sumTime / 60;
         var _second:int = FoodActivityManager.Instance.sumTime % 60;
         var str:String = "";
         if(_minute < 10)
         {
            str = str + ("0" + _minute);
         }
         else
         {
            str = str + _minute;
         }
         str = str + ":";
         if(_second < 10)
         {
            str = str + ("0" + _second);
         }
         else
         {
            str = str + _second;
         }
         _timeTxt.text = str;
      }
      
      public function endTime() : void
      {
         _timeSp.visible = false;
      }
      
      protected function __showFoodActivityFrame(event:MouseEvent) : void
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
