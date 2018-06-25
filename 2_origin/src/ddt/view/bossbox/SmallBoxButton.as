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
      
      public function SmallBoxButton(type:int)
      {
         super();
         init(type);
         initEvent();
      }
      
      private function init(type:int) : void
      {
         _getPoint();
         _delayText = new Sprite();
         _openBox = new Sprite();
         _openBox.graphics.beginFill(0,0);
         _openBox.graphics.drawRect(-22,-2,115,70);
         _openBox.graphics.endFill();
         _closeBox = ComponentFactory.Instance.creat("bossbox.closeBox");
         _openBoxAsset = ComponentFactory.Instance.creat("bossbox.openBox");
         var timeBG:Bitmap = ComponentFactory.Instance.creatBitmap("asset.timeBox.timeBGAsset");
         timeText = ComponentFactory.Instance.creat("bossbox.TimeBoxStyle");
         _delayText.addChild(timeBG);
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
         x = _pointArray[type].x;
         y = _pointArray[type].y;
      }
      
      private function _getPoint() : void
      {
         var i:int = 0;
         var point:* = null;
         _pointArray = new Vector.<Point>();
         for(i = 0; i < 7; )
         {
            point = ComponentFactory.Instance.creatCustomObject("smallBoxbutton.point" + i);
            _pointArray.push(point);
            i++;
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
      
      public function updateTime(second:int) : void
      {
         var _timeSum:* = second;
         var _minute:int = _timeSum / 60;
         var _second:int = _timeSum % 60;
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
         timeText.text = str;
      }
      
      public function showType(value:int) : void
      {
         switch(int(value) - 1)
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
      
      private function _click(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         BossBoxManager.instance.showTimeBox();
      }
      
      private function _updateSmallBoxState(evt:TimeBoxEvent) : void
      {
         showType(evt.boxButtonShowType);
      }
      
      private function _updateTimeCount(evt:TimeBoxEvent) : void
      {
         updateTime(evt.delaySumTime);
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
