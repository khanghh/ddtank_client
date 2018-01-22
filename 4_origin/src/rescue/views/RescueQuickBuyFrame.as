package rescue.views
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.NumberSelecter;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class RescueQuickBuyFrame extends Frame
   {
       
      
      private var _bg:Image;
      
      private var _itemBmp:Bitmap;
      
      private var _number:NumberSelecter;
      
      private var _selectedBtn:SelectedCheckButton;
      
      private var _selectedBandBtn:SelectedCheckButton;
      
      private var _totalTipText:FilterFrameText;
      
      protected var totalText:FilterFrameText;
      
      private var _moneyTxt:FilterFrameText;
      
      private var _bandMoney:FilterFrameText;
      
      private var _submitButton:TextButton;
      
      private var _movieBack:MovieClip;
      
      private var _type:int;
      
      private var _perPrice:int;
      
      protected var _isBand:Boolean;
      
      public function RescueQuickBuyFrame()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy");
         _bg = ComponentFactory.Instance.creatComponentByStylename("ddtcore.CellBg");
         addToContent(_bg);
         _number = ComponentFactory.Instance.creatCustomObject("ddtcore.numberSelecter");
         addToContent(_number);
         _movieBack = ComponentFactory.Instance.creat("asset.core.stranDown");
         _movieBack.x = 176;
         _movieBack.y = 116;
         addToContent(_movieBack);
         _selectedBtn = ComponentFactory.Instance.creatComponentByStylename("vip.core.selectBtn");
         _selectedBtn.enable = true;
         _selectedBtn.selected = false;
         _selectedBtn.x = 83;
         _selectedBtn.y = 101;
         addToContent(_selectedBtn);
         _isBand = true;
         _selectedBandBtn = ComponentFactory.Instance.creatComponentByStylename("vip.core.selectBtn");
         _selectedBandBtn.enable = false;
         _selectedBandBtn.selected = true;
         _selectedBandBtn.x = 183;
         _selectedBandBtn.y = 101;
         addToContent(_selectedBandBtn);
         _totalTipText = ComponentFactory.Instance.creatComponentByStylename("ddtcore.TotalTipsText");
         _totalTipText.text = LanguageMgr.GetTranslation("ddt.QuickFrame.TotalTipText");
         addToContent(_totalTipText);
         totalText = ComponentFactory.Instance.creatComponentByStylename("ddtcore.TotalText");
         addToContent(totalText);
         _moneyTxt = ComponentFactory.Instance.creatComponentByStylename("vip.core.bandMoney");
         _moneyTxt.x = 55;
         _moneyTxt.y = 107;
         _moneyTxt.text = LanguageMgr.GetTranslation("ddt.money");
         addToContent(_moneyTxt);
         _bandMoney = ComponentFactory.Instance.creatComponentByStylename("vip.core.bandMoney");
         _bandMoney.x = 173;
         _bandMoney.y = 107;
         _bandMoney.text = LanguageMgr.GetTranslation("ddt.bandMoney");
         addToContent(_bandMoney);
         refreshNumText();
         _submitButton = ComponentFactory.Instance.creatComponentByStylename("ddtcore.quickEnter");
         _submitButton.text = LanguageMgr.GetTranslation("store.view.shortcutBuy.buyBtn");
         addToContent(_submitButton);
         _submitButton.y = 148;
      }
      
      private function initEvents() : void
      {
         addEventListener("response",__frameEventHandler);
         _selectedBtn.addEventListener("click",seletedHander);
         _selectedBandBtn.addEventListener("click",selectedBandHander);
         _number.addEventListener("change",selectHandler);
         _submitButton.addEventListener("click",__buyBuff);
      }
      
      protected function __buyBuff(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         CheckMoneyUtils.instance.checkMoney(_isBand,getNeedMoney(),onCheckComplete);
      }
      
      protected function onCheckComplete() : void
      {
         SocketManager.Instance.out.sendRescueBuyBuff(_type,_number.number,CheckMoneyUtils.instance.isBind);
         dispose();
      }
      
      protected function selectedBandHander(param1:MouseEvent) : void
      {
         if(_selectedBandBtn.selected)
         {
            _isBand = true;
            _selectedBandBtn.enable = false;
            _selectedBtn.selected = false;
            _selectedBtn.enable = true;
         }
         else
         {
            _isBand = false;
         }
         refreshNumText();
      }
      
      protected function seletedHander(param1:MouseEvent) : void
      {
         if(_selectedBtn.selected)
         {
            _isBand = false;
            _selectedBandBtn.selected = false;
            _selectedBandBtn.enable = true;
            _selectedBtn.enable = false;
         }
         else
         {
            _isBand = true;
         }
         refreshNumText();
      }
      
      private function reConfirmHandler(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         var _loc3_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc3_.removeEventListener("response",reConfirmHandler);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc2_ = getNeedMoney();
            if(PlayerManager.Instance.Self.Money < _loc2_)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.sendRescueBuyBuff(_type,_number.number,false);
            dispose();
         }
      }
      
      private function getNeedMoney() : int
      {
         return _perPrice * _number.number;
      }
      
      private function selectHandler(param1:Event) : void
      {
         refreshNumText();
      }
      
      protected function refreshNumText() : void
      {
         var _loc1_:String = String(_number.number * _perPrice);
         var _loc2_:String = !!_isBand?LanguageMgr.GetTranslation("ddtMoney"):LanguageMgr.GetTranslation("money");
         totalText.text = _loc1_ + " " + _loc2_;
      }
      
      public function setData(param1:int, param2:int) : void
      {
         _type = param1;
         _perPrice = param2;
         switch(int(_type))
         {
            case 0:
               _itemBmp = ComponentFactory.Instance.creat("rescue.arrow");
               break;
            case 1:
               _itemBmp = ComponentFactory.Instance.creat("rescue.bloodBag");
               break;
            case 2:
               _itemBmp = ComponentFactory.Instance.creat("rescue.kingBless");
         }
         if(_itemBmp)
         {
            addToContent(_itemBmp);
            _itemBmp.scaleX = 0.6;
            _itemBmp.scaleY = 0.6;
            _itemBmp.x = 30;
            _itemBmp.y = 34;
            _itemBmp.smoothing = true;
         }
         refreshNumText();
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function removeEvnets() : void
      {
         removeEventListener("response",__frameEventHandler);
         _selectedBtn.removeEventListener("click",seletedHander);
         _selectedBandBtn.removeEventListener("click",selectedBandHander);
         _number.removeEventListener("change",selectHandler);
         _submitButton.removeEventListener("click",__buyBuff);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvnets();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_itemBmp);
         _itemBmp = null;
         ObjectUtils.disposeObject(_selectedBtn);
         _selectedBtn = null;
         ObjectUtils.disposeObject(_selectedBandBtn);
         _selectedBandBtn = null;
         ObjectUtils.disposeObject(_totalTipText);
         _totalTipText = null;
         ObjectUtils.disposeObject(totalText);
         totalText = null;
         ObjectUtils.disposeObject(_moneyTxt);
         _moneyTxt = null;
         ObjectUtils.disposeObject(_bandMoney);
         _bandMoney = null;
         ObjectUtils.disposeObject(_submitButton);
         _submitButton = null;
         ObjectUtils.disposeObject(_movieBack);
         _movieBack = null;
      }
   }
}
