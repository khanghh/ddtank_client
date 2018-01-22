package ddt.view.bossbox
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.BossBoxManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class SmallBoxButton extends Sprite implements Disposeable
   {
      
      public static const showTypeWait:int = 1;
      
      public static const showTypeCountDown:int = 2;
      
      public static const showTypeOpenbox:int = 3;
      
      public static const showTypeHide:int = 4;
      
      public static const HALL_POINT:int = 0;
      
      public static const PVR_ROOMLIST_POINT:int = 1;
      
      public static const PVP_ROOM_POINT:int = 2;
      
      public static const PVE_ROOMLIST_POINT:int = 3;
      
      public static const PVE_ROOM_POINT:int = 4;
      
      public static const HOTSPRING_ROOMLIST_POINT:int = 5;
      
      public static const HOTSPRING_ROOM_POINT:int = 6;
       
      
      private var _closeBox:MovieImage;
      
      private var _openBoxAsset:MovieImage;
      
      private var _openBox:Sprite;
      
      private var _delayText:Sprite;
      
      private var timeText:FilterFrameText;
      
      private var _timeSprite:TimeTip;
      
      private var _pointArray:Vector.<Point>;
      
      public function SmallBoxButton(param1:int)
      {
         super();
         init(param1);
         initEvent();
      }
      
      private function init(param1:int) : void
      {
         _getPoint();
         _delayText = new Sprite();
         _openBox = new Sprite();
         _openBox.graphics.beginFill(0,0);
         _openBox.graphics.drawRect(-22,-2,115,70);
         _openBox.graphics.endFill();
         _closeBox = ComponentFactory.Instance.creat("bossbox.closeBox");
         _openBoxAsset = ComponentFactory.Instance.creat("bossbox.openBox");
         var _loc2_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.timeBox.timeBGAsset");
         timeText = ComponentFactory.Instance.creat("bossbox.TimeBoxStyle");
         _delayText.addChild(_loc2_);
         _delayText.addChild(timeText);
         _timeSprite = ComponentFactory.Instance.creat("TimeBox.TimeTip");
         _timeSprite.tipData = LanguageMgr.GetTranslation("tanl.timebox.tipMes");
         _timeSprite.setView(_closeBox,_delayText);
         _timeSprite.buttonMode = true;
         addChild(_timeSprite);
         _openBox.addChild(_openBoxAsset);
         addChild(_openBox);
         addChild(_delayText);
         showType(BossBoxManager.instance.boxButtonShowType);
         updateTime(BossBoxManager.instance.delaySumTime);
         x = _pointArray[param1].x;
         y = _pointArray[param1].y;
      }
      
      private function _getPoint() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _pointArray = new Vector.<Point>();
         _loc2_ = 0;
         while(_loc2_ < 7)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("smallBoxbutton.point" + _loc2_);
            _pointArray.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         _openBox.buttonMode = true;
         _openBox.addEventListener("click",_click);
         _timeSprite.addEventListener("click",_click);
         BossBoxManager.instance.addEventListener("update_smallBoxButton_state",_updateSmallBoxState);
         BossBoxManager.instance.addEventListener("updateTimeCount",_updateTimeCount);
      }
      
      public function updateTime(param1:int) : void
      {
         var _loc5_:* = param1;
         var _loc2_:int = _loc5_ / 60;
         var _loc4_:int = _loc5_ % 60;
         var _loc3_:String = "";
         if(_loc2_ < 10)
         {
            _loc3_ = _loc3_ + ("0" + _loc2_);
         }
         else
         {
            _loc3_ = _loc3_ + _loc2_;
         }
         _loc3_ = _loc3_ + ":";
         if(_loc4_ < 10)
         {
            _loc3_ = _loc3_ + ("0" + _loc4_);
         }
         else
         {
            _loc3_ = _loc3_ + _loc4_;
         }
         timeText.text = _loc3_;
      }
      
      public function showType(param1:int) : void
      {
         switch(int(param1) - 1)
         {
            case 0:
               _timeSprite.closeBox.visible = true;
               _openBox.visible = false;
               _timeSprite.delayText.visible = true;
               break;
            case 1:
               _timeSprite.closeBox.visible = true;
               _openBox.visible = false;
               _timeSprite.delayText.visible = true;
               break;
            case 2:
               _timeSprite.closeBox.visible = false;
               _openBox.visible = true;
               _timeSprite.delayText.visible = false;
               break;
            case 3:
               this.visible = false;
         }
      }
      
      private function _click(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         BossBoxManager.instance.showTimeBox();
      }
      
      private function _updateSmallBoxState(param1:TimeBoxEvent) : void
      {
         showType(param1.boxButtonShowType);
      }
      
      private function _updateTimeCount(param1:TimeBoxEvent) : void
      {
         updateTime(param1.delaySumTime);
      }
      
      override public function get width() : Number
      {
         return 100;
      }
      
      private function removeEvent() : void
      {
         _openBox.removeEventListener("click",_click);
         _timeSprite.removeEventListener("click",_click);
         BossBoxManager.instance.removeEventListener("update_smallBoxButton_state",_updateSmallBoxState);
         BossBoxManager.instance.removeEventListener("updateTimeCount",_updateTimeCount);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_closeBox)
         {
            ObjectUtils.disposeObject(_closeBox);
         }
         _closeBox = null;
         if(_openBoxAsset)
         {
            ObjectUtils.disposeObject(_openBoxAsset);
         }
         _openBoxAsset = null;
         if(_openBox)
         {
            ObjectUtils.disposeObject(_openBox);
         }
         _openBox = null;
         if(_delayText)
         {
            ObjectUtils.disposeObject(_delayText);
         }
         _delayText = null;
         if(timeText)
         {
            ObjectUtils.disposeObject(timeText);
         }
         timeText = null;
         if(_timeSprite)
         {
            ObjectUtils.disposeObject(_timeSprite);
         }
         _timeSprite = null;
         _pointArray = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
