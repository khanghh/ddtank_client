package horseRace.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import horseRace.controller.HorseRaceManager;
   import horseRace.events.HorseRaceEvents;
   
   public class HorseRaceBuffView extends Sprite implements Disposeable
   {
       
      
      public var timeSyn:int = 0;
      
      private var _bg:Bitmap;
      
      private var _buffItemType1:int = 0;
      
      private var _buffItemType2:int = 0;
      
      private var buffItem1:HorseRaceBuffItem;
      
      private var buffItem2:HorseRaceBuffItem;
      
      private var pingzhangBnt:BaseButton;
      
      private var pingzhangTimer:Timer;
      
      private var pingzhangCount:int = 15;
      
      private var pingzhangDaojishi:MovieClip;
      
      public var pingzhangUseSuccess:Boolean = false;
      
      public function HorseRaceBuffView(){super();}
      
      private function initView() : void{}
      
      private function _showDaojishi(param1:TimerEvent) : void{}
      
      public function showPingzhangDaojishi() : void{}
      
      public function set buffItemType1(param1:int) : void{}
      
      public function get buffItemType1() : int{return 0;}
      
      public function set buffItemType2(param1:int) : void{}
      
      public function get buffItemType2() : int{return 0;}
      
      public function flushBuffItem() : void{}
      
      private function initEvent() : void{}
      
      private function _pingzhangUse(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
