package moneyTree.view
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.MultipleLineTip;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import moneyTree.MoneyTreeManager;
   
   public class Fruit extends Sprite implements Disposeable
   {
       
      
      private var _index:int;
      
      private var _tip:MultipleLineTip;
      
      protected var _title:Bitmap;
      
      protected var _normalBmp:Bitmap;
      
      protected var _grownMC:MovieClip;
      
      protected var _pickMC:MovieClip;
      
      protected var _countDown:CountDownBoard;
      
      private var _manager:MoneyTreeManager;
      
      private var _onComplete:Function;
      
      public function Fruit(param1:int){super();}
      
      public function get index() : int{return 0;}
      
      private function __showTip(param1:MouseEvent) : void{}
      
      private function __hideTip(param1:MouseEvent) : void{}
      
      protected function onClick(param1:MouseEvent) : void{}
      
      private function addListener() : void{}
      
      protected function updateTime(param1:CEvent) : void{}
      
      public function showGrown() : void{}
      
      public function showNormal() : void{}
      
      public function showPick() : void{}
      
      protected function onPickEF(param1:Event) : void{}
      
      private function showDelay(param1:Function) : void{}
      
      public function dispose() : void{}
   }
}
