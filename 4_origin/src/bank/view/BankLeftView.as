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
         var i:int = 0;
         var recordView:* = null;
         _recordItemarr = new Vector.<BankSaveRecordView>();
         _fourRecordItemArr = new Vector.<BankSaveRecordView>();
         for(i = 0; i < 3; )
         {
            recordView = new BankSaveRecordView(i);
            _fourRecordItemArr.push(recordView);
            recordView.y = recordView.y + i * 100;
            i++;
         }
         creatItem();
         pageNum.text = String(_currentPage) + "/" + String(_maxPage);
      }
      
      private function pageLeft(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         currentPage = _currentPage > 1?_currentPage - 1:_maxPage;
      }
      
      private function pageRight(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         currentPage = _currentPage < _maxPage?_currentPage + 1:1;
      }
      
      public function set currentPage(value:int) : void
      {
         if(_currentPage == value)
         {
            return;
         }
         _currentPage = value;
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
         var i:int = 0;
         if(BankManager.instance.model.list.length)
         {
            _maxPage = (BankManager.instance.model.list.length - 1) / 3 + 1;
         }
         pageNum.text = String(_currentPage) + "/" + String(_maxPage);
         for(i = 0; i < getCurrentItemNum(); )
         {
            _recordItemarr.push(_fourRecordItemArr[i]);
            _recordItemarr[i].setInfo(BankManager.instance.model.list[(currentPage - 1) * 3 + i]);
            addChild(_recordItemarr[i]);
            i++;
         }
      }
      
      private function getCurrentItemNum() : int
      {
         return currentPage == _maxPage?BankManager.instance.model.list.length - 3 * (currentPage - 1):3;
      }
      
      private function indexChange(e:GameBankEvent) : void
      {
         _index = e.data.index;
         lineChange();
      }
      
      private function lineChange() : void
      {
         var i:int = 0;
         for(i = 0; i < getCurrentItemNum(); )
         {
            if(index == i)
            {
               _recordItemarr[i].itemLine.visible = true;
            }
            else
            {
               _recordItemarr[i].itemLine.visible = false;
            }
            i++;
         }
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(value:int) : void
      {
         if(_index == value)
         {
            return;
         }
         _index = value;
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
