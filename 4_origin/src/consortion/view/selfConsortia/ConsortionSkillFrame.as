package consortion.view.selfConsortia
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import consortion.ConsortionModelManager;
   import consortion.event.ConsortionEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ConsortionSkillFrame extends Frame
   {
      
      public static const CONSORTION_SKILL:int = 0;
      
      public static const PERSONAL_SKILL_CON:int = 1;
      
      public static const PERSONAL_SKILL_METAL:int = 2;
       
      
      private var _bg:MutipleImage;
      
      private var _richesTxt:FilterFrameText;
      
      private var _richbg:ScaleFrameImage;
      
      private var _riches:FilterFrameText;
      
      private var _manager:TextButton;
      
      private var _consortionSkill:SelectedTextButton;
      
      private var _personalSkill:SelectedTextButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _contribute:SelectedTextButton;
      
      private var _metal:SelectedTextButton;
      
      private var _cmGroup:SelectedButtonGroup;
      
      private var _scrollbg:ScaleBitmapImage;
      
      private var _vbox:VBox;
      
      private var _panel:ScrollPanel;
      
      private var _items:Vector.<ConsortionSkillItem>;
      
      private var _oldType:int = 0;
      
      public function ConsortionSkillFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         escEnable = true;
         disposeChildren = true;
         titleText = LanguageMgr.GetTranslation("ddt.consortion.skillFrame.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortion.skillFrame.bg");
         _scrollbg = ComponentFactory.Instance.creatComponentByStylename("consortion.SkillItemBtn.scallBG");
         _richesTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.skillFrame.richesText");
         _richesTxt.text = LanguageMgr.GetTranslation("consortion.skillFrame.richesText1");
         _richbg = ComponentFactory.Instance.creatComponentByStylename("consortion.skillFrame.richesbg");
         _riches = ComponentFactory.Instance.creatComponentByStylename("consortion.skillFrame.riches");
         _manager = ComponentFactory.Instance.creatComponentByStylename("consortion.shop.manager");
         _manager.text = LanguageMgr.GetTranslation("consortion.shop.manager.Text");
         _consortionSkill = ComponentFactory.Instance.creatComponentByStylename("consortion.skillFrame.consortionSkill");
         _consortionSkill.text = LanguageMgr.GetTranslation("consortion.upGradeFrame.skillTxt.text");
         _personalSkill = ComponentFactory.Instance.creatComponentByStylename("consortion.skillFrame.personalSkill");
         _personalSkill.text = LanguageMgr.GetTranslation("consortion.upGradeFrame.skillTxt.text1");
         _contribute = ComponentFactory.Instance.creatComponentByStylename("consortion.skillFrame.contribute");
         _contribute.text = LanguageMgr.GetTranslation("consortion.skillFrame.richesText2");
         _metal = ComponentFactory.Instance.creatComponentByStylename("consortion.skillFrame.metal");
         _metal.text = LanguageMgr.GetTranslation("medalMoney");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("consortion.skillFrame.vbox");
         _panel = ComponentFactory.Instance.creatComponentByStylename("consortion.skillFrame.panel");
         addToContent(_bg);
         addToContent(_scrollbg);
         addToContent(_richesTxt);
         addToContent(_richbg);
         addToContent(_riches);
         addToContent(_manager);
         addToContent(_consortionSkill);
         addToContent(_personalSkill);
         addToContent(_contribute);
         addToContent(_metal);
         addToContent(_panel);
         _panel.setView(_vbox);
         _cmGroup = new SelectedButtonGroup();
         _cmGroup.addSelectItem(_contribute);
         _cmGroup.addSelectItem(_metal);
         _cmGroup.selectIndex = 0;
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_consortionSkill);
         _btnGroup.addSelectItem(_personalSkill);
         _btnGroup.selectIndex = 0;
         showContent(_btnGroup.selectIndex + 1);
      }
      
      private function cmGroupVisible(param1:Boolean) : void
      {
         _metal.visible = param1;
         _contribute.visible = param1;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _manager.addEventListener("click",__manageHandler);
         _btnGroup.addEventListener("change",__changeHandler);
         _cmGroup.addEventListener("change",__cmChangeHandler);
         ConsortionModelManager.Instance.addEventListener("skillStateChange",__stateChange);
         PlayerManager.Instance.Self.consortiaInfo.addEventListener("propertychange",__richChangeHandler);
         PlayerManager.Instance.Self.addEventListener("propertychange",__selfRichChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _manager.removeEventListener("click",__manageHandler);
         _btnGroup.removeEventListener("change",__changeHandler);
         _cmGroup.removeEventListener("change",__cmChangeHandler);
         ConsortionModelManager.Instance.removeEventListener("skillStateChange",__stateChange);
         PlayerManager.Instance.Self.consortiaInfo.removeEventListener("propertychange",__richChangeHandler);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__selfRichChangeHandler);
      }
      
      protected function __cmChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("008");
         showContent(_cmGroup.selectIndex + 2);
      }
      
      private function __richChangeHandler(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["riches"] && _btnGroup.selectIndex == 0)
         {
            _riches.text = String(PlayerManager.Instance.Self.consortiaInfo.Riches);
         }
      }
      
      private function __selfRichChangeHandler(param1:PlayerPropertyEvent) : void
      {
         if((param1.changedProperties["RichesRob"] || param1.changedProperties["RichesOffer"]) && _btnGroup.selectIndex == 1)
         {
            _riches.text = String(PlayerManager.Instance.Self.Riches);
         }
      }
      
      private function __stateChange(param1:ConsortionEvent) : void
      {
         showContent(_oldType);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function __manageHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         ConsortionModelManager.Instance.alertManagerFrame();
      }
      
      private function __changeHandler(param1:Event) : void
      {
         SoundManager.instance.play("008");
         showContent(_btnGroup.selectIndex + 1);
      }
      
      private function showContent(param1:int) : void
      {
         var _loc6_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         _oldType = param1;
         if(param1 == 1)
         {
            _scrollbg.height = 426;
            _scrollbg.y = 96;
            _panel.height = 412;
            _panel.y = 104;
            cmGroupVisible(false);
            _richesTxt.text = LanguageMgr.GetTranslation("consortion.skillFrame.richesText1");
         }
         else
         {
            _scrollbg.height = 395;
            _scrollbg.y = 128;
            _panel.height = 383;
            _panel.y = 136;
            cmGroupVisible(true);
            if(param1 == 2)
            {
               _richesTxt.text = LanguageMgr.GetTranslation("consortion.skillFrame.richesText2");
               _cmGroup.selectIndex = 0;
            }
            else
            {
               _richesTxt.text = LanguageMgr.GetTranslation("medalMoney");
               _cmGroup.selectIndex = 1;
            }
         }
         clearItem();
         _richbg.setFrame(param1);
         _riches.text = param1 == 1?String(PlayerManager.Instance.Self.consortiaInfo.Riches):param1 == 2?String(PlayerManager.Instance.Self.Riches):String(PlayerManager.Instance.Self.DDTMoney);
         _loc6_ = 0;
         while(_loc6_ < 10)
         {
            _loc2_ = _loc6_ + 1 > PlayerManager.Instance.Self.consortiaInfo.BufferLevel?false:true;
            _loc3_ = param1 == 3?true:false;
            _loc4_ = new ConsortionSkillItem(_loc6_ + 1,_loc2_,_loc3_);
            _loc5_ = param1 == 3?2:param1;
            _loc4_.data = ConsortionModelManager.Instance.model.getskillInfoWithTypeAndLevel(_loc5_,_loc6_ + 1);
            _vbox.addChild(_loc4_);
            _items.push(_loc4_);
            _loc6_++;
         }
         _panel.invalidateViewport();
      }
      
      private function clearItem() : void
      {
         var _loc1_:int = 0;
         if(_items)
         {
            _loc1_ = 0;
            while(_loc1_ < _items.length)
            {
               _items[_loc1_].dispose();
               _items[_loc1_] = null;
               _loc1_++;
            }
         }
         _items = new Vector.<ConsortionSkillItem>();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         clearItem();
         _items = null;
         super.dispose();
         _bg = null;
         _scrollbg = null;
         _metal = null;
         _cmGroup = null;
         _richesTxt = null;
         _richbg = null;
         _riches = null;
         _manager = null;
         _consortionSkill = null;
         _personalSkill = null;
         _btnGroup = null;
         _vbox = null;
         _panel = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
