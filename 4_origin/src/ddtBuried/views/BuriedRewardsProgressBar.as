package ddtBuried.views
{
   import bagAndInfo.cell.BaseCell;
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.utils.Helpers;
   import ddt.utils.PositionUtils;
   import ddtBuried.BuriedControl;
   import ddtBuried.BuriedManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class BuriedRewardsProgressBar extends Sprite
   {
       
      
      private var _bg:Bitmap;
      
      private var _progressBarList:Vector.<Bitmap>;
      
      private var _boxList:Vector.<SimpleBitmapButton>;
      
      private var _progressTextField:FilterFrameText;
      
      private var _gainedSignList:Vector.<Bitmap>;
      
      private var _boxOpenedList:Vector.<Bitmap>;
      
      private var _boxPlayOpenList:Vector.<MovieClip>;
      
      private var _boxCanGainList:Vector.<MovieClip>;
      
      private var _tipList:Vector.<BaseCell>;
      
      public function BuriedRewardsProgressBar()
      {
         super();
         init();
      }
      
      protected function init() : void
      {
         var i:int = 0;
         var len:int = 0;
         var bg:* = null;
         var factory:ComponentFactory = ComponentFactory.Instance;
         _bg = factory.creat("buried.progressBG");
         _bg.x = -130;
         addChild(_bg);
         _progressBarList = new Vector.<Bitmap>();
         len = 5;
         for(i = 0; i < len; )
         {
            _progressBarList[i] = factory.creatBitmap("buried.progressbar");
            PositionUtils.setPos(_progressBarList[i],"ddtburied.progressBar.pos" + i.toString());
            addChild(_progressBarList[i]);
            i++;
         }
         _progressTextField = factory.creat("ddtburied.progressBar");
         _progressTextField.y = 25;
         addChild(_progressTextField);
         _boxList = new Vector.<SimpleBitmapButton>();
         len = 5;
         for(i = 0; i < len; )
         {
            _boxList[i] = factory.creat("buried.rewardboxBtn" + i.toString());
            _boxList[i].mouseEnabled = false;
            _boxList[i].mouseChildren = false;
            PositionUtils.setPos(_boxList[i],"ddtburied.box.pos" + i.toString());
            _boxList[i].enable = true;
            addChild(_boxList[i]);
            i++;
         }
         _boxOpenedList = new Vector.<Bitmap>();
         len = 5;
         for(i = 0; i < len; )
         {
            _boxOpenedList[i] = factory.creatBitmap("buired.bmp.opened" + i.toString());
            PositionUtils.setPos(_boxOpenedList[i],"ddtburied.boxOpened.pos" + i.toString());
            Helpers.grey(_boxOpenedList[i]);
            _boxOpenedList[i].visible = false;
            addChild(_boxOpenedList[i]);
            i++;
         }
         _gainedSignList = new Vector.<Bitmap>();
         len = 5;
         for(i = 0; i < len; )
         {
            _gainedSignList[i] = factory.creatBitmap("buried.alreadyGet");
            PositionUtils.setPos(_gainedSignList[i],"ddtburied.box.pos" + i.toString());
            _gainedSignList[i].x = _gainedSignList[i].x + 10;
            _gainedSignList[i].y = 12;
            _gainedSignList[i].visible = true;
            addChild(_gainedSignList[i]);
            i++;
         }
         _boxPlayOpenList = new Vector.<MovieClip>();
         for(i = 0; i < len; )
         {
            _boxPlayOpenList[i] = factory.creat("buried.mc.open" + i.toString());
            PositionUtils.setPos(_boxPlayOpenList[i],"ddtburied.boxOpened.pos" + i.toString());
            _boxPlayOpenList[i].visible = false;
            var _loc6_:Boolean = false;
            _boxPlayOpenList[i].mouseEnabled = _loc6_;
            _boxPlayOpenList[i].mouseChildren = _loc6_;
            _boxPlayOpenList[i].stop();
            addChild(_boxPlayOpenList[i]);
            i++;
         }
         _boxCanGainList = new Vector.<MovieClip>();
         for(i = 0; i < len; )
         {
            _boxCanGainList[i] = factory.creat("buired.mc.canGain" + i.toString());
            PositionUtils.setPos(_boxCanGainList[i],"ddtburied.boxOpened.pos" + i.toString());
            _boxCanGainList[i].visible = false;
            _boxCanGainList[i].stop();
            addChild(_boxCanGainList[i]);
            _boxCanGainList[i].useHandCursor = true;
            _boxCanGainList[i].buttonMode = true;
            _boxCanGainList[i].name = i.toString();
            _boxCanGainList[i].mouseChildren = false;
            i++;
         }
         _tipList = new Vector.<BaseCell>();
         var rewardsIDs:Array = BuriedControl.Instance.reachEndRewardsIDs;
         for(i = 0; i < len; )
         {
            bg = new Shape();
            bg.graphics.beginFill(0,0.2);
            bg.graphics.drawRect(0,0,70,70);
            bg.graphics.endFill();
            _tipList[i] = new BaseCell(bg,ItemManager.Instance.getTemplateById(rewardsIDs[i]));
            _tipList[i].alpha = 0;
            _tipList[i].name = i.toString();
            _tipList[i].mouseChildren = false;
            _tipList[i].useHandCursor = true;
            _tipList[i].buttonMode = true;
            _tipList[i].addEventListener("click",onGainBtnClick);
            PositionUtils.setPos(_tipList[i],"ddtburied.boxTips.pos" + i.toString());
            addChild(_tipList[i]);
            i++;
         }
         factory = null;
      }
      
      protected function onGainBtnClick(e:MouseEvent) : void
      {
         var i:int = 0;
         var len:int = _boxCanGainList.length;
         for(i = 0; i < len; )
         {
            if(e.target["name"] == i.toString() && _boxCanGainList[i].visible == true)
            {
               BuriedControl.Instance.requireGainRewards(i);
               break;
            }
            i++;
         }
      }
      
      public function dispose() : void
      {
         if(_bg != null)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_progressBarList != null)
         {
            var _loc9_:int = 0;
            var _loc8_:* = _progressBarList;
            for each(var v in _progressBarList)
            {
               ObjectUtils.disposeObject(v);
            }
            _progressBarList.length = 0;
            _progressBarList = null;
         }
         if(_boxList != null)
         {
            var _loc11_:int = 0;
            var _loc10_:* = _boxList;
            for each(var btn in _boxList)
            {
               ObjectUtils.disposeObject(btn);
            }
            _boxList.length = 0;
            _boxList = null;
         }
         if(_progressTextField != null)
         {
            ObjectUtils.disposeObject(_progressTextField);
            _progressTextField = null;
         }
         if(_gainedSignList != null)
         {
            var _loc13_:int = 0;
            var _loc12_:* = _gainedSignList;
            for each(var g in _gainedSignList)
            {
               ObjectUtils.disposeObject(g);
            }
            _gainedSignList.length = 0;
            _gainedSignList = null;
         }
         if(_boxOpenedList != null)
         {
            var _loc15_:int = 0;
            var _loc14_:* = _boxOpenedList;
            for each(var b in _boxOpenedList)
            {
               ObjectUtils.disposeObject(b);
            }
            _boxOpenedList.length = 0;
            _boxOpenedList = null;
         }
         if(_boxPlayOpenList != null)
         {
            var _loc17_:int = 0;
            var _loc16_:* = _boxPlayOpenList;
            for each(var bo in _boxPlayOpenList)
            {
               bo.stop();
               ObjectUtils.disposeObject(bo);
            }
            _boxPlayOpenList.length = 0;
            _boxPlayOpenList = null;
         }
         if(_boxCanGainList != null)
         {
            var _loc19_:int = 0;
            var _loc18_:* = _boxCanGainList;
            for each(var bcg in _boxCanGainList)
            {
               bcg.stop();
               ObjectUtils.disposeObject(bcg);
            }
            _boxCanGainList.length = 0;
            _boxCanGainList = null;
         }
         if(_tipList != null)
         {
            var _loc21_:int = 0;
            var _loc20_:* = _tipList;
            for each(var tl in _tipList)
            {
               tl.removeEventListener("click",onGainBtnClick);
               ObjectUtils.disposeObject(tl);
            }
            _tipList.length = 0;
            _tipList = null;
         }
      }
      
      public function updateProgressState() : void
      {
         var i:int = 0;
         var maxTimes:int = BuriedManager.Instance.maxTimesCanGainRewards;
         var reachEndTimes:int = Math.min(BuriedManager.Instance.timesReachEnd,maxTimes);
         var timesList:Array = BuriedManager.Instance.boxNeedTimesList;
         var _loc11_:int = 0;
         var _loc10_:* = _progressBarList;
         for each(var bmp in _progressBarList)
         {
            bmp.visible = false;
         }
         if(reachEndTimes < timesList[0])
         {
            maxTimes = timesList[0];
            _progressTextField.x = -59;
         }
         if(reachEndTimes >= timesList[0])
         {
            maxTimes = timesList[1];
            _progressTextField.x = 69;
            _progressBarList[0].visible = true;
            _progressBarList[0].scaleX = 1;
         }
         if(reachEndTimes >= timesList[1])
         {
            maxTimes = timesList[2];
            _progressTextField.x = 199;
            _progressBarList[1].visible = true;
            _progressBarList[1].scaleX = 1;
         }
         if(reachEndTimes >= timesList[2])
         {
            maxTimes = timesList[3];
            _progressTextField.x = 327;
            _progressBarList[2].visible = true;
            _progressBarList[2].scaleX = 1;
         }
         if(reachEndTimes >= timesList[3])
         {
            maxTimes = timesList[4];
            _progressTextField.x = 459;
            _progressBarList[3].visible = true;
            _progressBarList[3].scaleX = 1;
         }
         if(reachEndTimes >= timesList[4])
         {
            maxTimes = timesList[4];
            _progressBarList[4].visible = true;
            _progressBarList[4].scaleX = 1;
         }
         _progressTextField.text = reachEndTimes.toString() + "/" + maxTimes;
         var tempRewardsStates:int = BuriedManager.Instance.stateRewardsGained;
         var tempRewardsString:String = tempRewardsStates.toString(2);
         var tempRewardsStateList:Array = tempRewardsString.split("");
         while(tempRewardsStateList.length < 5)
         {
            tempRewardsStateList.unshift("0");
         }
         tempRewardsStateList.reverse();
         var flag:* = 0;
         for(i = 0; i < 5; )
         {
            if(tempRewardsStateList[i] == "0")
            {
               if(reachEndTimes < BuriedManager.Instance.boxNeedTimesList[i])
               {
                  _boxList[i].visible = true;
                  _boxCanGainList[i].visible = false;
                  _boxCanGainList[i].stop();
                  _boxOpenedList[i].visible = false;
                  _gainedSignList[i].visible = false;
               }
               else
               {
                  flag = i;
                  _boxList[i].visible = false;
                  _boxCanGainList[i].visible = true;
                  _boxCanGainList[i].play();
                  _boxOpenedList[i].visible = false;
                  _gainedSignList[i].visible = false;
                  addChild(_gainedSignList[i]);
               }
            }
            else
            {
               _boxList[i].visible = false;
               _boxCanGainList[i].visible = false;
               _boxCanGainList[i].stop();
               _boxOpenedList[i].visible = true;
               _gainedSignList[i].visible = true;
            }
            i++;
         }
      }
      
      public function playGainBox(index:int) : void
      {
         index = index;
         onEF = function(e:Event):void
         {
            if(mc.currentFrame == mc.totalFrames)
            {
               mc.removeEventListener("enterFrame",onEF);
               mc.visible = false;
               mc.stop();
               mc = null;
               updateProgressState();
            }
         };
         _boxList[index].visible = false;
         _boxCanGainList[index].visible = false;
         var mc:MovieClip = _boxPlayOpenList[index];
         mc.visible = true;
         mc.addEventListener("enterFrame",onEF);
         mc.gotoAndPlay(1);
      }
      
      public function playGetRewardBoxAnimation(index:int) : void
      {
         index = index;
         showCanGainBox = function():void
         {
            _boxList[index].visible = false;
            _boxCanGainList[index].visible = true;
            _boxCanGainList[index].play();
         };
         if(index < 1)
         {
            return;
         }
         _progressBarList[index].scaleX = 0;
         _progressBarList[index].visible = true;
         TweenLite.to(_progressBarList[index],2,{
            "scaleX":1,
            "onComplete":showCanGainBox
         });
      }
   }
}
