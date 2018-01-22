package mysteriousRoullete.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mysteriousRoullete.MysteriousControl;
   import mysteriousRoullete.MysteriousManager;
   import mysteriousRoullete.components.RouletteRun;
   import mysteriousRoullete.event.MysteriousEvent;
   import road7th.comm.PackageIn;
   import wonderfulActivity.WonderfulActivityManager;
   
   public class MysteriousRouletteView extends Sprite implements Disposeable
   {
       
      
      private var _rouletteTitle:Bitmap;
      
      private var _description:Bitmap;
      
      private var _timeBG:Bitmap;
      
      private var _roullete:Bitmap;
      
      private var _gear:Bitmap;
      
      private var _startBtn:BaseButton;
      
      private var _shopBtn:BaseButton;
      
      private var _dateTxt:FilterFrameText;
      
      private var _rouletteRun:RouletteRun;
      
      private var _lightUnstart:MovieClip;
      
      private var _lightStart:MovieClip;
      
      private var _endBtnLight:MovieClip;
      
      private var _startBtnLight:MovieClip;
      
      private var selectedIndex:int;
      
      public function MysteriousRouletteView(){super();}
      
      public function initView() : void{}
      
      private function initEvent() : void{}
      
      private function initData() : void{}
      
      private function onStartBtnDown(param1:MouseEvent) : void{}
      
      protected function onRouletteRunComplete(param1:Event) : void{}
      
      private function onShopBtnClick(param1:MouseEvent) : void{}
      
      private function __dawnLottery(param1:PkgEvent) : void{}
      
      protected function onEnterFrame(param1:Event) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
