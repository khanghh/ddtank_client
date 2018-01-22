package ddt.view.caddyII.badLuck
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.RouletteManager;
   import ddt.manager.SoundManager;
   import ddt.view.caddyII.CaddyEvent;
   import ddt.view.caddyII.reader.CaddyReadAwardsView;
   import ddt.view.caddyII.reader.CaddyUpdate;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BadLuckView extends Sprite implements Disposeable, CaddyUpdate
   {
       
      
      private var _bg1:ScaleBitmapImage;
      
      private var _bg2:MutipleImage;
      
      private var _awardBtn:SelectedTextButton;
      
      private var _badLuckBtn:SelectedTextButton;
      
      private var _group:SelectedButtonGroup;
      
      private var _lastTimeTxt:FilterFrameText;
      
      private var _myNumberTxt:FilterFrameText;
      
      private var _caddyBadLuckView:CaddyBadLuckView;
      
      private var _readView:CaddyReadAwardsView;
      
      private var _bottomBG:MutipleImage;
      
      public function BadLuckView()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("caddy.readAwardsBGIV");
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.MyNumberBG");
         _bottomBG = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.bottomBG");
         _group = new SelectedButtonGroup();
         _awardBtn = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.awardBtn");
         _awardBtn.text = LanguageMgr.GetTranslation("tank.view.caddy.awardRecord");
         _badLuckBtn = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.bacLuckBtn");
         _badLuckBtn.text = LanguageMgr.GetTranslation("tank.view.caddy.badluckf");
         _group.addSelectItem(_badLuckBtn);
         _group.addSelectItem(_awardBtn);
         _caddyBadLuckView = ComponentFactory.Instance.creatCustomObject("card.CaddyBadLuckView");
         _readView = ComponentFactory.Instance.creatCustomObject("caddy.CaddyReadAwardsView");
         _lastTimeTxt = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.lastTimeTxt");
         _myNumberTxt = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.MyNumberTxt");
         addChild(_bg1);
         addChild(_bottomBG);
         addChild(_bg2);
         addChild(_awardBtn);
         addChild(_badLuckBtn);
         addChild(_caddyBadLuckView);
         addChild(_readView);
         addChild(_lastTimeTxt);
         addChild(_myNumberTxt);
         _myNumberTxt.text = PlayerManager.Instance.Self.badLuckNumber.toString();
         _group.selectIndex = 1;
         _caddyBadLuckView.visible = false;
      }
      
      private function initEvents() : void
      {
         _awardBtn.addEventListener("click",__awardBtnClick);
         _badLuckBtn.addEventListener("click",__badLuckBtnClick);
         RouletteManager.instance.addEventListener("update_badLuck",__updateLastTime);
         PlayerManager.Instance.Self.addEventListener("propertychange",__changeBadLuckNumber);
      }
      
      private function removeEvents() : void
      {
         _awardBtn.removeEventListener("click",__awardBtnClick);
         _badLuckBtn.removeEventListener("click",__badLuckBtnClick);
         RouletteManager.instance.removeEventListener("update_badLuck",__updateLastTime);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__changeBadLuckNumber);
      }
      
      private function __awardBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _caddyBadLuckView.visible = false;
         _readView.visible = true;
      }
      
      private function __badLuckBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _caddyBadLuckView.visible = true;
         _readView.visible = false;
      }
      
      private function __updateLastTime(param1:CaddyEvent) : void
      {
         _lastTimeTxt.text = "最后更新:" + param1.lastTime;
      }
      
      private function __changeBadLuckNumber(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["BadLuckNumber"])
         {
            if(PlayerManager.Instance.Self.badLuckNumber == 0)
            {
               _myNumberTxt.text = PlayerManager.Instance.Self.badLuckNumber.toString();
            }
         }
      }
      
      public function update() : void
      {
         _myNumberTxt.text = PlayerManager.Instance.Self.badLuckNumber.toString();
      }
      
      public function dispose() : void
      {
         removeEvents();
         if(_bg1)
         {
            ObjectUtils.disposeObject(_bg1);
         }
         _bg1 = null;
         if(_bg2)
         {
            ObjectUtils.disposeObject(_bg2);
         }
         _bg2 = null;
         if(_bottomBG)
         {
            ObjectUtils.disposeObject(_bottomBG);
         }
         _bottomBG = null;
         if(_awardBtn)
         {
            ObjectUtils.disposeObject(_awardBtn);
         }
         _awardBtn = null;
         if(_badLuckBtn)
         {
            ObjectUtils.disposeObject(_badLuckBtn);
         }
         _badLuckBtn = null;
         _group = null;
         if(_lastTimeTxt)
         {
            ObjectUtils.disposeObject(_lastTimeTxt);
         }
         _lastTimeTxt = null;
         if(_myNumberTxt)
         {
            ObjectUtils.disposeObject(_myNumberTxt);
         }
         _myNumberTxt = null;
         if(_caddyBadLuckView)
         {
            ObjectUtils.disposeObject(_caddyBadLuckView);
         }
         _caddyBadLuckView = null;
         if(_readView)
         {
            ObjectUtils.disposeObject(_readView);
         }
         _readView = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
