package calendar.view
{
   import calendar.CalendarControl;
   import calendar.CalendarManager;
   import calendar.CalendarModel;
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainbutton.MainButtnController;
   import road7th.utils.MovieClipWrapper;
   
   public class DayCell extends Sprite implements Disposeable
   {
       
      
      private var _dayField:FilterFrameText;
      
      private var _date:Date;
      
      private var _model:CalendarModel;
      
      private var _back:DisplayObject;
      
      private var _signShape:DisplayObject;
      
      private var _tweenMax:TweenMax;
      
      private var _signBitmap:Bitmap;
      
      private var _signBuyFrame:SignBuyFrame;
      
      private var isTrue:Boolean;
      
      private var _signed:Boolean;
      
      public function DayCell(date:Date, model:CalendarModel)
      {
         super();
         _model = model;
         configUI();
         addEvent();
         buttonMode = true;
         mouseChildren = false;
         this.date = date;
         this.signed = _model.hasSigned(_date) || _model.hasRestroSigned(_date);
      }
      
      public function get signed() : Boolean
      {
         return _signed;
      }
      
      public function set signed(value:Boolean) : void
      {
         if(_signed == value)
         {
            return;
         }
         _signed = value;
         if(_signed && _signShape == null)
         {
            _signShape = ComponentFactory.Instance.creatBitmap("asset.ddtcalendar.SignShape");
            addChild(_signShape);
            if(_tweenMax)
            {
               _tweenMax.pause();
            }
            _back.filters = null;
         }
         else if(!_signed)
         {
            if(_tweenMax)
            {
               _tweenMax.pause();
            }
            _back.filters = null;
            ObjectUtils.disposeObject(_signShape);
            _signShape = null;
         }
      }
      
      public function get date() : Date
      {
         return _date;
      }
      
      public function set date(value:Date) : void
      {
         if(_date == value)
         {
            return;
         }
         _date = value;
         _dayField.text = _date.date.toString();
         isTrue = false;
         if(_signBitmap)
         {
            ObjectUtils.disposeObject(_signBitmap);
            _signBitmap = null;
         }
         if(_date.month == _model.today.month)
         {
            if(!_model.hasSigned(_date) && _date.date == _model.today.date)
            {
               DisplayUtils.setFrame(_back,1);
            }
            else if(!_model.hasSigned(_date) && _date.date < _model.today.date)
            {
               isTrue = true;
               _signBitmap = ComponentFactory.Instance.creatBitmap("asset.ddtcalendar.SignNew");
               addChild(_signBitmap);
               DisplayUtils.setFrame(_back,2);
            }
            else
            {
               DisplayUtils.setFrame(_back,1);
            }
            if(_date.day == 0)
            {
               _dayField.setFrame(3);
            }
            else if(_date.day == 6)
            {
               _dayField.setFrame(2);
            }
            else
            {
               _dayField.setFrame(1);
            }
         }
         else
         {
            DisplayUtils.setFrame(_back,1);
            if(_date.day == 0)
            {
               _dayField.setFrame(6);
            }
            else if(_date.day == 6)
            {
               _dayField.setFrame(5);
            }
            else
            {
               _dayField.setFrame(4);
            }
         }
         setLightActive();
      }
      
      private function setLightActive() : void
      {
         var today:Date = _model.today;
         if(_date.fullYear == today.fullYear && _date.month == today.month && _date.date == today.date && !_model.hasSigned(_date))
         {
            _tweenMax = TweenMax.to(_back,0.4,{
               "repeat":-1,
               "yoyo":true,
               "glowFilter":{
                  "color":13959168,
                  "alpha":1,
                  "blurX":4,
                  "blurY":4,
                  "strength":3
               }
            });
            _tweenMax.play();
         }
         else if(_tweenMax)
         {
            _tweenMax.pause();
            _back.filters = null;
            ObjectUtils.disposeObject(_signShape);
            _signShape = null;
         }
      }
      
      private function configUI() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.Calendar.DayCellBack");
         DisplayUtils.setFrame(_back,1);
         addChild(_back);
         _dayField = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.CalendarGrid.DayField");
         addChild(_dayField);
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__click);
      }
      
      private function __click(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(CalendarControl.getInstance().sign(_date))
         {
            playSignAnimation("asset.ddtcalendar.Grid.SignAnimation");
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.calendar.signed"));
            PlayerManager.Instance.Self.Sign = true;
            MainButtnController.instance.dispatchEvent(new Event(MainButtnController.CLOSESIGN));
         }
         if(CalendarManager.getInstance().times >= 5 && isTrue)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddtcalendar.DayCell.timesIsNo"));
            return;
         }
         if(isTrue && !_model.hasSignedNew(_date))
         {
            _signBuyFrame = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.DayCell.SignBuyFrame");
            _signBuyFrame.date = _date;
            _signBuyFrame.dayCellClass = this;
            LayerManager.Instance.addToLayer(_signBuyFrame,3,true,2);
         }
      }
      
      public function playSignAnimation(str:String) : void
      {
         var movie:* = null;
         if(_signBitmap)
         {
            ObjectUtils.disposeObject(_signBitmap);
            _signBitmap = null;
         }
         DisplayUtils.setFrame(_back,1);
         if(_date.day == 0)
         {
            _dayField.setFrame(6);
         }
         else if(_date.day == 6)
         {
            _dayField.setFrame(5);
         }
         else
         {
            _dayField.setFrame(4);
         }
         if(_tweenMax)
         {
            _tweenMax.pause();
            _back.filters = null;
         }
         var mc:MovieClip = ClassUtils.CreatInstance(str);
         mc.x = 2;
         if(mc)
         {
            movie = new MovieClipWrapper(mc,true,true);
            movie.addEventListener("complete",__signAnimationComplete);
            addChild(movie.movie);
         }
      }
      
      private function __signAnimationComplete(event:Event) : void
      {
         event.currentTarget.removeEventListener("complete",__signAnimationComplete);
         if(parent)
         {
            signed = true;
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__click);
      }
      
      public function dispose() : void
      {
         removeEvent();
         isTrue = false;
         TweenMax.killChildTweensOf(this);
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_dayField);
         _dayField = null;
         ObjectUtils.disposeObject(_signShape);
         _signShape = null;
         if(_signBitmap)
         {
            ObjectUtils.disposeObject(_signBitmap);
            _signBitmap = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
