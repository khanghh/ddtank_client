package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.Helpers;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class DoubleSelectedItem extends Sprite implements IEventDispatcher
   {
      
      public static const BIND_TYPE:String = "bind";
      
      public static const NO_BIND_TYPE:String = "noBind";
      
      public static const EACH_TYPE:String = "each";
      
      private static const NOBIND:int = 1;
      
      private static const BIND:int = 0;
       
      
      private var _isBind:Boolean;
      
      private var _selectedBandBtn:SelectedCheckButton;
      
      private var _selectedBtn:SelectedCheckButton;
      
      private var _group1:SelectedButtonGroup;
      
      private var _bandMoneyTxt:FilterFrameText;
      
      private var _moneyTxt:FilterFrameText;
      
      private var _back:MovieClip;
      
      public function DoubleSelectedItem()
      {
         super();
         initView();
      }
      
      public function useMoneyType(param1:String) : void
      {
         var _loc2_:* = param1;
         if("bind" !== _loc2_)
         {
            if("noBind" !== _loc2_)
            {
               if("each" === _loc2_)
               {
                  _bandMoneyTxt.visible = true;
                  _selectedBandBtn.enable = true;
                  _selectedBandBtn.visible = true;
                  _moneyTxt.visible = true;
                  _selectedBtn.enable = true;
                  _selectedBtn.visible = true;
               }
            }
            else
            {
               _isBind = false;
               _bandMoneyTxt.visible = false;
               _selectedBandBtn.enable = false;
               _selectedBandBtn.visible = false;
               _moneyTxt.visible = true;
               _selectedBtn.enable = true;
               _selectedBtn.selected = true;
               _selectedBtn.visible = true;
            }
         }
         else
         {
            _isBind = true;
            _bandMoneyTxt.visible = true;
            _selectedBandBtn.enable = true;
            _selectedBandBtn.selected = true;
            _selectedBandBtn.visible = true;
            _moneyTxt.visible = false;
            _selectedBtn.enable = false;
            _selectedBtn.visible = false;
         }
      }
      
      public function lockMoneyType(param1:String) : void
      {
         var _loc2_:* = param1;
         if("bind" !== _loc2_)
         {
            if("noBind" !== _loc2_)
            {
               if("each" === _loc2_)
               {
                  _loc2_ = true;
                  _selectedBandBtn.mouseChildren = _loc2_;
                  _selectedBandBtn.mouseEnabled = _loc2_;
                  _selectedBandBtn.enable = true;
                  Helpers.colorful(_selectedBandBtn);
                  _loc2_ = true;
                  _selectedBtn.mouseChildren = _loc2_;
                  _selectedBtn.mouseEnabled = _loc2_;
                  _selectedBtn.enable = true;
                  Helpers.colorful(_selectedBtn);
                  _group1.selectIndex = 0;
                  _group1.addEventListener("change",changeHander);
               }
            }
            else
            {
               _loc2_ = false;
               _selectedBandBtn.mouseChildren = _loc2_;
               _selectedBandBtn.mouseEnabled = _loc2_;
               _selectedBandBtn.enable = false;
               Helpers.grey(_selectedBandBtn);
               _loc2_ = false;
               _selectedBtn.mouseChildren = _loc2_;
               _selectedBtn.mouseEnabled = _loc2_;
               _group1.selectIndex = 1;
               _group1.removeEventListener("change",changeHander);
            }
         }
         else
         {
            _loc2_ = false;
            _selectedBandBtn.mouseChildren = _loc2_;
            _selectedBandBtn.mouseEnabled = _loc2_;
            _loc2_ = false;
            _selectedBtn.mouseChildren = _loc2_;
            _selectedBtn.mouseEnabled = _loc2_;
            _selectedBtn.enable = false;
            Helpers.grey(_selectedBtn);
            _group1.selectIndex = 0;
            _group1.removeEventListener("change",changeHander);
         }
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creat("asset.core.stranDown");
         _back.x = 0;
         _back.y = 0;
         addChild(_back);
         _isBind = true;
         _selectedBandBtn = ComponentFactory.Instance.creatComponentByStylename("vip.core.selectBtn");
         _selectedBandBtn.x = 37;
         _selectedBandBtn.y = -16;
         _selectedBandBtn.selected = true;
         _selectedBandBtn.mouseEnabled = false;
         addChild(_selectedBandBtn);
         _selectedBtn = ComponentFactory.Instance.creatComponentByStylename("vip.core.selectBtn");
         _selectedBtn.x = -80;
         _selectedBtn.y = -16;
         addChild(_selectedBtn);
         _group1 = new SelectedButtonGroup();
         _group1.addSelectItem(_selectedBandBtn);
         _group1.addSelectItem(_selectedBtn);
         _bandMoneyTxt = ComponentFactory.Instance.creatComponentByStylename("vip.core.bandMoney");
         _bandMoneyTxt.text = LanguageMgr.GetTranslation("consortion.skillFrame.richesText3");
         _bandMoneyTxt.x = 25;
         _bandMoneyTxt.y = -8;
         addChild(_bandMoneyTxt);
         _moneyTxt = ComponentFactory.Instance.creatComponentByStylename("vip.core.bandMoney");
         _moneyTxt.text = LanguageMgr.GetTranslation("createConsortionFrame.ticketText.Text2");
         _moneyTxt.x = -108;
         _moneyTxt.y = -8;
         addChild(_moneyTxt);
         initEvents();
      }
      
      private function initEvents() : void
      {
         _group1.addEventListener("change",changeHander);
      }
      
      private function changeHander(param1:Event) : void
      {
         var _loc2_:int = _group1.selectIndex;
         switch(int(_loc2_))
         {
            case 0:
               _isBind = true;
               _selectedBtn.mouseEnabled = true;
               _selectedBandBtn.mouseEnabled = false;
               _selectedBtn.selected = false;
               _selectedBandBtn.selected = true;
               break;
            case 1:
               _isBind = false;
               _selectedBtn.mouseEnabled = false;
               _selectedBandBtn.mouseEnabled = true;
               _selectedBandBtn.selected = false;
               _selectedBtn.selected = true;
         }
         dispatchEvent(new Event("change"));
      }
      
      public function get isBind() : Boolean
      {
         return _isBind;
      }
      
      public function dispose() : void
      {
         _group1.dispose();
         _group1.removeEventListener("change",changeHander);
         _isBind = false;
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
      }
   }
}
