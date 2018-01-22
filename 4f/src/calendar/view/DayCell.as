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
      
      public function DayCell(param1:Date, param2:CalendarModel){super();}
      
      public function get signed() : Boolean{return false;}
      
      public function set signed(param1:Boolean) : void{}
      
      public function get date() : Date{return null;}
      
      public function set date(param1:Date) : void{}
      
      private function setLightActive() : void{}
      
      private function configUI() : void{}
      
      private function addEvent() : void{}
      
      private function __click(param1:MouseEvent) : void{}
      
      public function playSignAnimation(param1:String) : void{}
      
      private function __signAnimationComplete(param1:Event) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
