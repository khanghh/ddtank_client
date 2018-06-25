package ddt.data.email
{
   import ddt.events.EmailEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.TimeManager;
   import email.MailManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import road7th.utils.DateUtils;
   
   public class EmailModel extends EventDispatcher
   {
       
      
      public var isLoaded:Boolean = false;
      
      private var _sendedMails:Array;
      
      private var _noReadMails:Array;
      
      private var _emails:Array;
      
      private var _mailType:String = "all mails";
      
      private var _currentDate:Array;
      
      private var _state:String = "read";
      
      private var _currentPage:int = 1;
      
      private var _selectEmail:EmailInfo;
      
      public var lastTime:String;
      
      public function EmailModel(target:IEventDispatcher = null)
      {
         _sendedMails = [];
         _emails = [];
         super(target);
      }
      
      public function set sendedMails(value:Array) : void
      {
         _sendedMails = value;
         if(_mailType == "sended mails")
         {
            dispatchEvent(new EmailEvent("initEmail"));
         }
      }
      
      public function get sendedMails() : Array
      {
         return _sendedMails;
      }
      
      public function get noReadMails() : Array
      {
         return _noReadMails;
      }
      
      public function get emails() : Array
      {
         return _emails.slice(0);
      }
      
      public function set emails(value:Array) : void
      {
         var i:int = 0;
         var remain:Number = NaN;
         var j:* = 0;
         _emails = [];
         for(i = 0; i < value.length; )
         {
            remain = calculateRemainTime(value[i].SendTime,value[i].ValidDate);
            if(remain > -1)
            {
               _emails.push(value[i]);
            }
            i++;
         }
         for(j = uint(0); j < _emails.length; )
         {
            _emails[j].sendDate = DateUtils.getDateByStr(_emails[j].SendTime).valueOf();
            j++;
         }
         _emails.sortOn("sendDate",16 | 2);
         getNoReadMails();
         isLoaded = true;
         dispatchEvent(new EmailEvent("initEmail"));
      }
      
      public function getValidateMails(arr:Array) : Array
      {
         var i:int = 0;
         var ei:* = null;
         var result:Array = [];
         for(i = 0; i < arr.length; )
         {
            ei = arr[i] as EmailInfo;
            if(ei)
            {
               if(MailManager.Instance.calculateRemainTime(ei.SendTime,ei.ValidDate) > 0)
               {
                  result.push(ei);
               }
            }
            i++;
         }
         return result;
      }
      
      public function set mailType(value:String) : void
      {
         _mailType = value;
         resetModel();
         dispatchEvent(new EmailEvent("changeType"));
      }
      
      public function get mailType() : String
      {
         return _mailType;
      }
      
      public function get currentDate() : Array
      {
         var _loc1_:* = _mailType;
         if("all mails" !== _loc1_)
         {
            if("no read mails" !== _loc1_)
            {
               if("sended mails" !== _loc1_)
               {
                  _currentDate = _emails;
               }
               else
               {
                  _currentDate = _sendedMails;
               }
            }
            else
            {
               _currentDate = _noReadMails;
            }
         }
         else
         {
            _currentDate = _emails;
         }
         return _currentDate;
      }
      
      public function set state(value:String) : void
      {
         _state = value;
         dispatchEvent(new EmailEvent("changeState"));
      }
      
      public function get state() : String
      {
         return _state;
      }
      
      private function resetModel() : void
      {
         _currentPage = 1;
         selectEmail = null;
      }
      
      public function get totalPage() : int
      {
         if(currentDate)
         {
            if(currentDate.length == 0)
            {
               return 1;
            }
            return Math.ceil(currentDate.length / 7);
         }
         return 1;
      }
      
      public function get currentPage() : int
      {
         if(_currentPage > totalPage)
         {
            _currentPage = totalPage;
         }
         return _currentPage;
      }
      
      public function set currentPage(value:int) : void
      {
         _currentPage = value;
         dispatchEvent(new EmailEvent("changePage"));
      }
      
      public function getNoReadMails() : void
      {
         _noReadMails = [];
         var _loc3_:int = 0;
         var _loc2_:* = _emails;
         for each(var info in _emails)
         {
            if(SharedManager.Instance.spacialReadedMail[PlayerManager.Instance.Self.ID] && SharedManager.Instance.spacialReadedMail[PlayerManager.Instance.Self.ID].indexOf(info.ID) > -1)
            {
               info.IsRead = true;
            }
            if(!info.IsRead)
            {
               _noReadMails.push(info);
            }
         }
      }
      
      public function getMailByID(id:int) : EmailInfo
      {
         var i:* = 0;
         var le:int = _emails.length;
         for(i = uint(0); i < le; )
         {
            if((_emails[i] as EmailInfo).ID == id)
            {
               return _emails[i] as EmailInfo;
            }
            i++;
         }
         return null;
      }
      
      public function getViewData() : Array
      {
         var begin:int = 0;
         var end:int = 0;
         if(_mailType == "no read mails")
         {
            getNoReadMails();
         }
         var result:Array = [];
         if(currentDate)
         {
            begin = currentPage * 7 - 7;
            end = begin + 7 > currentDate.length?currentDate.length:begin + 7;
            result = currentDate.slice(begin,end);
         }
         if(result.length > 7)
         {
            trace("fdfdfd");
         }
         return result;
      }
      
      private function calculateRemainTime(startTime:String, validHours:Number) : Number
      {
         var str:* = startTime;
         var startDate:Date = new Date(Number(str.substr(0,4)),str.substr(5,2) - 1,Number(str.substr(8,2)),Number(str.substr(11,2)),Number(str.substr(14,2)),Number(str.substr(17,2)));
         var nowDate:Date = TimeManager.Instance.Now();
         var remain:Number = validHours - (nowDate.time - startDate.time) / 3600000;
         if(remain < 0)
         {
            return -1;
         }
         return remain;
      }
      
      public function get selectEmail() : EmailInfo
      {
         return _selectEmail;
      }
      
      public function set selectEmail(value:EmailInfo) : void
      {
         if(value)
         {
            if(_emails.indexOf(value) <= -1 && _sendedMails.indexOf(value) <= -1)
            {
               _selectEmail = null;
            }
            else
            {
               _selectEmail = value;
            }
         }
         else
         {
            _selectEmail = null;
         }
         dispatchEvent(new EmailEvent("selectEmail",_selectEmail));
      }
      
      public function addEmail(info:EmailInfo) : void
      {
         _emails.push(info);
         dispatchEvent(new EmailEvent("addEmail",info));
      }
      
      public function addEmailToSended(info:EmailInfoOfSended) : void
      {
         _sendedMails.unshift(info);
         if(_sendedMails.length > 21)
         {
            _sendedMails.pop();
         }
      }
      
      public function removeFromNoRead(info:EmailInfo) : void
      {
         var index:int = _noReadMails.indexOf(info);
         if(index > -1)
         {
            _noReadMails.splice(index,1);
         }
      }
      
      public function removeEmail(info:EmailInfo) : void
      {
         var index:int = _emails.indexOf(info);
         if(index > -1)
         {
            _emails.splice(index,1);
            getNoReadMails();
            dispatchEvent(new EmailEvent("removeEmail",info));
         }
      }
      
      public function changeEmail(info:EmailInfo) : void
      {
         var index:int = _emails.indexOf(info);
         info.IsRead = true;
         if(index > -1)
         {
            dispatchEvent(new EmailEvent("selectEmail",info));
         }
      }
      
      public function clearEmail() : void
      {
         _emails = [];
         dispatchEvent(new EmailEvent("clearEmail"));
      }
      
      public function dispose() : void
      {
         _emails = [];
      }
      
      public function hasUnReadEmail() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = _emails;
         for each(var info in _emails)
         {
            if(!info.IsRead)
            {
               return true;
            }
         }
         return false;
      }
      
      public function hasUnReadGiftEmail() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = _emails;
         for each(var info in _emails)
         {
            if(!info.IsRead && info.MailType == 1)
            {
               return true;
            }
         }
         return false;
      }
   }
}
