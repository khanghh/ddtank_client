package horseRace.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import horseRace.controller.HorseRaceManager;
   import horseRace.events.HorseRaceEvents;
   
   public class HorseRaceBuffItem extends Sprite implements Disposeable
   {
       
      
      private var _buffIndex:int;
      
      private var _buffType:int;
      
      private var _bg:Bitmap;
      
      private var _daojishi:MovieClip;
      
      private var _buffObj1:BaseButton;
      
      private var _buffObj2:BaseButton;
      
      private var _buffObj3:BaseButton;
      
      private var _buffObj4:BaseButton;
      
      private var _buffObj5:BaseButton;
      
      private var _buffObj6:BaseButton;
      
      private var _buffObj7:BaseButton;
      
      private var _buffObj8:BaseButton;
      
      private var buffConfig:Array;
      
      public function HorseRaceBuffItem(param1:int, param2:int){super();}
      
      private function getConfigByID(param1:int) : int{return 0;}
      
      private function initView() : void{}
      
      public function setShowBuff(param1:int, param2:int) : void{}
      
      public function setShowBuffObj(param1:int) : void{}
      
      public function showBuffObjByType(param1:int) : void{}
      
      private function _buffObjClick(param1:MouseEvent) : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
