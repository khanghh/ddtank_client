package godCardRaise.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import godCardRaise.GodCardRaiseManager;
   import godCardRaise.info.GodCardListInfo;
   
   public class GodCardRaiseAtlasCard extends Sprite implements Disposeable
   {
       
      
      private var _info:GodCardListInfo;
      
      private var _countTxt:FilterFrameText;
      
      private var _picSp:Sprite;
      
      private var _loaderPic:DisplayLoader;
      
      private var _picBmp:Bitmap;
      
      private var _compositeBtn:BaseButton;
      
      private var _smashBtn:BaseButton;
      
      private var _btnBg:Shape;
      
      private var _cardCount:int;
      
      private var _clickNum:Number = 0;
      
      private var _btnType:int;
      
      private var _alert:GodCardRaiseAtlasCardAlert;
      
      public function GodCardRaiseAtlasCard()
      {
         super();
         initView();
         initEvent();
         this.buttonMode = true;
      }
      
      private function initView() : void
      {
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseAtlasCard.countTxt");
         addChild(_countTxt);
         _picSp = new Sprite();
         addChild(_picSp);
         _btnBg = new Shape();
         _btnBg.graphics.beginFill(0,0.5);
         _btnBg.graphics.drawRect(0,0,140,40);
         _btnBg.graphics.endFill();
         _btnBg.x = 13;
         _btnBg.y = 180;
         addChild(_btnBg);
         _compositeBtn = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseAtlasCard.compositeBtn");
         addChild(_compositeBtn);
         _smashBtn = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseAtlasCard.smashBtn");
         addChild(_smashBtn);
         var _loc1_:* = false;
         _smashBtn.visible = _loc1_;
         _loc1_ = _loc1_;
         _compositeBtn.visible = _loc1_;
         _btnBg.visible = _loc1_;
      }
      
      private function initEvent() : void
      {
         _compositeBtn.addEventListener("click",__compositeBtnHandler);
         _smashBtn.addEventListener("click",__smashBtnHandler);
         this.addEventListener("mouseOver",onMouseOver);
         this.addEventListener("mouseOut",onMouseOut);
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         _info.Composition;
         if(_cardCount > 0 && _info.Decompose != 0)
         {
            _smashBtn.visible = true;
         }
         else
         {
            _smashBtn.visible = false;
         }
         if(_info.Composition != 0)
         {
            _compositeBtn.visible = true;
         }
         else
         {
            _compositeBtn.visible = false;
         }
         if(_smashBtn.visible)
         {
            if(_compositeBtn.visible)
            {
               _smashBtn.x = 93;
               _compositeBtn.x = 23;
            }
            else
            {
               _smashBtn.x = 60;
            }
            _btnBg.visible = true;
         }
         else if(_compositeBtn.visible)
         {
            _compositeBtn.x = 60;
            _btnBg.visible = true;
         }
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         var _loc2_:* = false;
         _smashBtn.visible = _loc2_;
         _loc2_ = _loc2_;
         _compositeBtn.visible = _loc2_;
         _btnBg.visible = _loc2_;
      }
      
      public function updateView() : void
      {
         _cardCount = GodCardRaiseManager.Instance.model.cards[_info.ID];
         _countTxt.text = LanguageMgr.GetTranslation("godCardRaiseAtlasCard.countTxtMsg",_cardCount);
         if(_cardCount > 0)
         {
            _picSp.filters = null;
         }
         else
         {
            _picSp.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
      }
      
      public function set info(param1:GodCardListInfo) : void
      {
         _info = param1;
         updateView();
         _loaderPic = LoadResourceManager.Instance.createLoader(PathManager.solveGodCardRaisePath(_info.Pic),0);
         _loaderPic.addEventListener("complete",__picComplete);
         LoadResourceManager.Instance.startLoad(_loaderPic);
      }
      
      private function __picComplete(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener("complete",__picComplete);
         if(param1.loader.isSuccess)
         {
            _picBmp = param1.loader.content as Bitmap;
            _picSp.addChild(_picBmp);
         }
      }
      
      private function __compositeBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc3_:Number = new Date().time;
         if(_loc3_ - _clickNum < 1000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.storeIIStrength.startStrengthClickTimerMsg"));
            return;
         }
         _clickNum = _loc3_;
         var _loc2_:int = GodCardRaiseManager.Instance.model.chipCount;
         if(_loc2_ < _info.Composition)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("godCardRaiseAtlasCard.compositeMsg2",_info.Composition));
            return;
         }
         showAlert(2);
      }
      
      private function showAlert(param1:int) : void
      {
         var _loc2_:int = 0;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         _btnType = param1;
         if(_btnType == 2)
         {
            _loc2_ = GodCardRaiseManager.Instance.model.chipCount / _info.Composition;
         }
         else
         {
            _loc2_ = _cardCount;
         }
         _alert = ComponentFactory.Instance.creatComponentByStylename("GodCardRaiseAtlasCardAlert");
         _alert.addEventListener("response",__alertResponse);
         _alert.setInfo = _info;
         _alert.setType = _btnType;
         _alert.valueLimit = "1," + _loc2_;
         _alert.show();
      }
      
      private function __alertResponse(param1:FrameEvent) : void
      {
         if(_alert)
         {
            _alert.removeEventListener("response",__alertResponse);
         }
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               GameInSocketOut.sendGodCardOperateCard(_btnType,_info.ID,_alert.count);
               break;
            case 2:
         }
         _alert.dispose();
         if(_alert.parent)
         {
            _alert.parent.removeChild(_alert);
         }
         _alert = null;
      }
      
      private function __smashBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:Number = new Date().time;
         if(_loc2_ - _clickNum < 1000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.storeIIStrength.startStrengthClickTimerMsg"));
            return;
         }
         _clickNum = _loc2_;
         if(_cardCount <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("godCardRaiseAtlasCard.smashMsg2"));
            return;
         }
         showAlert(1);
      }
      
      private function removeEvent() : void
      {
         _compositeBtn.removeEventListener("click",__compositeBtnHandler);
         _smashBtn.removeEventListener("click",__smashBtnHandler);
         this.removeEventListener("mouseOver",onMouseOver);
         this.removeEventListener("mouseOut",onMouseOut);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_loaderPic)
         {
            _loaderPic.removeEventListener("complete",__picComplete);
            _loaderPic = null;
         }
         ObjectUtils.disposeAllChildren(_picSp);
         _btnBg.graphics.clear();
         ObjectUtils.disposeAllChildren(this);
         _picSp = null;
         _countTxt = null;
         _info = null;
         _picBmp = null;
         _btnBg = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
