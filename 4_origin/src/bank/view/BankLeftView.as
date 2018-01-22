package bank.view
{
   import bank.BankManager;
   import bank.data.GameBankEvent;
   import bank.view.mornui.bank.BankLeftUI;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class BankLeftView extends BankLeftUI
   {
       
      
      private var _recordItemarr:Vector.<BankSaveRecordView>;
      
      private var _fourRecordItemArr:Vector.<BankSaveRecordView>;
      
      private var _index:int = 0;
      
      private var _currentPage:int = 1;
      
      private var _maxPage:int = 1;
      
      public function BankLeftView()
      {
         super();
         addEvent();
         initView();
      }
      
      private function addEvent() : void
      {
         BankManager.instance.addEventListener("bank_left_view_line_show",indexChange);
         leftBtn.addEventListener("click",pageLeft);
         rightBtn.addEventListener("click",pageRight);
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _recordItemarr = new Vector.<BankSaveRecordView>();
         _fourRecordItemArr = new Vector.<BankSaveRecordView>();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new BankSaveRecordView(_loc2_);
            _fourRecordItemArr.push(_loc1_);
            _loc1_.y = _loc1_.y + _loc2_ * 100;
            _loc2_++;
         }
         creatItem();
         pageNum.text = String(_currentPage) + "/" + String(_maxPage);
      }
      
      private function pageLeft(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         currentPage = _currentPage > 1?_currentPage - 1:_maxPage;
      }
      
      private function pageRight(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         currentPage = _currentPage < _maxPage?_currentPage + 1:1;
      }
      
      public function set currentPage(param1:int) : void
      {
         if(_currentPage == param1)
         {
            return;
         }
         _currentPage = param1;
         leftViewChange();
         _index = 0;
         lineChange();
         BankManager.instance.dispatchEvent(new GameBankEvent("bank_left_item_click",{"isPageBtn":true}));
      }
      
      public function get currentPage() : int
      {
         return _currentPage;
      }
      
      public function leftViewChange() : void
      {
         while(_recordItemarr.length)
         {
            removeChild(_recordItemarr.shift());
         }
         creatItem();
      }
      
      private function creatItem() : void
      {
         var _loc1_:int = 0;
         if(BankManager.instance.model.list.length)
         {
            _maxPage = (BankManager.instance.model.list.length - 1) / 3 + 1;
         }
         pageNum.text = String(_currentPage) + "/" + String(_maxPage);
         _loc1_ = 0;
         while(_loc1_ < getCurrentItemNum())
         {
            _recordItemarr.push(_fourRecordItemArr[_loc1_]);
            _recordItemarr[_loc1_].setInfo(BankManager.instance.model.list[(currentPage - 1) * 3 + _loc1_]);
            addChild(_recordItemarr[_loc1_]);
            _loc1_++;
         }
      }
      
      private function getCurrentItemNum() : int
      {
         return currentPage == _maxPage?BankManager.instance.model.list.length - 3 * (currentPage - 1):3;
      }
      
      private function indexChange(param1:GameBankEvent) : void
      {
         _index = param1.data.index;
         lineChange();
      }
      
      private function lineChange() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < getCurrentItemNum())
         {
            if(index == _loc1_)
            {
               _recordItemarr[_loc1_].itemLine.visible = true;
            }
            else
            {
               _recordItemarr[_loc1_].itemLine.visible = false;
            }
            _loc1_++;
         }
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(param1:int) : void
      {
         if(_index == param1)
         {
            return;
         }
         _index = param1;
         lineChange();
      }
      
      private function removeEvent() : void
      {
         BankManager.instance.removeEventListener("bank_left_view_line_show",indexChange);
         leftBtn.removeEventListener("click",pageLeft);
         rightBtn.removeEventListener("click",pageRight);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         while(_fourRecordItemArr.length)
         {
            ObjectUtils.disposeObject(_fourRecordItemArr.shift());
         }
         _fourRecordItemArr = null;
         _recordItemarr = null;
         super.dispose();
      }
   }
}
