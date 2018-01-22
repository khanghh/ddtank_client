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
      
      public function EmailModel(param1:IEventDispatcher = null)
      {
         _sendedMails = [];
         _emails = [];
         super(param1);
      }
      
      public function set sendedMails(param1:Array) : void
      {
         _sendedMails = param1;
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
      
      public function set emails(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Number = NaN;
         var _loc3_:* = 0;
         _emails = [];
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc2_ = calculateRemainTime(param1[_loc4_].SendTime,param1[_loc4_].ValidDate);
            if(_loc2_ > -1)
            {
               _emails.push(param1[_loc4_]);
            }
            _loc4_++;
         }
         _loc3_ = uint(0);
         while(_loc3_ < _emails.length)
         {
            _emails[_loc3_].sendDate = DateUtils.getDateByStr(_emails[_loc3_].SendTime).valueOf();
            _loc3_++;
         }
         _emails.sortOn("sendDate",16 | 2);
         getNoReadMails();
         isLoaded = true;
         dispatchEvent(new EmailEvent("initEmail"));
      }
      
      public function getValidateMails(param1:Array) : Array
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = param1[_loc4_] as EmailInfo;
            if(_loc3_)
            {
               if(MailManager.Instance.calculateRemainTime(_loc3_.SendTime,_loc3_.ValidDate) > 0)
               {
                  _loc2_.push(_loc3_);
               }
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function set mailType(param1:String) : void
      {
         _mailType = param1;
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
      
      public function set state(param1:String) : void
      {
         _state = param1;
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
      
      public function set currentPage(param1:int) : void
      {
         _currentPage = param1;
         dispatchEvent(new EmailEvent("changePage"));
      }
      
      public function getNoReadMails() : void
      {
         _noReadMails = [];
         var _loc3_:int = 0;
         var _loc2_:* = _emails;
         for each(var _loc1_ in _emails)
         {
            if(SharedManager.Instance.spacialReadedMail[PlayerManager.Instance.Self.ID] && SharedManager.Instance.spacialReadedMail[PlayerManager.Instance.Self.ID].indexOf(_loc1_.ID) > -1)
            {
               _loc1_.IsRead = true;
            }
            if(!_loc1_.IsRead)
            {
               _noReadMails.push(_loc1_);
            }
         }
      }
      
      public function getMailByID(param1:int) : EmailInfo
      {
         var _loc3_:* = 0;
         var _loc2_:int = _emails.length;
         _loc3_ = uint(0);
         while(_loc3_ < _loc2_)
         {
            if((_emails[_loc3_] as EmailInfo).ID == param1)
            {
               return _emails[_loc3_] as EmailInfo;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function getViewData() : Array
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(_mailType == "no read mails")
         {
            getNoReadMails();
         }
         var _loc1_:Array = [];
         if(currentDate)
         {
            _loc3_ = currentPage * 7 - 7;
            _loc2_ = _loc3_ + 7 > currentDate.length?currentDate.length:_loc3_ + 7;
            _loc1_ = currentDate.slice(_loc3_,_loc2_);
         }
         if(_loc1_.length > 7)
         {
            trace("fdfdfd");
         }
         return _loc1_;
      }
      
      private function calculateRemainTime(param1:String, param2:Number) : Number
      {
         var _loc5_:* = param1;
         var _loc3_:Date = new Date(Number(_loc5_.substr(0,4)),_loc5_.substr(5,2) - 1,Number(_loc5_.substr(8,2)),Number(_loc5_.substr(11,2)),Number(_loc5_.substr(14,2)),Number(_loc5_.substr(17,2)));
         var _loc6_:Date = TimeManager.Instance.Now();
         var _loc4_:Number = param2 - (_loc6_.time - _loc3_.time) / 3600000;
         if(_loc4_ < 0)
         {
            return -1;
         }
         return _loc4_;
      }
      
      public function get selectEmail() : EmailInfo
      {
         return _selectEmail;
      }
      
      public function set selectEmail(param1:EmailInfo) : void
      {
         if(param1)
         {
            if(_emails.indexOf(param1) <= -1 && _sendedMails.indexOf(param1) <= -1)
            {
               _selectEmail = null;
            }
            else
            {
               _selectEmail = param1;
            }
         }
         else
         {
            _selectEmail = null;
         }
         dispatchEvent(new EmailEvent("selectEmail",_selectEmail));
      }
      
      public function addEmail(param1:EmailInfo) : void
      {
         _emails.push(param1);
         dispatchEvent(new EmailEvent("addEmail",param1));
      }
      
      public function addEmailToSended(param1:EmailInfoOfSended) : void
      {
         _sendedMails.unshift(param1);
         if(_sendedMails.length > 21)
         {
            _sendedMails.pop();
         }
      }
      
      public function removeFromNoRead(param1:EmailInfo) : void
      {
         var _loc2_:int = _noReadMails.indexOf(param1);
         if(_loc2_ > -1)
         {
            _noReadMails.splice(_loc2_,1);
         }
      }
      
      public function removeEmail(param1:EmailInfo) : void
      {
         var _loc2_:int = _emails.indexOf(param1);
         if(_loc2_ > -1)
         {
            _emails.splice(_loc2_,1);
            getNoReadMails();
            dispatchEvent(new EmailEvent("removeEmail",param1));
         }
      }
      
      public function changeEmail(param1:EmailInfo) : void
      {
         var _loc2_:int = _emails.indexOf(param1);
         param1.IsRead = true;
         if(_loc2_ > -1)
         {
            dispatchEvent(new EmailEvent("selectEmail",param1));
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
         for each(var _loc1_ in _emails)
         {
            if(!_loc1_.IsRead)
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
         for each(var _loc1_ in _emails)
         {
            if(!_loc1_.IsRead && _loc1_.MailType == 1)
            {
               return true;
            }
         }
         return false;
      }
   }
}
