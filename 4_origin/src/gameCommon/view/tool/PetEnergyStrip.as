package gameCommon.view.tool
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.LivingEvent;
   import ddt.manager.LanguageMgr;
   import ddt.view.tips.ChangeNumToolTipInfo;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import gameCommon.model.Pet;
   
   public class PetEnergyStrip extends Sprite implements Disposeable, ITipedDisplay
   {
       
      
      private var _pet:Pet;
      
      private var _text:FilterFrameText;
      
      private var _bg:MovieClip;
      
      private var _mp:int;
      
      private var _maxMp:int = 100;
      
      private var _TipInfo:ChangeNumToolTipInfo;
      
      public function PetEnergyStrip(param1:Pet)
      {
         super();
         _pet = param1;
         _mp = _pet.MP;
         _maxMp = _pet.MaxMP;
         _TipInfo = new ChangeNumToolTipInfo();
         _TipInfo.currentTxt = ComponentFactory.Instance.creatComponentByStylename("game.DanderStrip.currentTxt");
         _TipInfo.title = LanguageMgr.GetTranslation("tank.game.petmp.mp") + ":";
         _TipInfo.current = 0;
         _TipInfo.total = _maxMp;
         _TipInfo.content = LanguageMgr.GetTranslation("core.petMptip.description");
         initView();
         initEvents();
      }
      
      private function initEvents() : void
      {
         _pet.addEventListener("petEnergyChange",onChange);
      }
      
      private function removeEvents() : void
      {
         _pet.removeEventListener("petEnergyChange",onChange);
      }
      
      private function onChange(param1:LivingEvent) : void
      {
         _mp = _pet.MP;
         _maxMp = _pet.MaxMP;
         _text.text = [_mp,_maxMp].join("/");
         _bg.gotoAndStop(schedule);
      }
      
      private function initView() : void
      {
         _text = ComponentFactory.Instance.creatComponentByStylename("game.petEnergyStrip.PowerTxtII");
         _text.text = [_mp,_maxMp].join("/");
         _bg = ComponentFactory.Instance.creat("asset.game.petEnergyBar");
         addChild(_bg);
         addChild(_text);
         _bg.gotoAndStop(schedule);
         ShowTipManager.Instance.addTip(this);
      }
      
      private function get schedule() : int
      {
         if(_mp > 0)
         {
            return _mp * 100 / _maxMp;
         }
         return 1;
      }
      
      public function get tipData() : Object
      {
         _TipInfo.current = _mp;
         _TipInfo.total = _maxMp;
         return _TipInfo;
      }
      
      public function set tipData(param1:Object) : void
      {
      }
      
      public function get tipDirctions() : String
      {
         return "0";
      }
      
      public function set tipDirctions(param1:String) : void
      {
      }
      
      public function get tipGapH() : int
      {
         return 0;
      }
      
      public function set tipGapH(param1:int) : void
      {
      }
      
      public function get tipGapV() : int
      {
         return 20;
      }
      
      public function set tipGapV(param1:int) : void
      {
      }
      
      public function get tipStyle() : String
      {
         return "ddt.view.tips.ChangeNumToolTip";
      }
      
      public function set tipStyle(param1:String) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         removeEvents();
         ShowTipManager.Instance.removeTip(this);
         ObjectUtils.disposeObject(_text);
         _text = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         _pet = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
