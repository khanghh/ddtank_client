package bank.view
{
   import bank.BankManager;
   import bank.data.BankRecordInfo;
   import bank.data.GameBankEvent;
   import bank.view.mornui.bank.BankSaveOrGetUI;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import flash.events.MouseEvent;
   import morn.core.components.View;
   
   public class BankSaveOrGetView extends BankSaveOrGetUI
   {
       
      
      private var _viewType:int = 0;
      
      private var _viewArr:Array;
      
      private var _recodArr:Vector.<BankRecordInfo>;
      
      private var _rightView:View;
      
      private var _leftView:BankLeftView;
      
      private var _btnHelp:BaseButton;
      
      public function BankSaveOrGetView()
      {
         super();
         addEvent();
         initView();
      }
      
      private function initView() : void
      {
         have.text = LanguageMgr.GetTranslation("tank.bank.title.have");
         saveOrGetTitle.text = LanguageMgr.GetTranslation("tank.bank.title");
         _viewArr = [];
         _viewArr.push(new BankSaveView());
         _viewArr.push(new BankGetView());
         _viewArr.push(new BankSeeItemView());
         _leftView = new BankLeftView();
         addChild(_leftView);
         initData();
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonSmall",{
            "x":741,
            "y":5
         },LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.bank.view.help",408,488);
      }
      
      private function initData() : void
      {
         totleSaveMoney.text = String(BankManager.instance.totleSaveMoney);
         totleProfitMoney.text = String(BankManager.instance.totleProfitMoney);
         haveMoney.text = String(PlayerManager.Instance.Self.Money) + " " + LanguageMgr.GetTranslation("createConsortionFrame.ticketText.Text2");
         haveBindMoney.text = String(PlayerManager.Instance.Self.BandMoney) + " " + LanguageMgr.GetTranslation("consortion.skillFrame.richesText3");
      }
      
      private function __onChangeTypeView(param1:GameBankEvent) : void
      {
         viewType = param1.data.type;
      }
      
      private function __onViewBack(param1:GameBankEvent) : void
      {
         dispose();
         var _loc2_:BankMainFrameView = new BankMainFrameView();
         LayerManager.Instance.addToLayer(_loc2_,3,true,1);
      }
      
      private function changeView() : void
      {
         if(_rightView)
         {
            removeChild(_rightView);
         }
         _rightView = _viewArr[viewType - 1];
         if(viewType != 1)
         {
            if(viewType == 2)
            {
               (_rightView as BankGetView).setInfo(_leftView.currentPage,_leftView.index);
            }
            else
            {
               (_rightView as BankSeeItemView).setInfo(_leftView.currentPage,_leftView.index);
            }
         }
         addChild(_rightView);
      }
      
      private function addEvent() : void
      {
         close_btn.addEventListener("click",__closeView);
         BankManager.instance.addEventListener("bank_right_view_change",__onChangeTypeView);
         BankManager.instance.addEventListener("bank_right_view_back",__onViewBack);
         BankManager.instance.addEventListener("bank_save_success",__onSaveSuccess);
         BankManager.instance.addEventListener("bank_get_success",__onGetSuccess);
         BankManager.instance.addEventListener("bank_left_item_click",__onLeftItemClick);
      }
      
      private function removeEvent() : void
      {
         close_btn.removeEventListener("click",__closeView);
         BankManager.instance.removeEventListener("bank_right_view_change",__onChangeTypeView);
         BankManager.instance.removeEventListener("bank_right_view_back",__onViewBack);
         BankManager.instance.removeEventListener("bank_save_success",__onSaveSuccess);
         BankManager.instance.removeEventListener("bank_get_success",__onGetSuccess);
         BankManager.instance.removeEventListener("bank_left_item_click",__onLeftItemClick);
      }
      
      private function __onGetSuccess(param1:GameBankEvent) : void
      {
         initData();
         var _loc2_:String = LanguageMgr.GetTranslation("tank.bank.getSuccess");
         MessageTipManager.getInstance().show(_loc2_,0,true,1);
         if(BankManager.instance.model.list.length)
         {
            if(param1.data.isDelete)
            {
               if(_leftView.currentPage > 1 && _leftView.index == 0)
               {
                  _leftView.currentPage = _leftView.currentPage - 1;
               }
               else
               {
                  _leftView.currentPage = 1;
                  _leftView.index = 0;
               }
            }
            (_rightView as BankGetView).setInfo(_leftView.currentPage,_leftView.index);
         }
         else
         {
            viewType = 1;
         }
         _leftView.leftViewChange();
      }
      
      private function __onSaveSuccess(param1:GameBankEvent) : void
      {
         _leftView.leftViewChange();
         initData();
         var _loc2_:String = LanguageMgr.GetTranslation("tank.bank.saveSuccess");
         MessageTipManager.getInstance().show(_loc2_,0,true,1);
         _leftView.index = 0;
      }
      
      private function __onLeftItemClick(param1:GameBankEvent) : void
      {
         if(viewType == 1 && param1.data.isPageBtn)
         {
            return;
         }
         if(viewType != 2)
         {
            viewType = 3;
         }
         else
         {
            viewType = 2;
         }
      }
      
      private function __closeView(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      public function get viewType() : int
      {
         return _viewType;
      }
      
      public function set viewType(param1:int) : void
      {
         if(_viewType == param1 && _viewType == 1)
         {
            return;
         }
         _viewType = param1;
         changeView();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_btnHelp);
         _btnHelp = null;
         while(_viewArr.length)
         {
            ObjectUtils.disposeObject(_viewArr.shift());
         }
         _viewArr = null;
         ObjectUtils.disposeObject(_rightView);
         ObjectUtils.disposeObject(_leftView);
         super.dispose();
      }
   }
}
