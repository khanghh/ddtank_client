package horse.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import horse.HorseManager;
   import horse.data.HorseEvent;
   
   public class HorseFrameLeftTopView extends Sprite implements Disposeable
   {
       
      
      private var _leftArrowBtn:SimpleBitmapButton;
      
      private var _rightArrowBtn:SimpleBitmapButton;
      
      private var _useBtn:SimpleBitmapButton;
      
      private var _takeBackBtn:SimpleBitmapButton;
      
      private var _preLevelUpBtn:SimpleBitmapButton;
      
      private var _nameTxt:FilterFrameText;
      
      private var _horseMc:MovieClip;
      
      private var _horseNameStrList:Array;
      
      private var _curIndex:int;
      
      private var _maxIndex:int;
      
      private var _horseAmuletTips:Component;
      
      public function HorseFrameLeftTopView()
      {
         super();
         _horseNameStrList = LanguageMgr.GetTranslation("horse.horseNameStr").split(",");
         initView();
         initEvent();
         upHorseHandler(null);
      }
      
      private function initView() : void
      {
         _leftArrowBtn = ComponentFactory.Instance.creatComponentByStylename("horse.frame.leftArrowBtn");
         _rightArrowBtn = ComponentFactory.Instance.creatComponentByStylename("horse.frame.rightArrowBtn");
         _useBtn = ComponentFactory.Instance.creatComponentByStylename("horse.frame.useBtn");
         _takeBackBtn = ComponentFactory.Instance.creatComponentByStylename("horse.frame.takeBackBtn");
         _preLevelUpBtn = ComponentFactory.Instance.creatComponentByStylename("horse.frame.preLevelUp");
         _preLevelUpBtn.buttonMode = false;
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("horse.frame.horseNameTxt");
         _horseMc = ComponentFactory.Instance.creat("asset.horse.frame.horseMc");
         PositionUtils.setPos(_horseMc,"horse.frame.horseMcPos");
         _horseMc.mouseChildren = false;
         _horseMc.mouseEnabled = false;
         _horseMc.gotoAndStop(_horseMc.totalFrames);
         _horseAmuletTips = ComponentFactory.Instance.creatComponentByStylename("ddtcorei.horseAmulet.tips");
         _horseAmuletTips.tipData = PlayerManager.Instance.Self;
         PositionUtils.setPos(_horseAmuletTips,"horse.amulet.tipsPos");
         _horseAmuletTips.graphics.beginFill(0,0);
         _horseAmuletTips.graphics.drawRect(0,0,200,200);
         _horseAmuletTips.graphics.endFill();
         addChild(_leftArrowBtn);
         addChild(_rightArrowBtn);
         addChild(_useBtn);
         addChild(_takeBackBtn);
         addChild(_preLevelUpBtn);
         addChild(_nameTxt);
         addChild(_horseMc);
         addChild(_horseAmuletTips);
      }
      
      private function initEvent() : void
      {
         _leftArrowBtn.addEventListener("click",leftArrowClickHandler,false,0,true);
         _rightArrowBtn.addEventListener("click",rightArrowClickHandler,false,0,true);
         _useBtn.addEventListener("click",useClickHandler,false,0,true);
         _takeBackBtn.addEventListener("click",takeBackClickHandler,false,0,true);
         _preLevelUpBtn.addEventListener("mouseOver",preLevelUpOverHandler,false,0,true);
         _preLevelUpBtn.addEventListener("mouseOut",preLevelUpOutHandler,false,0,true);
         HorseManager.instance.addEventListener("horseChangeHorse",changeHorseHandler);
         HorseManager.instance.addEventListener("horseUpHorseStep2",upHorseHandler);
      }
      
      private function upHorseHandler(event:Event) : void
      {
         _maxIndex = int(HorseManager.instance.curLevel / 10) + 1;
         _curIndex = _maxIndex;
         if(_maxIndex == 9)
         {
            _preLevelUpBtn.enable = false;
         }
         refreshHorseShowView(_curIndex);
         refreshHorseUseView();
         refreshArrowView();
      }
      
      private function changeHorseHandler(event:HorseEvent) : void
      {
         refreshHorseUseView();
      }
      
      private function refreshHorseShowView(index:int) : void
      {
         _nameTxt.text = _horseNameStrList[index - 1];
         _horseMc.gotoAndStop(index);
      }
      
      private function refreshHorseUseView() : void
      {
         if(HorseManager.instance.curUseHorse == _curIndex)
         {
            _useBtn.visible = false;
            _takeBackBtn.visible = true;
         }
         else
         {
            _useBtn.visible = true;
            _takeBackBtn.visible = false;
         }
      }
      
      private function refreshArrowView() : void
      {
         if(_curIndex == _maxIndex)
         {
            _rightArrowBtn.visible = false;
         }
         else
         {
            _rightArrowBtn.visible = true;
         }
         if(_curIndex == 1)
         {
            _leftArrowBtn.visible = false;
         }
         else
         {
            _leftArrowBtn.visible = true;
         }
      }
      
      private function leftArrowClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _curIndex = Number(_curIndex) - 1;
         _curIndex = _curIndex < 1?1:_curIndex;
         refreshHorseShowView(_curIndex);
         refreshHorseUseView();
         refreshArrowView();
      }
      
      private function rightArrowClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _curIndex = Number(_curIndex) + 1;
         _curIndex = _curIndex > _maxIndex?_maxIndex:int(_curIndex);
         refreshHorseShowView(_curIndex);
         refreshHorseUseView();
         refreshArrowView();
      }
      
      private function useClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendHorseChangeHorse(_curIndex);
      }
      
      private function takeBackClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendHorseChangeHorse(0);
      }
      
      private function preLevelUpOverHandler(event:MouseEvent) : void
      {
         var tmp:int = _maxIndex + 1;
         tmp = tmp > 9?9:tmp;
         refreshHorseShowView(tmp);
         _useBtn.visible = false;
         _takeBackBtn.visible = false;
         HorseManager.instance.dispatchEvent(new Event("horsePreNextEffect"));
      }
      
      private function preLevelUpOutHandler(event:MouseEvent) : void
      {
         refreshHorseShowView(_curIndex);
         refreshHorseUseView();
         HorseManager.instance.dispatchEvent(new Event("horseRefreshCurEffect"));
      }
      
      private function removeEvent() : void
      {
         _leftArrowBtn.removeEventListener("click",leftArrowClickHandler);
         _rightArrowBtn.removeEventListener("click",rightArrowClickHandler);
         _useBtn.removeEventListener("click",useClickHandler);
         _takeBackBtn.removeEventListener("click",takeBackClickHandler);
         _preLevelUpBtn.removeEventListener("mouseOver",preLevelUpOverHandler);
         _preLevelUpBtn.removeEventListener("mouseOut",preLevelUpOutHandler);
         HorseManager.instance.removeEventListener("horseChangeHorse",changeHorseHandler);
         HorseManager.instance.removeEventListener("horseUpHorseStep2",upHorseHandler);
      }
      
      public function dispose() : void
      {
         if(_horseMc)
         {
            _horseMc.gotoAndStop(_horseMc.totalFrames);
         }
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _leftArrowBtn = null;
         _rightArrowBtn = null;
         _useBtn = null;
         _takeBackBtn = null;
         _preLevelUpBtn = null;
         _nameTxt = null;
         _horseMc = null;
         _horseNameStrList = null;
         _horseAmuletTips = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
