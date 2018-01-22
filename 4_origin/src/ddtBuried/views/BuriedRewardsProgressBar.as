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
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc3_:ComponentFactory = ComponentFactory.Instance;
         _bg = _loc3_.creat("buried.progressBG");
         _bg.x = -130;
         addChild(_bg);
         _progressBarList = new Vector.<Bitmap>();
         _loc4_ = 5;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _progressBarList[_loc5_] = _loc3_.creatBitmap("buried.progressbar");
            PositionUtils.setPos(_progressBarList[_loc5_],"ddtburied.progressBar.pos" + _loc5_.toString());
            addChild(_progressBarList[_loc5_]);
            _loc5_++;
         }
         _progressTextField = _loc3_.creat("ddtburied.progressBar");
         _progressTextField.y = 25;
         addChild(_progressTextField);
         _boxList = new Vector.<SimpleBitmapButton>();
         _loc4_ = 5;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _boxList[_loc5_] = _loc3_.creat("buried.rewardboxBtn" + _loc5_.toString());
            _boxList[_loc5_].mouseEnabled = false;
            _boxList[_loc5_].mouseChildren = false;
            PositionUtils.setPos(_boxList[_loc5_],"ddtburied.box.pos" + _loc5_.toString());
            _boxList[_loc5_].enable = true;
            addChild(_boxList[_loc5_]);
            _loc5_++;
         }
         _boxOpenedList = new Vector.<Bitmap>();
         _loc4_ = 5;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _boxOpenedList[_loc5_] = _loc3_.creatBitmap("buired.bmp.opened" + _loc5_.toString());
            PositionUtils.setPos(_boxOpenedList[_loc5_],"ddtburied.boxOpened.pos" + _loc5_.toString());
            Helpers.grey(_boxOpenedList[_loc5_]);
            _boxOpenedList[_loc5_].visible = false;
            addChild(_boxOpenedList[_loc5_]);
            _loc5_++;
         }
         _gainedSignList = new Vector.<Bitmap>();
         _loc4_ = 5;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _gainedSignList[_loc5_] = _loc3_.creatBitmap("buried.alreadyGet");
            PositionUtils.setPos(_gainedSignList[_loc5_],"ddtburied.box.pos" + _loc5_.toString());
            _gainedSignList[_loc5_].x = _gainedSignList[_loc5_].x + 10;
            _gainedSignList[_loc5_].y = 12;
            _gainedSignList[_loc5_].visible = true;
            addChild(_gainedSignList[_loc5_]);
            _loc5_++;
         }
         _boxPlayOpenList = new Vector.<MovieClip>();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _boxPlayOpenList[_loc5_] = _loc3_.creat("buried.mc.open" + _loc5_.toString());
            PositionUtils.setPos(_boxPlayOpenList[_loc5_],"ddtburied.boxOpened.pos" + _loc5_.toString());
            _boxPlayOpenList[_loc5_].visible = false;
            var _loc6_:Boolean = false;
            _boxPlayOpenList[_loc5_].mouseEnabled = _loc6_;
            _boxPlayOpenList[_loc5_].mouseChildren = _loc6_;
            _boxPlayOpenList[_loc5_].stop();
            addChild(_boxPlayOpenList[_loc5_]);
            _loc5_++;
         }
         _boxCanGainList = new Vector.<MovieClip>();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _boxCanGainList[_loc5_] = _loc3_.creat("buired.mc.canGain" + _loc5_.toString());
            PositionUtils.setPos(_boxCanGainList[_loc5_],"ddtburied.boxOpened.pos" + _loc5_.toString());
            _boxCanGainList[_loc5_].visible = false;
            _boxCanGainList[_loc5_].stop();
            addChild(_boxCanGainList[_loc5_]);
            _boxCanGainList[_loc5_].useHandCursor = true;
            _boxCanGainList[_loc5_].buttonMode = true;
            _boxCanGainList[_loc5_].name = _loc5_.toString();
            _boxCanGainList[_loc5_].mouseChildren = false;
            _loc5_++;
         }
         _tipList = new Vector.<BaseCell>();
         var _loc2_:Array = BuriedControl.Instance.reachEndRewardsIDs;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc1_ = new Shape();
            _loc1_.graphics.beginFill(0,0.2);
            _loc1_.graphics.drawRect(0,0,70,70);
            _loc1_.graphics.endFill();
            _tipList[_loc5_] = new BaseCell(_loc1_,ItemManager.Instance.getTemplateById(_loc2_[_loc5_]));
            _tipList[_loc5_].alpha = 0;
            _tipList[_loc5_].name = _loc5_.toString();
            _tipList[_loc5_].mouseChildren = false;
            _tipList[_loc5_].useHandCursor = true;
            _tipList[_loc5_].buttonMode = true;
            _tipList[_loc5_].addEventListener("click",onGainBtnClick);
            PositionUtils.setPos(_tipList[_loc5_],"ddtburied.boxTips.pos" + _loc5_.toString());
            addChild(_tipList[_loc5_]);
            _loc5_++;
         }
         _loc3_ = null;
      }
      
      protected function onGainBtnClick(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = _boxCanGainList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(param1.target["name"] == _loc3_.toString() && _boxCanGainList[_loc3_].visible == true)
            {
               BuriedControl.Instance.requireGainRewards(_loc3_);
               break;
            }
            _loc3_++;
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
            for each(var _loc3_ in _progressBarList)
            {
               ObjectUtils.disposeObject(_loc3_);
            }
            _progressBarList.length = 0;
            _progressBarList = null;
         }
         if(_boxList != null)
         {
            var _loc11_:int = 0;
            var _loc10_:* = _boxList;
            for each(var _loc5_ in _boxList)
            {
               ObjectUtils.disposeObject(_loc5_);
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
            for each(var _loc2_ in _gainedSignList)
            {
               ObjectUtils.disposeObject(_loc2_);
            }
            _gainedSignList.length = 0;
            _gainedSignList = null;
         }
         if(_boxOpenedList != null)
         {
            var _loc15_:int = 0;
            var _loc14_:* = _boxOpenedList;
            for each(var _loc6_ in _boxOpenedList)
            {
               ObjectUtils.disposeObject(_loc6_);
            }
            _boxOpenedList.length = 0;
            _boxOpenedList = null;
         }
         if(_boxPlayOpenList != null)
         {
            var _loc17_:int = 0;
            var _loc16_:* = _boxPlayOpenList;
            for each(var _loc1_ in _boxPlayOpenList)
            {
               _loc1_.stop();
               ObjectUtils.disposeObject(_loc1_);
            }
            _boxPlayOpenList.length = 0;
            _boxPlayOpenList = null;
         }
         if(_boxCanGainList != null)
         {
            var _loc19_:int = 0;
            var _loc18_:* = _boxCanGainList;
            for each(var _loc7_ in _boxCanGainList)
            {
               _loc7_.stop();
               ObjectUtils.disposeObject(_loc7_);
            }
            _boxCanGainList.length = 0;
            _boxCanGainList = null;
         }
         if(_tipList != null)
         {
            var _loc21_:int = 0;
            var _loc20_:* = _tipList;
            for each(var _loc4_ in _tipList)
            {
               _loc4_.removeEventListener("click",onGainBtnClick);
               ObjectUtils.disposeObject(_loc4_);
            }
            _tipList.length = 0;
            _tipList = null;
         }
      }
      
      public function updateProgressState() : void
      {
         var _loc8_:int = 0;
         var _loc7_:int = BuriedManager.Instance.maxTimesCanGainRewards;
         var _loc5_:int = Math.min(BuriedManager.Instance.timesReachEnd,_loc7_);
         var _loc4_:Array = BuriedManager.Instance.boxNeedTimesList;
         var _loc11_:int = 0;
         var _loc10_:* = _progressBarList;
         for each(var _loc1_ in _progressBarList)
         {
            _loc1_.visible = false;
         }
         if(_loc5_ < _loc4_[0])
         {
            _loc7_ = _loc4_[0];
            _progressTextField.x = -59;
         }
         if(_loc5_ >= _loc4_[0])
         {
            _loc7_ = _loc4_[1];
            _progressTextField.x = 69;
            _progressBarList[0].visible = true;
            _progressBarList[0].scaleX = 1;
         }
         if(_loc5_ >= _loc4_[1])
         {
            _loc7_ = _loc4_[2];
            _progressTextField.x = 199;
            _progressBarList[1].visible = true;
            _progressBarList[1].scaleX = 1;
         }
         if(_loc5_ >= _loc4_[2])
         {
            _loc7_ = _loc4_[3];
            _progressTextField.x = 327;
            _progressBarList[2].visible = true;
            _progressBarList[2].scaleX = 1;
         }
         if(_loc5_ >= _loc4_[3])
         {
            _loc7_ = _loc4_[4];
            _progressTextField.x = 459;
            _progressBarList[3].visible = true;
            _progressBarList[3].scaleX = 1;
         }
         if(_loc5_ >= _loc4_[4])
         {
            _loc7_ = _loc4_[4];
            _progressBarList[4].visible = true;
            _progressBarList[4].scaleX = 1;
         }
         _progressTextField.text = _loc5_.toString() + "/" + _loc7_;
         var _loc6_:int = BuriedManager.Instance.stateRewardsGained;
         var _loc9_:String = _loc6_.toString(2);
         var _loc2_:Array = _loc9_.split("");
         while(_loc2_.length < 5)
         {
            _loc2_.unshift("0");
         }
         _loc2_.reverse();
         var _loc3_:* = 0;
         _loc8_ = 0;
         while(_loc8_ < 5)
         {
            if(_loc2_[_loc8_] == "0")
            {
               if(_loc5_ < BuriedManager.Instance.boxNeedTimesList[_loc8_])
               {
                  _boxList[_loc8_].visible = true;
                  _boxCanGainList[_loc8_].visible = false;
                  _boxCanGainList[_loc8_].stop();
                  _boxOpenedList[_loc8_].visible = false;
                  _gainedSignList[_loc8_].visible = false;
               }
               else
               {
                  _loc3_ = _loc8_;
                  _boxList[_loc8_].visible = false;
                  _boxCanGainList[_loc8_].visible = true;
                  _boxCanGainList[_loc8_].play();
                  _boxOpenedList[_loc8_].visible = false;
                  _gainedSignList[_loc8_].visible = false;
                  addChild(_gainedSignList[_loc8_]);
               }
            }
            else
            {
               _boxList[_loc8_].visible = false;
               _boxCanGainList[_loc8_].visible = false;
               _boxCanGainList[_loc8_].stop();
               _boxOpenedList[_loc8_].visible = true;
               _gainedSignList[_loc8_].visible = true;
            }
            _loc8_++;
         }
      }
      
      public function playGainBox(param1:int) : void
      {
         index = param1;
         onEF = function(param1:Event):void
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
      
      public function playGetRewardBoxAnimation(param1:int) : void
      {
         index = param1;
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
