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
      
      public function MysteriousRouletteView()
      {
         super();
         initView();
         initEvent();
         initData();
      }
      
      public function initView() : void
      {
         _rouletteTitle = ComponentFactory.Instance.creat("mysteriousRoulette.rouletteTitle");
         addChild(_rouletteTitle);
         _description = ComponentFactory.Instance.creat("mysteriousRoulette.desctiption");
         addChild(_description);
         _roullete = ComponentFactory.Instance.creat("mysteriousRoulette.roullete");
         addChild(_roullete);
         _timeBG = ComponentFactory.Instance.creat("mysteriousRoulette.timeBG");
         addChild(_timeBG);
         _dateTxt = ComponentFactory.Instance.creat("mysteriousRoulette.dateTxt");
         _dateTxt.text = "2013-09-26";
         addChild(_dateTxt);
         _rouletteRun = new RouletteRun();
         addChild(_rouletteRun);
         _gear = ComponentFactory.Instance.creat("mysteriousRoulette.gear");
         addChild(_gear);
         _startBtn = ComponentFactory.Instance.creat("mysteriousRoulette.startBtn");
         addChild(_startBtn);
         _shopBtn = ComponentFactory.Instance.creat("mysteriousRoulette.shopBtn");
         addChild(_shopBtn);
         _shopBtn.visible = false;
         _lightUnstart = ComponentFactory.Instance.creat("mysteriousRoulette.mc.6LightUnstart");
         PositionUtils.setPos(_lightUnstart,"mysteriousRoulette.mc.6LightUnstartPos");
         addChild(_lightUnstart);
         _lightStart = ComponentFactory.Instance.creat("mysteriousRoulette.mc.6Lightstart");
         PositionUtils.setPos(_lightStart,"mysteriousRoulette.mc.6LightstartPos");
         addChild(_lightStart);
         _lightStart.visible = false;
         _endBtnLight = ComponentFactory.Instance.creat("mysteriousRoulette.mc.endBtnLight");
         PositionUtils.setPos(_endBtnLight,"mysteriousRoulette.mc.endBtnLightPos");
         addChild(_endBtnLight);
         _endBtnLight.visible = false;
         _startBtnLight = ComponentFactory.Instance.creat("mysteriousRoulette.mc.startBtnLight");
         PositionUtils.setPos(_startBtnLight,"mysteriousRoulette.mc.startBtnLightPos");
         addChild(_startBtnLight);
         _startBtnLight.visible = false;
         var _loc1_:int = MysteriousManager.instance.selectIndex;
         if(_loc1_ > 0)
         {
            _rouletteRun.select(_loc1_);
            _startBtn.mouseEnabled = false;
         }
      }
      
      private function initEvent() : void
      {
         _startBtn.addEventListener("mouseDown",onStartBtnDown);
         _shopBtn.addEventListener("click",onShopBtnClick);
         SocketManager.Instance.addEventListener(PkgEvent.format(110,17),__dawnLottery);
      }
      
      private function initData() : void
      {
         var _loc1_:Date = MysteriousManager.instance.startTime;
         var _loc2_:Date = MysteriousManager.instance.endTime;
         _dateTxt.text = _loc1_.getFullYear() + "." + (_loc1_.getMonth() + 1) + "." + _loc1_.getDate() + "-" + _loc2_.getFullYear() + "." + (_loc2_.getMonth() + 1) + "." + _loc2_.getDate();
      }
      
      private function onStartBtnDown(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _startBtn.mouseEnabled = false;
         _startBtnLight.visible = true;
         _startBtnLight.gotoAndStop(1);
         _startBtnLight.play();
         _startBtnLight.addEventListener("enterFrame",onEnterFrame);
         MysteriousControl.instance.addMask();
         WonderfulActivityManager.Instance.frameCanClose = false;
         SocketManager.Instance.out.sendRouletteRun();
      }
      
      protected function onRouletteRunComplete(param1:Event) : void
      {
         _rouletteRun.removeEventListener("complete",onRouletteRunComplete);
         _endBtnLight.visible = true;
         _endBtnLight.gotoAndStop(1);
         _endBtnLight.play();
         _endBtnLight.addEventListener("enterFrame",onEnterFrame);
         _lightStart.visible = false;
         _lightUnstart.visible = true;
         SoundManager.instance.playMusic("140");
         SoundManager.instance.play("126");
         MysteriousControl.instance.removeMask();
         WonderfulActivityManager.Instance.frameCanClose = true;
         if(selectedIndex != 4)
         {
            _startBtn.visible = false;
            _shopBtn.visible = true;
         }
         MysteriousManager.instance.selectIndex = selectedIndex;
      }
      
      private function onShopBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispatchEvent(new MysteriousEvent("changeView",1));
      }
      
      private function __dawnLottery(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         selectedIndex = _loc2_.readInt();
         _lightUnstart.visible = false;
         _lightStart.visible = true;
         _rouletteRun.run(selectedIndex);
         _rouletteRun.addEventListener("complete",onRouletteRunComplete);
      }
      
      protected function onEnterFrame(param1:Event) : void
      {
         if((param1.target as MovieClip).currentFrame == (param1.target as MovieClip).totalFrames)
         {
            (param1.target as MovieClip).stop();
            (param1.target as MovieClip).visible = false;
            (param1.target as MovieClip).gotoAndStop(1);
            (param1.target as MovieClip).removeEventListener("enterFrame",onEnterFrame);
         }
      }
      
      private function removeEvent() : void
      {
         _startBtn.removeEventListener("mouseDown",onStartBtnDown);
         _shopBtn.removeEventListener("click",onShopBtnClick);
         SocketManager.Instance.removeEventListener(PkgEvent.format(110,17),__dawnLottery);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_rouletteTitle)
         {
            ObjectUtils.disposeObject(_rouletteTitle);
         }
         _rouletteTitle = null;
         if(_description)
         {
            ObjectUtils.disposeObject(_description);
         }
         _description = null;
         if(_timeBG)
         {
            ObjectUtils.disposeObject(_timeBG);
         }
         _timeBG = null;
         if(_dateTxt)
         {
            ObjectUtils.disposeObject(_dateTxt);
         }
         _dateTxt = null;
         if(_roullete)
         {
            ObjectUtils.disposeObject(_roullete);
         }
         _roullete = null;
         if(_gear)
         {
            ObjectUtils.disposeObject(_gear);
         }
         _gear = null;
         if(_startBtn)
         {
            ObjectUtils.disposeObject(_startBtn);
         }
         _startBtn = null;
         if(_shopBtn)
         {
            ObjectUtils.disposeObject(_shopBtn);
         }
         _shopBtn = null;
         if(_lightStart)
         {
            ObjectUtils.disposeObject(_lightStart);
         }
         _lightStart = null;
         if(_lightUnstart)
         {
            ObjectUtils.disposeObject(_lightUnstart);
         }
         _lightUnstart = null;
         if(_startBtnLight)
         {
            ObjectUtils.disposeObject(_startBtnLight);
         }
         _startBtnLight = null;
         if(_endBtnLight)
         {
            ObjectUtils.disposeObject(_endBtnLight);
         }
         _endBtnLight = null;
         if(_rouletteRun)
         {
            ObjectUtils.disposeObject(_rouletteRun);
         }
         _rouletteRun = null;
      }
   }
}
